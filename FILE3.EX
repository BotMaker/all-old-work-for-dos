--tuseday 11 oct 2005 20:22:59
--version 1

without type_check
global atom key
include engine.e
include wildcard.e
screen2={}
new_screen(-1)
if graphics_mode(18) then
end if

sequence d,line,line2,line3,temp_dir,info
atom test
info=""
test=0
d={}
line={}
line2={}
line3={}
temp_dir=current_dir()

procedure init()
test=0
d={}
line={}
line2={}
line3={}

  d=dir(current_dir())
  for i=1 to length(d) do
  test= compare(d[i][2],"d") 
  if test!=0 then
  line=append(line,d[i][1])
  line2=append(line2,d[i])
  end if
  end for

  d=dir(current_dir())
  for i=1 to length(d) do
  test= compare(d[i][2],"d") 
  if test=0 then
  line3=append(line3,d[i][1])
  end if
  end for
line=gaz_sort(line)
line3=gaz_sort(line3)
end procedure
init()

atom button1, temp2
sequence temp
temp={}
temp2=0
button1=create_ex({"button","Delete File",10,242})
atom button2
button2=create_ex({"button","Scan",335,237})
atom lable1
lable1=create_ex({"lable",34,29,"File Information"})
atom lable2
lable2=create_ex({"lable",5,54,"File Name"})
atom lable3
lable3=create_ex({"lable",7,104,"File Size"})
atom lable4
lable4=create_ex({"lable",6,79,"File Attributes"})
atom lable5
lable5=create_ex({"lable",30,132,"File Last Modification"})
atom lable6
lable6=create_ex({"lable",7,159,"Date"})
atom lable7
lable7=create_ex({"lable",7,183,"Time"})
atom lable9
lable9=create_ex({"lable",246,29,"Directorys"})
atom lable10
lable10=create_ex({"lable",381,30,"Files"})
atom listview1
listview1=create_ex({"listview",246,49,120,180,line3})
atom listview2
listview2=create_ex({"listview",372,50,120,180,line})
atom textbox1
textbox1=create_ex({"textbox",134,51,100})
atom textbox2
textbox2=create_ex({"textbox",134,76,100})
atom textbox3
textbox3=create_ex({"textbox",134,102,100})
atom textbox4
textbox4=create_ex({"textbox",45,156,100})
atom textbox5
textbox5=create_ex({"textbox",46,180,100})
atom textbox6
textbox6=create_ex({"textbox",392,235,100})

procedure close2()
  clear_screen()
  if chdir(temp_dir)=1 then
  end if
  abort(0)
end procedure

atom drive
drive=0

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
  return current_dir()&get_text({"listview",listview1})
end if
drive=0
return current_dir()&"\\"&get_text({"listview",listview1})
end function

while 1 do
key=get_key()
if key!=-1 then
  if key=27 then
    if show_q("Do You Want To Exit","About Windows ")=1 then
      close2()
    end if
  end if
end if
draw_screen()
if on_click({"listview",listview1})=1 then
 if compare(get_text({"listview",listview1}),".")=0 then
    delete_all_item({"listview",listview1})
    delete_all_item({"listview",listview2})
    if chdir(back_dir())=1 then
    end if
    init()
    add_all_item({"listview",listview1,line3})
    add_all_item({"listview",listview2,line})
  else
    if chdir(next_dir())=1 then
    end if
    delete_all_item({"listview",listview1})
    delete_all_item({"listview",listview2})
    init()
    add_all_item({"listview",listview1,line3})
    add_all_item({"listview",listview2,line})
  end if
end if
if on_click({"listview",listview2})=1 then
-- new
set_text({"textbox",textbox1,""})
set_text({"textbox",textbox2,""})
set_text({"textbox",textbox3,""})
set_text({"textbox",textbox4,""})
set_text({"textbox",textbox5,""})
--
for i=1 to length(line2) do
   if compare(line2[i][1],get_text({"listview",listview2}))=0 then
     set_text({"textbox",textbox1,line2[i][1]})
     set_text({"textbox",textbox2,line2[i][2]})
     set_text({"textbox",textbox3,sprint(line2[i][3])})
     set_text({"textbox",textbox4,sprint(line2[i][4])&" "&sprint(line2[i][5])&" "&sprint(line2[i][6])})
     set_text({"textbox",textbox5,sprint(line2[i][7])&" "&sprint(line2[i][8])&" "&sprint(line2[i][9])})
     exit
   end if
end for
end if
if on_click({"button",button1})=1 then

end if
if on_click({"button",button2})=1 then
temp2=0
  if length(get_text({"textbox",textbox6}))>0 then
    for i=1 to length(line2) do
       if compare(line2[i][1],upper(get_text({"textbox",textbox6})))=0 then
         set_sel_item({"listview",listview2,i})
         set_text({"textbox",textbox1,line2[i][1]})
         set_text({"textbox",textbox2,line2[i][2]})
         set_text({"textbox",textbox3,sprint(line2[i][3])})
         set_text({"textbox",textbox4,sprint(line2[i][4])&" "&sprint(line2[i][5])&" "&sprint(line2[i][6])})
         set_text({"textbox",textbox5,sprint(line2[i][7])&" "&sprint(line2[i][8])&" "&sprint(line2[i][9])})
         show_msg("File Found",info)
         temp2=1
         exit
       end if
    end for
  else
    show_msg("Enter A File",info)
  end if
  if temp2=0 then
    show_msg("File Not Found ",info)
  end if
end if
end while
