without type_check
----------------------------------------------------------------------------
-- browser.ex made by gareth mc daid
-- friday 23 september 2005 16:21:12
-- version 0.1 copyright 2005
-- 
-- what it is
-- Browser Is A File Manager
--
----------------------------------------------------------------------------
include graphics.e
include machine.e
include get.e
include file.e
include font.e
include database.e
include wildcard.e

sequence temp, d, d2, line, line2, line3
atom key, test, number1, number2, number11, number22, row, sel, sel2, drive
atom number111, number222, sel3
atom no_del, write, mode, edit, recover
temp=current_dir()
row=1
sel=1
sel2=1
drive=0
if graphics_mode(18) then
end if

function real(sequence a)
atom number, var
number=a[1]
if number='1' then
var=1
elsif number='2' then
var=2
elsif number='3' then
var=3
elsif number='0' then
var=0
end if
return var
end function

function remove_line(sequence string, atom line)
sequence temp
temp={}
  for i=1 to length(string) do
     if i=line then
     else
     temp=append(temp,string[i])
     end if
  end for
return temp
end function

function read_file(sequence string)
sequence buffer
object line
integer fn
fn = open(string, "rb")
 if fn = -1 then
   return ""
 end if
buffer = {}
while 1 do
 line = gets(fn)
 if atom(line) then
  exit   
 end if
 buffer = append(buffer, line)
end while
close(fn)
return buffer
end function

procedure write_file(sequence string, sequence string1)
integer fn
fn = open(string, "wb")
 if fn = -1 then
 end if
for i=1 to length(string1) do
puts(fn,string1[i])
end for
close(fn)
end procedure

procedure save_settings()

end procedure

procedure defalut_load()
write_file("browser.ini","1 0 1 0 1 ")
no_del=1   
write=0    
mode=1     
edit=0     
recover=1
end procedure

procedure load_settings()
sequence settings, cmd
atom pos
pos=1
cmd={}
settings=read_file(upper("browser.ini"))
if length(settings)>0 then
  for i=1 to length(settings) do
     for j=1 to length(settings[i]) do
       if settings[i][j]=32 then
         cmd=append(cmd,settings[i][pos..j-1])
         pos=j+1
       end if
     end for
  end for
no_del=real(cmd[1])
write=real(cmd[2])
mode=real(cmd[3])
edit=real(cmd[4])
recover=real(cmd[5])
else
defalut_load()
end if
end procedure

load_settings()

if recover=1 then
if db_open("recycle", DB_LOCK_NO) != DB_OK then
  if db_create("recycle", DB_LOCK_NO) != DB_OK then
    puts(1,"err")
  end if
  if db_create_table("files") != DB_OK then
    puts(1,"err")
  end if
end if
if db_select_table("files") != DB_OK then
  puts(1,"err")
end if
end if

procedure add_info(sequence key, sequence data)
atom f
f = db_find_key(key)
if f >= 1 then
db_replace_data(f, data)
else
if db_insert(key, data) != DB_OK then
  puts(1,"err")
end if
end if
end procedure

function date2()
sequence info, temp
info=date()
if info[7]=1 then
  info[7]="sunday "
elsif info[7]=2 then
  info[7]="monday "
elsif info[7]=3 then
  info[7]="tuseday "
elsif info[7]=4 then
  info[7]="wensaday "
elsif info[7]=5 then
  info[7]="thrusday "
elsif info[7]=6 then
  info[7]="friday "
elsif info[7]=7 then
  info[7]="saturday "
end if
if info[2]=1 then
  info[2]="jan "
elsif info[2]=2 then
  info[2]="feb "
elsif info[2]=3 then
  info[2]="mar "
elsif info[2]=4 then
  info[2]="apr "
elsif info[2]=5 then
  info[2]="may "
elsif info[2]=6 then
  info[2]="jun "
elsif info[2]=7 then
  info[2]="jul "
elsif info[2]=8 then
  info[2]="arg "
elsif info[2]=9 then
  info[2]="sep "
elsif info[2]=10 then
  info[2]="oct "
elsif info[2]=11 then
  info[2]="nov "
elsif info[2]=12 then
  info[2]="dec "
