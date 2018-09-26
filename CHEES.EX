without type_check
include graphics.e
include mouse2.e
include font.e
include image.e

sequence borad
borad={
      {{1,1,-1},{1,2,0},{0,0,-1},{0,0,0},{0,0,-1},{0,0,0},{1,2,-1},{1,1,0}},
      {{0,0,0},{0,0,-1},{0,0,0},{0,0,-1},{0,0,0},{0,0,-1},{0,0,0},{0,0,-1}},
      {{0,0,-1},{0,0,0},{0,0,-1},{0,0,0},{0,0,-1},{0,0,0},{0,0,-1},{0,0,0}},
      {{0,0,0},{0,0,-1},{0,0,0},{0,0,-1},{0,0,0},{0,0,-1},{0,0,0},{0,0,-1}},
      {{0,0,-1},{0,0,0},{0,0,-1},{0,0,0},{0,0,-1},{0,0,0},{0,0,-1},{0,0,0}},
      {{0,0,0},{0,0,-1},{0,0,0},{0,0,-1},{0,0,0},{0,0,-1},{0,0,0},{0,0,-1}},
      {{0,0,-1},{0,0,0},{0,0,-1},{0,0,0},{0,0,-1},{0,0,0},{0,0,-1},{0,0,0}},
      {{0,0,0},{0,0,-1},{0,0,0},{0,0,-1},{0,0,0},{0,0,-1},{0,0,0},{0,0,-1}}
      }
atom key

sequence image_p1,image_p2
object bitmap
bitmap=read_bitmap("p1.bmp")
image_p1=bitmap[2]
bitmap=read_bitmap("p2.bmp")
image_p2=bitmap[2]

if graphics_mode(18) then
end if

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
  polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

procedure draw_image(sequence image,sequence args)
integer x,y,pos1,pos2
x=args[1]
y=args[2]
pos1=args[3]
pos2=args[4]
  for i=1 to length(image) do
     for j=1 to length(image[i]) do
        if image[i][j]!=-1 and image[i][j]!=15 then
          rectangle((x+2*(pos2+j))-2,(y+2*(pos1+i))-2,(x+2*(pos2+1+j))-2,(y+2*(pos1+1+i))-2,image[i][j],1)
        end if
     end for
  end for
end procedure

integer line,row,draw
line=1
row=1
draw=0

procedure draw_game(integer x, integer y)
  for i=1 to 8 do
     for j=1 to 8 do
      if draw=1 and line=i and row=j and borad[i][j][1]=1 then
        rectangle((x+52*j)-52,(y+52*i)-52,(x+52*(j+1))-52,(y+52*(i+1))-52,RED,1)
        if borad[i][j][1]=1 and borad[i][j][2]=1 then
          draw_image(image_p1,{(x+52*j)-52-j,(y+52*i)-52-i,i,j})
        elsif borad[i][j][1]=1 and borad[i][j][2]=2 then
          draw_image(image_p2,{(x+52*j)-52-j,(y+52*i)-52-i,i,j})
        end if
        rectangle((x+52*j)-52,(y+52*i)-52,(x+52*(j+1))-52,(y+52*(i+1))-52,8,0)
      else
        rectangle((x+52*j)-52,(y+52*i)-52,(x+52*(j+1))-52,(y+52*(i+1))-52,borad[i][j][3],1)
        if borad[i][j][1]=1 and borad[i][j][2]=1 then
          draw_image(image_p1,{(x+52*j)-52-j,(y+52*i)-52-i,i,j})
        elsif borad[i][j][1]=1 and borad[i][j][2]=2 then
          draw_image(image_p2,{(x+52*j)-52-j,(y+52*i)-52-i,i,j})
        end if
        rectangle((x+52*j)-52,(y+52*i)-52,(x+52*(j+1))-52,(y+52*(i+1))-52,8,0)
      end if
     end for
  end for
end procedure

procedure selete()
integer x,y
x=1
y=1
  for i=1 to 8 do
     for j=1 to 8 do
        if mouse_x>(x+52*j)-52 and mouse_x<(x+52*(j+1))-52 and mouse_y>(y+52*i)-52 and mouse_y<(y+52*(i+1))-52 and mouse_button=mb_left then
          draw=1
          line=i
          row=j
          draw_game(1,1)
          mouse_button=0
          exit
        end if
     end for
  end for
  if mouse_button=mb_left and draw=1 then
    draw=0
    draw_game(1,1)
    mouse_button=0
  end if
end procedure

procedure move_now()

end procedure

function check_move(integer temp_line, integer temp_row)
  if borad[line][row][2]=1 then
    if temp_row>row or temp_row<row then
      return 0
    else
      return 1
    end if
  end if
  return 0
end function

procedure move_selete()
integer x,y,can
x=1
can=0
y=1
if draw=1 then
  for i=1 to 8 do
     for j=1 to 8 do
        if mouse_x>(x+52*j)-52 and mouse_x<(x+52*(j+1))-52 and mouse_y>(y+52*i)-52 and mouse_y<(y+52*(i+1))-52 and mouse_button=mb_right then
          if check_move(i,j)>0 then
            borad[line][row][1]=0
            borad[line][row][2]=0
            borad[i][j][1]=1
            borad[i][j][2]=1
            can=1
            draw=0
            draw_game(1,1)
          else
            draw=0
            draw_game(1,1)
          end if
          mouse_button=0
          can=1
          exit
        end if
     end for
     if can=1 then
       exit
     end if
  end for
  if mouse_button=mb_right and draw=1 then
    draw=0
    draw_game(1,1)
    mouse_button=0
  end if
end if
end procedure

draw_game(1,1)

while 1 do
mouse()
mouse_pointer(1)
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
end if
selete()
move_selete()
end while
