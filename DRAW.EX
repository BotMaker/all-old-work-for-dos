without type_check
include graphics.e
include select.e
include file.e
include machine.e
include get.e
include image.e
include font2.e

constant key_left=331
constant key_right=333
constant key_up=328
constant key_down=336
constant key_enter=13
constant key_c=99

sequence var_color, vc
atom key, line, row, color,color2
atom width, height, zoom,mode,can, temp_line, temp_row, fill
can=0
mode=1
fill=0
color=BLACK
color2=WHITE
line=1
row=1
width= prompt_number("What is width of the image enter number between 0 75? ", {0, 75})
height= prompt_number("What is height of image enter number between 0 50? ", {0, 50})
zoom=2
var_color={}

if graphics_mode(18) then
end if
vc = video_config()

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

procedure fill2()
atom x,y, fill_color,size1,size2,size3,size4
fill_color=var_color[line][row]
x=row
y=line
size1=0
size2=0
size3=0
size4=0
for i=x to 1 by -1 do
   if var_color[y][i]=fill_color then
     size1+=1
   else
   exit
   end if
end for
for i=x to width by +1 do
   if var_color[y][i]=fill_color then
     size2+=1
   else
   exit
   end if
end for
for i=y to 1 by -1 do
   if var_color[i][x]=fill_color then
     size3+=1
   else
   exit
   end if
end for
for i=y to height by +1 do
   if var_color[i][x]=fill_color then
     size4+=1
   else
   exit
   end if
end for
for i=y-size3+1 to y+size4-1  do
   for j=x-size1+1 to x+size2-1 do
     var_color[i][j]=color
   end for
end for
end procedure

procedure draw_pos()
  for i=line to line+1 do
    for j=row to row+1 do
      rectangle(row*zoom,line*zoom,row*zoom+zoom,line*zoom+zoom,color,1)
    end for
  end for
end procedure

procedure color_sel()
  rectangle(1,435,11,445,color,1)
end procedure

procedure draw()
atom x,y
  for i=1 to height do
     y=i*zoom
    for j=1 to width do
      x=j*zoom
      rectangle(x,y,x+zoom,y+zoom,var_color[i][j],1)
    end for
  end for
draw_pos()

position(29,1)
text_color(RED)
puts(1,"N")
position(29,2)
text_color(WHITE)
puts(1,"ew")

position(29,6)
text_color(RED)
puts(1,"O")
position(29,7)
text_color(WHITE)
puts(1,"pen")

position(29,11)
text_color(RED)
puts(1,"S")
position(29,12)
text_color(WHITE)
puts(1,"ave")

position(29,16)
text_color(RED)
puts(1,"E")
position(29,17)
text_color(WHITE)
puts(1,"xit")

position(29,22)
text_color(WHITE)
puts(1,"mode")
position(29,28)
text_color(WHITE)
print(1,mode)

position(29,32)
text_color(WHITE)
puts(1,"fill")
position(29,38)
text_color(WHITE)
print(1,fill)
end procedure

procedure flip_image(sequence digits)
    for i = 1 to length(digits) do
	digits[i] = reverse(digits[i])
    end for
var_color=digits
end procedure

procedure flip_image2(sequence image)
var_color=reverse(image)
end procedure


procedure line2()
atom code
object a
 can+=1
 if can=1 then
   temp_line=line
   temp_row=row
 elsif can=2 then
   clear_screen()
   display_image({1,1},var_color)
   draw_line(color,{{temp_row,temp_line},{row,line}})
   code = save_screen({{1,1},{width,height}}, "c:\\temp.bmp")
   a=read_bitmap("c:\\temp.bmp")
   var_color={}
   var_color=a[2]
   height=length(var_color)
   width=length(var_color[1])
   clear_screen()
   draw()
   can=0
 end if
end procedure

