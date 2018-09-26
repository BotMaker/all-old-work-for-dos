without type_check
include graphics.e
include image.e

if graphics_mode(18) then
end if

procedure draw_line2(atom x,atom y,atom xx,atom yy,atom color)
draw_line(color, {{x, y}, {xx, yy}})
end procedure
procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

atom key, timer, number
timer=0
number=0

while 1 do
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
end if
timer+=1
if timer>10000000 then
timer=0
number+=1
polygon(GREEN, 1, {{0, 0}, {0, 480},{320,100}})
polygon(GREEN, 1, {{640, 0}, {640, 480},{320,100}})
polygon(WHITE, 1, {{0, 480}, {640, 480},{320,100}})
polygon(BROWN, 1, {{0,0}, {640, 0},{320,100}})
  for x1=40 to 380 by 100 do
    draw_line2(320-(x1/sin(cos(320/380)))/2,x1+100,320-(x1/sin(cos(320/380)))/2+x1/sin(cos(320/380)),x1+100,0)
  end for

if number=2 then
  ellipse(RED, 1, {320-(20/sin(cos(320/380)))/2,20+100}, {320-(20/sin(cos(320/380)))/2+20/sin(cos(320/380)),38+100})
end if
if number=3 then
  ellipse(RED, 1, {320-(85/sin(cos(320/380)))/2,85+100}, {320-(85/sin(cos(320/380)))/2+85/sin(cos(320/380)),110+100})
end if
if number=4 then
  ellipse(RED, 1, {320-(185/sin(cos(320/380)))/2,185+100}, {320-(185/sin(cos(320/380)))/2+185/sin(cos(320/380)),210+100})
end if
if number=5 then
  ellipse(RED, 1, {320-(285/sin(cos(320/380)))/2,285+100}, {320-(285/sin(cos(320/380)))/2+285/sin(cos(320/380)),310+100})
number=0
end if
end if
end while
