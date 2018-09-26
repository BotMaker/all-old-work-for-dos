without type_check
include graphics.e
include image.e

atom key
sequence screen, background, screen2
screen={}
screen2={}
background={}

if graphics_mode(18) then
end if

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

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

procedure new_background()
background={}
   for i=1 to 480 do
      background=append(background,repeat(0,639)) 
   end for
end procedure

procedure add_starts()
atom x
   for i=1 to 480 do
      for j=1 to 639 do
         x= rand(8)
         if x=1 or x=2 or x=3 or x=4 or x=5 or x=6 or x=7 then
          background[i][j]=0
         elsif x=8 then
          background[i][j]=7
         end if
      end for
   end for
end procedure

procedure move_background()
sequence temp1, temp2
temp1={}
temp2={}
   for i=1 to length(background)-50 do
      temp1=append(temp1, background[i])
   end for
   for i=length(background)-50 to length(background)-1 do
      temp2=append(temp2, background[i])
   end for
background={}
background=temp2&temp1
end procedure

procedure new_screen(atom color)
screen={}
   for i=1 to 480 do
      screen=append(screen,repeat(color, 640)) 
   end for
screen2=screen
end procedure

function change(atom color, sequence image)
 for i=1 to length(image) do
    for j=1 to length(image[i]) do
       if image[i][j]= color then
         image[i][j]=-1
       end if
    end for
 end for
return image
end function

procedure write_screen(sequence image, sequence xy, atom can)
atom x, y, line
x=xy[1]
y=xy[2]
line=1
if can=1 then
if x>=1 and x<=640 and y>=1 and y<=480 then
 for i=1 to length(image) do
    for j=1 to length(image[i]) do
       if image[i][j]!= -1 then
         screen[y+(i-1)][x+(j-1)]=image[i][j]
       end if
    end for
 end for
end if
else
for i=y to length(screen) do
   if x>=1 and x<=640 and y>=1 and y<=480 then
     if line<=length(image) then
       screen[i][x..(x+length(image[line])-1)]=image[line]
     end if
   end if
line+=1
end for
end if
end procedure

sequence image,enemy
object bitmap
--
bitmap=read_bitmap("blue.bmp")
image=bitmap[2]
image=change(GREEN,image)
--
bitmap=read_bitmap("red.bmp")
enemy=bitmap[2]
enemy=change(GREEN,enemy)

sequence object_info, fire
object_info={}
fire={{0,0,2,0,0},
      {0,0,2,0,0},
      {0,0,2,0,0},
      {0,0,2,0,0},
      {0,0,2,0,0},
      {0,0,2,0,0},
      {0,0,2,0,0}}
fire=change(0,fire)

function col_1(atom id ,atom x, atom y, atom cx, atom cy)
atom x2, y2, cx2, cy2, id2
for i=1 to length(object_info) do
   id2=object_info[i][1]
   x2=object_info[i][2]
   y2=object_info[i][3]
   cx2=object_info[i][4]
   cy2=object_info[i][5]
   if id2=id then
     if x2>=x and x2<=cx and y2<=cy and y2>=y then
       object_info=remove_line(object_info,i)
       return 1
     end if
   end if
end for
return 0
end function

procedure game()
atom id, x, y, cx, cy, timer, dir
for i=1 to length(object_info) do
   id=object_info[i][1]
   x=object_info[i][2]
   y=object_info[i][3]
   cx=object_info[i][4]
   cy=object_info[i][5]
   if id=1 then
     y-=8
     cy-=8
     write_screen(fire,{x,y},1)
     object_info[i][2]=x
     object_info[i][3]=y
     object_info[i][4]=cx
     object_info[i][5]=cy
   end if
   if id=2 then
     timer=object_info[i][6]
     dir=object_info[i][7]
     timer+=1
     if dir=0 then
       x+=2
       cx+=2
     elsif dir=1 then
       y+=0.6
       cy+=0.6
     elsif dir=2 then
       x-=2
       cx-=2
     elsif dir=3 then
       y+=0.6
       cy+=0.6
     end if
     if timer>75 then
       dir+=1
       timer=0
     end if
     if dir>3 then
       dir=0
     end if
     write_screen(enemy,{x,y},1)
     object_info[i][2]=x
     object_info[i][3]=y
     object_info[i][4]=cx
     object_info[i][5]=cy
     object_info[i][6]=timer
     object_info[i][7]=dir
   end if
end for
for i=1 to length(object_info) do
   for j=1 to length(object_info) do
      id=object_info[j][1]
      x=object_info[j][2]
      y=object_info[j][3]
      cx=object_info[j][4]
      cy=object_info[j][5]
      if id=1 then
        if y<0 then
          object_info=remove_line(object_info,j)
          exit
        end if
      end if
      if id=2 then
        if col_1(1,x,y,cx,cy)=1 then
          object_info=remove_line(object_info,j)
          exit
        end if
      end if
   end for
end for
end procedure

new_screen(7)
atom x, y
x=130
y=400

--line1
object_info=append(object_info,{2,1,1,1+25,1+25,0,0})
object_info=append(object_info,{2,40,1,40+25,1+25,0,0})
object_info=append(object_info,{2,80,1,80+25,1+25,0,0})
object_info=append(object_info,{2,120,1,120+25,1+25,0,0})
object_info=append(object_info,{2,160,1,160+25,1+25,0,0})
object_info=append(object_info,{2,200,1,200+25,1+25,0,0})
object_info=append(object_info,{2,240,1,240+25,1+25,0,0})
object_info=append(object_info,{2,280,1,280+25,1+25,0,0})
object_info=append(object_info,{2,320,1,320+25,1+25,0,0})
object_info=append(object_info,{2,360,1,360+25,1+25,0,0})
object_info=append(object_info,{2,400,1,400+25,1+25,0,0})
object_info=append(object_info,{2,440,1,440+25,1+25,0,0})
--line2
object_info=append(object_info,{2,1,40,1+25,40+25,0,0})
object_info=append(object_info,{2,40,40,40+25,40+25,0,0})
object_info=append(object_info,{2,80,40,80+25,40+25,0,0})
object_info=append(object_info,{2,120,40,120+25,40+25,0,0})
object_info=append(object_info,{2,160,40,160+25,40+25,0,0})
object_info=append(object_info,{2,200,40,200+25,40+25,0,0})
object_info=append(object_info,{2,240,40,240+25,40+25,0,0})
object_info=append(object_info,{2,280,40,280+25,40+25,0,0})
object_info=append(object_info,{2,320,40,320+25,40+25,0,0})
object_info=append(object_info,{2,360,40,360+25,40+25,0,0})
object_info=append(object_info,{2,400,40,400+25,40+25,0,0})
object_info=append(object_info,{2,440,40,440+25,40+25,0,0})

while 1 do
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
 if key=331 and x>10 then
   x-=8
 end if
 if key=333 and x<600 then
   x+=8
 end if
 if key=32 then
   object_info=append(object_info,{1,x,y,x+1,y+8})
 end if
end if
display_image({0,0},screen)
screen=screen2
write_screen(image,{x,y},1)
game()
end while
?length(object_info)