procedure rectangle2()
atom code
object a
 can+=1
 if can=1 then
   temp_line=line
   temp_row=row
 elsif can=2 then
   clear_screen()
   display_image({1,1},var_color)
   rectangle(temp_row,temp_line,row,line,color,fill)
   code = save_screen({{1,1},{width,height}}, "c:\\temp.bmp")
   a=read_bitmap("c:\\temp.bmp")
   var_color={}
   var_color=a[2]
   height=length(var_color)
   width=length(var_color[1])
   clear_screen()
   draw()
   can=0
 end if
end procedure

procedure ellipse2()
atom code
object a
 can+=1
 if can=1 then
   temp_line=line
   temp_row=row
 elsif can=2 then
   clear_screen()
   display_image({1,1},var_color)
   ellipse(color,fill,{temp_row,temp_line},{row,line})
   code = save_screen({{1,1},{width,height}}, "c:\\temp.bmp")
   a=read_bitmap("c:\\temp.bmp")
   var_color={}
   var_color=a[2]
   height=length(var_color)
   width=length(var_color[1])
   clear_screen()
   draw()
   can=0
 end if
end procedure

procedure text()
atom code
object a
sequence text,text2, temp
integer number
temp=var_color
text=""
while 1 do
key=get_key()
if key != -1 then
  if key=key_enter then
   clear_screen()
   display_image({1,1},var_color)
   display_image({row,line},text2)
   code = save_screen({{1,1},{width,height}}, "c:\\temp.bmp")
   a=read_bitmap("c:\\temp.bmp")
   var_color={}
   var_color=a[2]
   height=length(var_color)
   width=length(var_color[1])
   clear_screen()
   draw()
  exit
  end if
if key!=8 then
text&=key
text2=draw_text({1,1},text,color,color2,0)
   for i=1 to length(text2) do
     for j=1 to length(text2[i]) do
        if text2[i][j]=color2 then
          number=var_color[line+i-1][row+j-1]
          text2[i][j]=number
        end if
     end for
   end for
   clear_screen()
   display_image({1,1},var_color)
   display_image({row,line},text2)
   code = save_screen({{1,1},{width,height}}, "c:\\temp.bmp")
   a=read_bitmap("c:\\temp.bmp")
   var_color={}
   var_color=a[2]
   height=length(var_color)
   width=length(var_color[1])
   clear_screen()
   draw()
end if
if key=8 then
text=text[1..length(text)-1]
   for i=1 to length(text2) do
     for j=1 to length(text2[i]) do
        if text2[i][j]=color2 then
          number=var_color[line+i-1][row+j-1]
          text2[i][j]=number
        end if
     end for
   end for
text2=draw_text({1,1},text,color,color2,0)
   clear_screen()
   display_image({1,1},temp)
   display_image({row,line},text2)
   code = save_screen({{1,1},{width,height}}, "c:\\temp.bmp")
   a=read_bitmap("c:\\temp.bmp")
   var_color={}
   var_color=a[2]
   height=length(var_color)
   width=length(var_color[1])
   clear_screen()
   draw()
end if
end if
end while
end procedure

procedure init()
sequence temp
temp={}
for i=1 to width do
 temp &={7}
end for
for i=1 to height do
  var_color=append(var_color,temp)
end for
end procedure

procedure new()
line=1
row=1
position(1,1)
clear_screen()
width= prompt_number("What is width of the image enter number between 0 75? ", {0, 75})
clear_screen()
position(1,1)
height= prompt_number("What is height of image enter number between 0 50? ", {0, 50})
clear_screen()
zoom=2
var_color={}
init()
draw()
end procedure

init()
draw()

procedure move_image()
sequence temp1, temp2
temp1={}
temp2={}
   for i=1 to length(var_color)-1 do
      temp1=append(temp1, var_color[i])
   end for
   for i=length(var_color)-1 to length(var_color)-1 do
      temp2=append(temp2, var_color[i])
   end for
var_color={}
var_color=temp2&temp1
end procedure

procedure command(sequence string)
sequence file,paletteData
integer code
object a
if compare(string,"new") =0 then
  position(30,1)
  if compare(prompt_string("Start New Image Yes or NO? "),"y") =0 then
   new()
  end if
