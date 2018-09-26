without type_check
include graphics.e
include image.e
include font.e

if graphics_mode(13) then
end if

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

atom key, life_1, babe, speed, can_work, line, row, width,height
atom number1, life_2
life_2=10
number1=0
babe=1
life_1=10
speed=1
can_work=0
row=1
line=1
height=40
width=40
sequence game

procedure new()
game={}
for i=1 to height do
game=append(game,repeat({0,0,0,0,0},width))
end for
end procedure
new()

procedure draw()
number1=0
  for i=1 to length(game) do
     for j=1 to length(game[i]) do
        if game[i][j][1]=0 then
          rectangle(5*j-5,5*i-5,5*j,5*i,0,1)
        end if
        if game[i][j][1]>0  then
          if game[i][j][1]=1 and game[i][j][2]=babe then
            rectangle(5*j-5,5*i-5,5*j,5*i,2,1)
          end if
          if game[i][j][1]=2 and game[i][j][2]=babe then
            rectangle(5*j-5,5*i-5,5*j,5*i,YELLOW,1)
          end if
          if game[i][j][1]=1 or game[i][j][1]=2 and game[i][j][2]=0 then
            rectangle(5*j-5,5*i-5,5*j,5*i,RED,1)
          end if
          number1+=1
          if game[i][j][1]=1 and game[i][j][4]>=life_1 then
            rectangle(5*j-5,5*i-5,5*j,5*i,-1,1)
          end if
          if game[i][j][3]>=1 then
            rectangle(5*j-5,5*i-5,5*j,5*i,1,1)
          end if
       end if
     end for
  end for
draw_text({280,10},"    ",-1,0,0)
draw_text({280,10},sprint(number1),-1,0,0)
end procedure

procedure draw2()
number1=0
  for i=1 to length(game) do
     for j=1 to length(game[i]) do
        if game[i][j][1]=0 then
          rectangle(5*j-5,5*i-5,5*j,5*i,0,1)
        end if
        if game[i][j][1]>0  then
          if game[i][j][1]=1  then
            rectangle(5*j-5,5*i-5,5*j,5*i,2,1)
          end if
          if game[i][j][1]=2  then
            rectangle(5*j-5,5*i-5,5*j,5*i,YELLOW,1)
          end if
       end if
     end for
  end for
end procedure

function has(atom line, atom row)
atom number
number=0
 if line>1 and line<height and row>1 and row<width then
  if game[line-1][row-1][1]=1 or game[line-1][row-1][1]=2 then
    number+=1
  end if
  if game[line-1][row][1]=1 or game[line-1][row][1]=2 then
    number+=1
  end if
  if game[line-1][row+1][1]=1 or game[line-1][row+1][1]=2 then
    number+=1
  end if
  if game[line][row-1][1]=1 or game[line][row-1][1]=2 then
    number+=1
  end if
  if game[line][row+1][1]=1 or game[line][row+1][1]=2 then
    number+=1
  end if
  if game[line+1][row-1][1]=1 or game[line+1][row-1][1]=2 then
    number+=1
  end if
  if game[line+1][row][1]=1 or game[line+1][row][1]=2 then
    number+=1
  end if
  if game[line+1][row+1][1]=1 or game[line+1][row+1][1]=2 then
    number+=1
  end if
 else
 end if
if number>=babe then
  return 1
else
return 0
end if
end function

function get_race(atom line, atom row)
 if line>1 and line<height and row>1 and row<width then
  if game[line-1][row-1][1]=1 or game[line-1][row-1][1]=2 then
    return game[line-1][row-1][1]
  end if
  if game[line-1][row][1]=1 or game[line-1][row][1]=2 then
    return game[line-1][row][1]
  end if
  if game[line-1][row+1][1]=1 or game[line-1][row+1][1]=2 then
    return game[line-1][row+1][1]
  end if
  if game[line][row-1][1]=1 or game[line][row-1][1]=2 then
    return game[line][row-1][1]
  end if
  if game[line][row+1][1]=1 or game[line][row+1][1]=2 then
    return game[line][row+1][1]
  end if
  if game[line+1][row-1][1]=1 or game[line+1][row-1][1]=2 then
    return game[line+1][row-1][1]
  end if
  if game[line+1][row][1]=1 or game[line+1][row][1]=2 then
    return game[line+1][row][1]
  end if
  if game[line+1][row+1][1]=1 or game[line+1][row+1][1]=2 then
    return game[line+1][row+1][1]
  end if
 end if
return 1
end function

function add_life(atom line,atom row)
sequence dir
atom number
dir={}
 if line>1 and line<height and row>1 and row<width then
  if game[line-1][row-1][1]=0 then
    dir=append(dir,{line-1,row-1})
  end if
  if game[line-1][row][1]=0 then
    dir=append(dir,{line-1,row})
  end if
  if game[line-1][row+1][1]=0 then
    dir=append(dir,{line-1,row+1})
  end if
  if game[line][row-1][1]=0 then
    dir=append(dir,{line,row-1})
  end if
  if game[line][row+1][1]=0 then
    dir=append(dir,{line,row+1})
  end if
  if game[line+1][row-1][1]=0 then
    dir=append(dir,{line+1,row-1})
  end if
  if game[line+1][row][1]=0 then
    dir=append(dir,{line+1,row})
  end if
  if game[line+1][row+1][1]=0 then
    dir=append(dir,{line+1,row+1})
  end if
 else
 end if
