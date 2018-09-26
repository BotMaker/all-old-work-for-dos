without type_check
include graphics.e
include image.e
include font.e

if graphics_mode(13) then
end if

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

atom key
sequence game
game={{0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0}}

procedure draw()
  for i=1 to length(game) do
     for j=1 to length(game[i]) do
        if game[i][j]=0 then
          rectangle(10*j-10,10*i-10,10*j,10*i,0,1)
        end if
        if game[i][j]=1 then
          rectangle(10*j-10,10*i-10,10*j,10*i,-1,1)
        end if
     end for
  end for
end procedure

procedure new_brick()
atom brick, timer, line, row, shap, new_row, dir
brick=1
timer=0
dir=1
shap=0
new_row=0
while 1 do
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
 if key=331 then
   if new_row>1 then
   new_row-=1
   end if
 end if
 if key=13 then
   dir+=1
   if dir>4 then
     dir=1
   end if
 end if
 if key=333 then
   if new_row<8 then
   new_row+=1
   end if
 end if
end if
if brick=1 and shap=0 then
  line=1
  row=4
  new_row=4
  shap=1
  game[line][row]=1
  game[line][row+1]=1
  game[line][row+2]=1
  draw()
end if
timer+=1
if timer>1000000 then
  timer=0
  if shap=1 then
   if dir=1 then
    if line+1<11 and game[line+1][row]=0 and game[line+1][row+1]=0 and game[line+1][row+2]=0 then
      game[line][row]=0
      game[line][row+1]=0
      game[line][row+2]=0
      line+=1
      row=new_row
      game[line][row]=1
      game[line][row+1]=1
      game[line][row+2]=1
      draw()
    else
      exit
    end if
   end if
  end if
end if
end while
end procedure

new_brick()

while 1 do
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
end if
end while
