without type_check
include graphics.e
include file.e
include get.e
include image.e
include mouse2.e

atom key, page, timer
sequence vc, screen
page=0
timer=0
screen={}

for i=1 to 200 do
screen=append(screen,repeat(1,320))
end for

if graphics_mode(13) then
end if
vc = video_config()

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

procedure write_screen(sequence image, atom x, atom y)
atom width, height
width=length(image[1])
height=length(image)
for i=y to height do
screen[i][x..x+width-1]=image[i]
end for
end procedure

atom x,y,wp, on
sequence waypnt, path
x=1
y=1
wp=1
on=0
path={}
waypnt={}

procedure draw()
if x>=waypnt[wp][1]-4 and x<=waypnt[wp][1] and y>=waypnt[wp][2]-4 and y<=waypnt[wp][2] then
  wp+=1
end if
if wp=length(waypnt)+1 then
  wp=1
end if
if waypnt[wp][1]>x then
  x=x+1
end if
if waypnt[wp][1]<x then
  x=x-1
end if
if waypnt[wp][2]>y then
  y=y+1
end if
if waypnt[wp][2]<y then
  y=y-1
end if
 pixel(-1,{x,y})
path=append(path,{x,y})
for i=1 to length(path)-1 do
 pixel(BRIGHT_BLUE,{path[i][1],path[i][2]})
end for
end procedure

while 1 do
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
end if
timer+=1
if timer>80000 then
mouse()
timer=0
if get_active_page()=0 then
set_active_page(1)
page=1
elsif get_active_page()=1 then
set_active_page(0)
page=0
end if
clear_screen()
display_image({1,1},screen)
if on=0 then
for i=1 to length(waypnt)-1 do
   draw_line(0,{{waypnt[i][1],waypnt[i][2]},{waypnt[i+1][1],waypnt[i+1][2]}})
end for
end if
if on=1 then
draw()
end if
rectangle(10,180,40,190,2,1)
rectangle(50,180,80,190,RED,1)
rectangle(90,180,120,190,7,1)
rectangle(mouse_x/2,mouse_y,mouse_x/2+5,mouse_y+5,-1,1)
if mouse_x/2>10 and mouse_x/2<40 and mouse_y>180 and mouse_y<190 and mouse_button=mb_left then
  on=1
end if
if mouse_x/2>50 and mouse_x/2<80 and mouse_y>180 and mouse_y<190 and mouse_button=mb_left then
x=1
y=1
wp=1
on=0
path={}
end if
if mouse_x/2>90 and mouse_x/2<120 and mouse_y>180 and mouse_y<190 and mouse_button=mb_left then
x=1
y=1
wp=1
on=0
waypnt={}
path={}
end if

if mouse_x/2>0 and mouse_x/2<320 and mouse_y>0 and mouse_y<170 and mouse_button=mb_left then
  waypnt=append(waypnt,{mouse_x/2,mouse_y})
end if 
set_display_page(page)
end if
end while

if graphics_mode(18) then
end if