if length(dir)>0 then
  number=rand(length(dir))
  if dir[number][1]>1 and dir[number][1]<height and dir[number][2]>1 and dir[number][2]<width then
    game[dir[number][1]][dir[number][2]][1]=get_race(line,row)
    return 1
  end if
end if
return 0
end function

function new_life(atom line,atom row)
sequence dir
atom number
dir={}
 if line>1 and line<height and row>1 and row<width then
  if game[line-1][row-1][1]=1 or game[line-1][row-1][1]=2 then
  dir=append(dir,{line-1,row-1})
  end if
  if game[line-1][row][1]=1 or game[line-1][row][1]=2 then
  dir=append(dir,{line-1,row})
  end if
  if game[line-1][row+1][1]=1 or game[line-1][row+1][1]=2 then
  dir=append(dir,{line-1,row+1})
  end if
  if game[line][row-1][1]=1 or game[line][row-1][1]=2 then
  dir=append(dir,{line,row-1})
  end if
  if game[line][row+1][1]=1 or game[line][row+1][1]=2 then
  dir=append(dir,{line,row+1})
  end if
  if game[line+1][row-1][1]=1 or game[line+1][row-1][1]=2 then
  dir=append(dir,{line+1,row-1})
  end if
  if game[line+1][row][1]=1 or game[line+1][row][1]=2 then
  dir=append(dir,{line+1,row})
  end if
  if game[line+1][row+1][1]=1 or game[line+1][row+1][1]=2 then
  dir=append(dir,{line+1,row+1})
  end if
 end if
if length(dir)>0 then
  number=rand(length(dir))
  if dir[number][1]>1 and dir[number][1]<height and dir[number][2]>1 and dir[number][2]<width then
    game[dir[number][1]][dir[number][2]][4]=get_race(line,row)
    return 1
  end if
end if
return 0
end function

procedure life()
  for i=1 to length(game) do
     for j=1 to length(game[i]) do
        if game[i][j][1]=1 or game[i][j][1]=2 and game[i][j][2]<babe then
          if has(i,j)=1 then
            if add_life(i,j)=1 then
              game[i][j][2]+=1
            end if
          end if
        end if
     end for
  end for
end procedure

procedure death()
atom number
  for i=1 to length(game) do
     for j=1 to length(game[i]) do
        if game[i][j][1]=1 or game[i][j][1]=2 then
          game[i][j][4]+=1
          if game[i][j][4]>rand(6)+life_1 then
            game[i][j][1]=0
            game[i][j][2]=0
            game[i][j][3]=0
            game[i][j][4]=0
            game[i][j][5]=0
            if new_life(i,j)=1 then
            end if
          end if
          if has(i,j)=0 then
            game[i][j][3]+=1
          else
          end if
          if has(i,j)=1 and game[i][j][3]>=1 then
            game[i][j][3]=0
            number=rand(6+floor(number1/97))
            if number=1 then
              game[i][j][2]=0
            elsif number>1 then
              game[i][j][4]=40
            end if
          end if
          if game[i][j][3]>life_2 then
            game[i][j][1]=0
            game[i][j][2]=0
            game[i][j][3]=0
            game[i][j][4]=0
            game[i][j][5]=0
            if new_life(i,j)=1 then
            end if
          end if
        end if
      end for
  end for
end procedure

atom timer
timer=0
draw()

procedure del_pos()
  rectangle(row*5-5,line*5-5,row*5,line*5,0,0)
end procedure

procedure draw_pos()
  rectangle(row*5-5,line*5-5,row*5,line*5,-1,0)
end procedure
draw_pos()

while 1 do
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
 if key=331 then
   if row>1 then
     del_pos()
     row-=1
     draw_pos()
   end if
 end if
 if key=333 then
   if row<width then
     del_pos()
     row+=1
     draw_pos()
   end if
 end if
 if key=328 then
   if line>1 then
     del_pos()
     line-=1
     draw_pos()
   end if
 end if
 if key=336 then
   if line<height then
     del_pos()
     line+=1
     draw_pos()
   end if
 end if
 if key=13 then
   if game[line][row][1]=0 then
     game[line][row][1]=1
   elsif game[line][row][1]=1 then
     game[line][row][1]=2
   elsif game[line][row][1]=2 then
     game[line][row][1]=0
   end if
   draw2()
 end if
 if key='g' then
   can_work=1
 end if
 if key='n' then
   can_work=0
   new()
   draw()
 end if
 if key='s' then
   can_work=0
 end if
 if key='-' then
  speed+=100000
 end if
 if key='+' then
  speed-=100000
 end if
end if
if can_work=1 then
 timer+=1
 if timer>speed then
 life()
 death()
 draw()
 timer=0
 end if
end if
end while