end if
info[1]="2"&"0"&"0"&sprintf("%d",info[1]-100)
temp=info[7]
temp&=sprintf("%d",info[3])&" "
temp&=info[2]
temp&=info[1]&" "
temp&=sprintf("%d",info[4])&":"
if info[5]<10 then
temp&="0"&sprintf("%d",info[5])&":"
else
temp&=sprintf("%d",info[5])&":"
end if
if info[6]<10 then
  temp&="0"&sprintf("%d",info[6])
else
temp&=sprintf("%d",info[6])
end if
return temp
end function

function merge_sort(sequence x)
integer n, mid
sequence merged, a, b
n = length(x)
if n = 0 or n = 1 then
return x 
end if
mid = floor(n/2)
a = merge_sort(x[1..mid])     
b = merge_sort(x[mid+1..n])   
merged = {}
while length(a) > 0 and length(b) > 0 do
if compare(a[1], b[1]) < 0 then
merged = append(merged, a[1])
a = a[2..length(a)]
else
merged = append(merged, b[1])
b = b[2..length(b)]
end if
end while
return merged & a & b 
end function

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

procedure init()
sequence temp, data
temp={}
line={}
line2={}
line3={}
sel2=1
sel3=1
if mode=1 then
  d = dir(current_dir())
  for i=1 to length(d) do
  test= compare(d[i][2],"d") 
  if test=0 then
  line=append(line,d[i][1])
  end if
  end for
  d2 = dir(current_dir())
  for i=1 to length(d2) do
  test= compare(d2[i][2],"d") 
  if test!=0 then
  line2=append(line2,d2[i][1])
  end if
  end for
  line=merge_sort(line)
  for i=1 to length(line) do
  if compare(line[i],"..")=0 then
  else
  temp=append(temp,line[i])
  end if
  end for
  line=temp
  temp=""
  if no_del=1 then
  for i=1 to length(line2) do
  if compare(line2[i],upper("recycle.edb"))=0 then
  else
  temp=append(temp,line2[i])
  end if
  end for
  line2=temp
  temp=""
  end if
  line2=merge_sort(line2)
  number1=1
  number2=0
  if length(line)>20 then
  number2=length(line)-20
  end if
  number11=1
  number22=0
  if length(line2)>20 then
  number22=length(line2)-20
  end if
  if sel>length(line2) then
  sel=length(line2)
  else
  end if
elsif mode=2 then
  for rec = 1 to db_table_size() do
     data=db_record_data(rec)
     line3=append(line3,{db_record_key(rec),data[1],data[2],data[3]})
  end for
  number111=1
  number222=0
  if length(line3)>20 then
  number222=length(line3)-20
  end if
end if
end procedure
bk_color(BLUE)
clear_screen()

procedure draw()
if mode=1 then
  position(1,35)
  puts(1,"File Browser")
  position(2,4)
  puts(1,"Command Keys")
  position(2,17)
  text_color(RED)
  puts(1,"Delete")
  position(2,24)
  text_color(RED)
  puts(1,"Enter")
  position(2,30)
  text_color(RED)
  puts(1,"S")
  position(2,31)
  text_color(WHITE)
  puts(1,"creen")
  position(2,37)
  text_color(RED)
  puts(1,"E")
  position(2,38)
  text_color(WHITE)
  puts(1,"xit")
  position(2,42)
  text_color(RED)
  puts(1,"C")
  position(2,43)
  text_color(WHITE)
  puts(1,"opy")