end if
if compare(string,"exit") =0 then
  position(30,1)
  if compare(prompt_string("Do You Want To Exit Yes or NO? "),"y") =0 then
   position(1,1)
   clear_screen()
   abort(0)
  end if
end if

if compare(string,"open") =0 then
  position(30,1)
  if compare(prompt_string("Do You Want To Open A Image Yes or NO? "),"y") =0 then
  file = prompt_string("Enter A File Name? ")
  a=read_bitmap(file)
  var_color={}
  var_color=a[2]
  height=length(var_color)
  width=length(var_color[1])
  end if
end if

if compare(string,"save") =0 then
  position(30,1)
  if compare(prompt_string("Do You Want To Save Image Yes or NO? "),"y") =0 then
    file = prompt_string("Enter A File Name? ")
    paletteData = get_all_palette() * 4
    code = save_bitmap({paletteData, var_color},file)  
  end if
end if
clear_screen()
draw()
end procedure

while 1 do
key=get_key()
if key != -1 then
 if key=key_left then
  if row>1 then
   row-=1
   draw()
   draw_pos()
   position(30,1)
   puts(1,"   ")
   position(30,10)
   puts(1,"   ")
   position(30,1)
   print(1,row)
   position(30,10)
  print(1,line)
  end if
 end if
 if key=key_right then
  if row<width then
   row+=1
   draw()
   draw_pos()
   position(30,1)
   puts(1,"   ")
   position(30,10)
   puts(1,"   ")
   position(30,1)
   print(1,row)
   position(30,10)
  print(1,line)

  end if
 end if
 if key=key_up then
  if line>1 then
   line-=1
   draw()
   draw_pos()
   position(30,1)
   puts(1,"   ")
   position(30,10)
   puts(1,"   ")
   position(30,1)
   print(1,row)
   position(30,10)
  print(1,line)

  end if
 end if
 if key=key_down then
  if line<height then
   line+=1
   draw()
   draw_pos()
   position(30,1)
   puts(1,"   ")
   position(30,10)
   puts(1,"   ")
   position(30,1)
   print(1,row)
   position(30,10)
  print(1,line)

  end if
 end if
 if key=key_enter then
  if mode=1 then
  var_color[line][row]=color
  draw()
  end if
  if mode=2 then
  fill2()
  draw()
  end if
  if mode=3 then
  line2()
  draw()
  end if
  if mode=4 then
  rectangle2()
  draw()
  end if
  if mode=5 then
  ellipse2()
  draw()
  end if
  if mode=6 then
  text()
  draw()
  end if
 end if
 if key=45 then
  if zoom>2 then
   zoom-=2
   clear_screen()
   draw()
  end if
 end if
 if key=61 then
  if zoom<8 then
   zoom+=2
   clear_screen()
   draw()
  end if
 end if
 if key=key_c then
  color+=1
  if color>16 then
    color=0
  end if
  color_sel()
  draw_pos()
 end if
 if key=110 then
  command("new")
 end if
 if key=101 then
  command("exit")
 end if
 if key=115 then
   command("save")
 end if
 if key=111 then
   command("open")
 end if
 if key=109 then
   if mode=1 then
     mode=2
   elsif mode=2 then
     mode=3
   elsif mode=3 then
     mode=4
   elsif mode=4 then
     mode=5
   elsif mode=5 then
     mode=6
   elsif mode=6 then
     mode=1
   end if
   draw()
   can=0
 end if
 if key='l' then
   flip_image2(var_color)
   clear_screen()
   draw()
 end if
 if key='r' then
   flip_image(var_color)
   clear_screen()
   draw()
 end if
 if key=102 then
   if fill=0 then
     fill=1
   elsif fill=1 then
     fill=0
   end if
   draw()
  end if
  if key=401 then
   move_image()
   clear_screen()
   draw()
  end if
end if
end while
