without type_check
--without warning
include graphics.e
include image.e
include font.e

if graphics_mode(19) then
end if

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
  polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

integer key

sequence screen1,screen2,image_1,object_info,instance_info
integer object_number,instance_number
object bitmap
bitmap=read_bitmap("ship.bmp")
image_1=bitmap[2]

screen1={}
screen2={}
object_info={}
object_number=0
instance_info={}
instance_number=0

procedure add_object(sequence info)
integer cx,cy
cx=length(info[2][1])
cy=length(info[2])
  object_number+=1
  object_info=append(object_info,{info[1],info[2],info[3],info[4],cx,cy,info[5],object_number})
end procedure

procedure add_instance(sequence info)
  instance_number+=1
  for i=1 to length(object_info) do
     if equal(info[1],object_info[i][1])=1 then
       instance_info=append(instance_info,{object_info[i],instance_info})
       instance_info[length(instance_info)][3]=info[2]
       instance_info[length(instance_info)][4]=info[3]
       exit
     end if
  end for
end procedure

for i=1 to 200 do
   screen1=append(screen1,repeat(1, 320))
end for

procedure write_screen(sequence image, sequence xy, integer tran)
  atom x, y, line, width, height
  width=length(image[1])
  height=length(image)
  x=xy[1]
  y=xy[2]
  line=1
if tran=1 then
 if x>=1 and x+width<=320 and y>=1 and y+height<=200 then
 for i=1 to length(image) do
    for j=1 to length(image[i]) do
       if image[i][j]!= -1 then
         screen1[y+(i-1)][x+(j-1)]=image[i][j]
       end if
    end for
 end for
 end if
else
 if x>=1 and x+width<=320 and y>=1 and y+height<=200 then
 for i=y to length(screen1) do
    if line<=length(image) then
      screen1[i][x..(x+length(image[line])-1)]=image[line]
    else
      exit
    end if
  line+=1
  end for
  end if
end if
end procedure

function transparent(sequence image, atom color)
 for i=1 to length(image) do
    for j=1 to length(image[i]) do
       if image[i][j]= color then
         image[i][j]=-1
       end if
    end for
 end for
return image
end function

--image_1=transparent(image_1,image_1[1][1])

procedure draw_screen()
  display_image({0,0},screen1)
end procedure

procedure draw_game()
sequence image
integer depth,max_depth,depth_number,x,y
max_depth=100
depth_number=0
  for i=1 to length(instance_info)+max_depth do
     for j=1 to length(instance_info) do
       depth=instance_info[j][7]
       image=instance_info[j][2]
       x=instance_info[j][3]
       y=instance_info[j][4]
       if depth=depth_number then
         write_screen(image,{x,y},0)
       end if
       depth_number+=1
     end for
  end for
end procedure

procedure game()
sequence image,name
integer x,y
  for i=1 to length(instance_info) do
     x=instance_info[i][3]
     y=instance_info[i][4]
  end for
  draw_game()
end procedure

add_object({"player",image_1,10,10,1})
add_instance({"player",100,10})

while 1 do
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
end if
game()
draw_screen()
end while