--  position(2,47)
--  text_color(RED)
--  puts(1,"M")
--  position(2,48)
--  text_color(WHITE)
--  puts(1,"ove")
  for i=1 to 20 do
  rectangle(20,40+(20*i),120,40+(20*i)+20,0,1)
  rectangle(140,40+(20*i),240,40+(20*i)+20,0,1)
  rectangle(20,40+(20*i),120,40+(20*i)+20,7,0)
  rectangle(140,40+(20*i),240,40+(20*i)+20,7,0)
  end for
  for i=number1 to length(line)-number2 do
  rectangle(21,40+(20*(i-number1+1))+1,119,40+(20*(i-number1+1))+19,0,1)
  if i=sel2 and row=1 then
  rectangle(20,40+(20*(i-number1+1)),120,40+(20*(i-number1+1))+20,RED,1)
  draw_text({24,40+(20*(i-number1+1))+4},line[i],7,-1,0)
  else
  rectangle(20,40+(20*(i-number1+1)),120,40+(20*(i-number1+1))+20,7,0)
  draw_text({24,40+(20*(i-number1+1))+4},line[i],7,0,0)
  end if
  end for
  for i=number11 to length(line2)-number22 do
  rectangle(141,40+(20*(i-number11+1))+1,239,40+(20*(i-number11+1))+19,0,1)
  if i=sel and row=2 then
  rectangle(140,40+(20*(i-number11+1)),240,40+(20*(i-number11+1))+20,RED,1)
  draw_text({144,40+(20*(i-number11+1))+4},line2[i],7,-1,0)
  else
  rectangle(140,40+(20*(i-number11+1)),240,40+(20*(i-number11+1))+20,7,0)
  draw_text({144,40+(20*(i-number11+1))+4},line2[i],7,0,0)
  end if
  end for
  if row=1 then
  rectangle(20,40,120,60,GREEN,1)
  draw_text({24,44},"Directory",RED,-1,0)
  rectangle(140,40,240,60,YELLOW,1)
  draw_text({144,44},"File",RED,-1,0)
  end if
  if row=2 then
  rectangle(20,40,120,60,YELLOW,1)
  draw_text({24,44},"Directory",RED,-1,0)
  rectangle(140,40,240,60,GREEN,1)
  draw_text({144,44},"File",RED,-1,0)
  end if
elsif mode=2 then
  position(1,33)
  puts(1,"File Recovery")
  position(2,4)
  puts(1,"Command Keys")
  position(2,17)
  text_color(RED)
  puts(1,"Delete")
  position(2,24)
  text_color(RED)
  puts(1,"S")
  position(2,25)
  text_color(WHITE)
  puts(1,"creen")
  position(2,31)
  text_color(RED)
  puts(1,"E")
  position(2,32)
  text_color(WHITE)
  puts(1,"xit")
  position(2,36)
  text_color(RED)
  puts(1,"R")
  position(2,37)
  text_color(WHITE)
  puts(1,"ecovery")
  position(2,45)
  text_color(RED)
  puts(1,"A")
  position(2,46)
  text_color(WHITE)
  puts(1,"ll_Delete")
--  position(2,56)
--  text_color(RED)
--  puts(1,"C")
--  position(2,57)
--  text_color(WHITE)
--  puts(1,"opy")
--  position(2,61)
--  text_color(RED)
--  puts(1,"M")
--  position(2,62)
--  text_color(WHITE)
--  puts(1,"ove")
  for i=number111 to length(line3)-number222 do
  rectangle(1,40+(20*(i-number111+1))+1,600,40+(20*(i-number111+1))+19,0,1)
  if i=sel3 then
  rectangle(1,40+(20*(i-number111+1)),600,40+(20*(i-number111+1))+20,RED,1)
  draw_text({4,40+(20*(i-number111+1))+4},line3[i][1],7,-1,0)
  draw_text({104,40+(20*(i-number111+1))+4},line3[i][2],7,-1,0)
  draw_text({370,40+(20*(i-number111+1))+4},line3[i][3],7,-1,0)
  else
  rectangle(1,40+(20*(i-number111+1)),600,40+(20*(i-number111+1))+20,7,0)
  draw_text({4,40+(20*(i-number111+1))+4},line3[i][1],7,0,0)
  draw_text({104,40+(20*(i-number111+1))+4},line3[i][2],7,0,0)
  draw_text({370,40+(20*(i-number111+1))+4},line3[i][3],7,0,0)
  end if
  end for
  key=get_key()
end if
text_color(WHITE)
position(1,1)
end procedure

init()
draw()

function back_dir()
sequence temp, info, name
atom pos
info={}
name=""
temp=current_dir()&{92}
pos=1
for i=1 to length(temp) do
   if temp[i]=92 then
     info=append(info,temp[pos..i])
     pos=i+1
   end if
end for
if length(info)=2 then
  drive=1
  return info[1]
end if
for i=1 to length(info)-1 do
   name&=info[i]
end for
drive=0
return name[1..length(name)-1]
end function

function next_dir()
sequence temp, info
atom pos
info={}
temp=current_dir()&{92}
pos=1
for i=1 to length(temp) do
   if temp[i]=92 then
     info=append(info,temp[pos..i])
     pos=i+1
   end if
end for
for i=1 to length(info) do
   if info[i][1]=92 then
     info=remove_line(info,i)
   end if
end for
if length(info)=1 then
  drive=0
  return current_dir()&line[sel2]
end if
drive=0
return current_dir()&"\\"&line[sel2]
end function

procedure show(atom fn,object key, object data)
    puts(fn,key&"\n")
    puts(fn,data[1]&"\n")
    puts(fn,data[2]&"\n")
    for i = 1 to length(data[3]) do
        puts(fn,data[3][i])
    end for
end procedure

procedure delete_key(sequence name)
atom d
d = db_find_key(name)
db_delete_record(d)
end procedure

function key_exsits(object key)
for rec = 1 to db_table_size() do
   if compare(db_record_key(rec),key)=0 then
     return 1
   end if
end for
return 0
end function

procedure write_all()
atom fn
fn = open("all.txt", "wb")
 if fn = -1 then
 end if
for rec = 1 to db_table_size() do
     show(fn,db_record_key(rec), db_record_data(rec) )
end for
close(fn)
end procedure

if write=1 then
write_all()
end if

while 1 do
key=get_key()
if key != -1 then
 if key=27 then
    bk_color(BLACK)
    clear_screen()
    exit
 end if
 if key='r' and recover=1 then
 if mode=2 then
   if length(line3)>0 then
   if key_exsits(line3[sel3][1])=1 then
   if compare(prompt_string("Do You Want To Recovery File "&line3[sel3][1]&" To "&line3[sel3][2]&" Yes or NO? "),"y") =0 then
   if chdir(line3[sel3][2])=1 then
   write_file(line3[sel3][1],line3[sel3][4])
   delete_key(line3[sel3][1])
   else
   position(1,1)
   puts(1,"                                                                        ")
   position(1,1)
   puts(1,"Recovery Err Path Dose Not Exsits ")
   position(2,1)
   puts(1,"                                                                             ")
   position(2,1)
   if compare(prompt_string("Do You Want To Recovery File To A Path Yes or NO? "),"y") =0 then
   position(2,1)
   puts(1,"                                                                        ")
   position(2,1)
   write_file(prompt_string("Enter A Path? ")&line3[sel3][1],line3[sel3][4])
   delete_key(line3[sel3][1])
   end if
   end if
   end if
   position(1,1)
   end if
   clear_screen()
   init()
   draw()
   end if
 end if
 end if
 if key='c' then
 if mode=1 then
   if length(line2)>0 then
   if drive=0 then
   if compare(prompt_string("Do You Want To Copy File "&line2[sel]&" Yes or NO? "),"y") =0 then
   system("copy /b "&current_dir()&{92}&line2[sel]&" "&prompt_string("Enter A Path? ")&line2[sel],2)
   end if
   elsif drive=1 then
   if compare(prompt_string("Do You Want To Copy File "&line2[sel]&" Yes or NO? "),"y") =0 then
   system("copy /b "&current_dir()&line2[sel]&" "&prompt_string("Enter A Path? ")&line2[sel],2)
   end if
   end if
   end if
 elsif mode=2 then
 end if
 clear_screen()
 init()
 draw()
 end if
 if key='m' then
 if mode=1 then
 elsif mode=2 then
 end if
 end if
 if key='e' then
 if mode=2 then
   if compare(prompt_string("Do You Want To Exit File Recovery Version 1 Yes or NO? "),"y") =0 then
   bk_color(BLACK)
   clear_screen()
   exit
   end if
   elsif mode=1 then
   if compare(prompt_string("Do You Want To Exit File Browser Version 1 Yes or NO? "),"y") =0 then
   bk_color(BLACK)
   clear_screen()
   exit
   end if
   clear_screen()
   init()
   draw()
 end if
 end if
 if key='a' and recover=1 then
 if mode=2 then
   if length(line3)>0 then
   if compare(prompt_string("Do You Want To Delete All Files In Recovery Yes or NO? "),"y") =0 then
   for i=1 to length(line3) do
   delete_key(line3[i][1])
   end for
   end if
   clear_screen()
   init()
   draw()
   end if
 end if
 end if
   if key='s' then
   clear_screen()
   if mode=1 then
     if recover=1 then
     mode=2
     init()
     draw()
     else
     init()
     draw()
     end if
     elsif mode=2 then
     mode=1
     init()
     draw()
   end if
   end if
   if key=331 then
     if mode=1 then
     row=1
     draw()
   end if
   end if
   if key=333 then
     if mode=1 then
     row=2
     draw()
   end if
   end if
   if key=328 then
   if mode=1 then
     if row=1 then
     if sel2>1 then
     if sel2-number1=0 then
     number1-=1
     number2+=1
     sel2-=1
     draw()
     else
     sel2-=1
     draw()
     end if
     end if
     elsif row=2 then
     if sel>1 then
     if sel-number11=0 then
     number11-=1
     number22+=1
     sel-=1
     draw()
     else
     sel-=1
     draw()
     end if
     end if
     end if
     elsif mode=2 then
     if sel3>1 then
     if sel3-number111=0 then
     number111-=1
     number222+=1
     sel3-=1
     draw()
     else
     sel3-=1
     draw()
     end if
     end if
   end if
   end if
   if key=336 then
   if mode=1 then
     if row=1 then
     if sel2<length(line) then
     if sel2-number1=19 then
     number1+=1
     number2-=1
     sel2+=1
     draw()
     else
     sel2+=1
     draw()
     end if
     end if
     elsif row=2 then
     if sel<length(line2) then
     if sel-number11=19 then
     number11+=1
     number22-=1
     sel+=1
     draw()
     else
     sel+=1
     draw()
     end if
     end if
     end if
     elsif mode=2 then
     if sel3<length(line3) then
     if sel3-number111=19 then
     number111+=1
     number222-=1
     sel3+=1
     draw()
     else
     sel3+=1
     draw()
     end if
     end if
   end if
   end if
   if key=13 then
   if mode=1 then
     if row=1 then
     if line[sel2][1]='.' then
     if  chdir(back_dir())=1 then
     init()
     draw()
     end if
     else
     if  chdir(next_dir())=1 then
     init()
     draw()
     end if
     end if
     end if
     if length(line2)>0 then
     if row=2 and edit=1 then
      system(prompt_string("Enter A Program To "&line2[sel]&" Open With ?")&" "&line2[sel],2)
     end if
     bk_color(1)
     clear_screen()
     init()
     draw()
     end if
     elsif mode=2 then
   end if
   end if
   if key=339 then
   if mode=1 then
     if row=2 then
     position(1,1)
     if drive=0 then
     if compare(prompt_string("Do You Want To Delete File "&current_dir()&{92}&line2[sel]&" Yes or NO? "),"y") =0 then
     if recover=1 then
     add_info(line2[sel],{current_dir(),date2(),read_file(current_dir()&{92}&line2[sel])})
     end if
     system("del "&current_dir()&{92}&line2[sel],2)
     clear_screen()
     init()
     draw()
     else
     clear_screen()
     init()
     draw()
     end if
     elsif drive=1 then
     if compare(prompt_string("Do You Want To Delete File "&current_dir()&line2[sel]&" Yes or NO? "),"y") =0 then
     if recover=1 then
     add_info(line2[sel],{current_dir(),date2(),read_file(current_dir()&line2[sel])})
     end if
     system("del "&current_dir()&line2[sel],2)
     clear_screen()
     init()
     draw()
     else
     clear_screen()
     init()
     draw()
     end if
     end if
     end if
     elsif mode=2 then
     if recover=1 then
     if length(line3)>0 then
     if compare(prompt_string("Do You Want To Remove "&line3[sel3][1]&" From The Recovery Yes or NO? "),"y") =0 then
     delete_key(line3[sel3][1])
     end if
     clear_screen()
     init()
     draw()
     end if
     end if
   end if
   end if
end if
end while

if  chdir(temp)=1 then
end if
if recover=1 then
if db_compress() != DB_OK then
  puts(2, "compress failed!\n")
end if
end if
