without type_check
include graphics.e
include mouse2.e
include font.e
include image.e

sequence borad
atom key
borad={{{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1}},
       {{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1}},
       {{0,1},{0,1},{1,30},{0,6},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1}},
       {{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1}},
       {{1,2},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{2,7}},
       {{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1}},
       {{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1}},
       {{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1}},
       {{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1}},
       {{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1},{0,1}}}

sequence image_grass, image_gray, image_blue, image_red
object bitmap
bitmap=read_bitmap("grass.bmp")
image_grass=bitmap[2]
bitmap=read_bitmap("gray.bmp")
image_gray=bitmap[2]
bitmap=read_bitmap("blue.bmp")
image_blue=bitmap[2]
bitmap=read_bitmap("red.bmp")
image_red=bitmap[2]

sequence string_number
string_number={"0","1","2","3","4","5","6","7","8","9","10","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","28","29","30","31","32"}

function string(atom n)
for i=0 to 32 do
   if i=n then
     return string_number[i+1]
   end if
end for
return "0"
end function

if graphics_mode(18) then
end if

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

procedure draw_game()
  for i=0 to 380 by 40 do
     for j=0 to 580 by 40 do
        rectangle(j,i,j+40,i+40,WHITE,0)
        display_image({j+1,i+1},image_grass)
     end for
  end for
  for y=1 to length(borad) do
     for x=1 to length(borad[y]) do
        if borad[y][x][1]=0 then
          rectangle((40*x)-39,(40*y)-39,(40*x),(40*y),GRAY,0)
          display_image({(40*x)-40+16,(40*y)-40+16},image_gray)
          draw_text({(40*x)-40+2,(40*y)-40+2},string(borad[y][x][2]),GRAY,GREEN,0)
        end if
        if borad[y][x][1]=1 then
          rectangle((40*x)-40,(40*y)-40,(40*x),(40*y),BLUE,0)
          display_image({(40*x)-40+16,(40*y)-40+16},image_blue)
          draw_text({(40*x)-40+2,(40*y)-40+2},string(borad[y][x][2]),BLUE,GREEN,0)
        end if
        if borad[y][x][1]=2 then
          rectangle((40*x)-40,(40*y)-40,(40*x),(40*y),RED,0)
          display_image({(40*x)-40+16,(40*y)-40+16},image_red)
          draw_text({(40*x)-40+2,(40*y)-40+2},string(borad[y][x][2]),RED,GREEN,0)
        end if
     end for
  end for
end procedure
draw_game()

atom number, number2
number=0
number2=0
procedure draw_sel(atom line, atom row)
  for y=line to line do
     for x=row to row do
        if borad[y][x][1]=1 then
          rectangle((40*x)-39,(40*y)-39,(40*x),(40*y),WHITE,0)
          display_image({(40*x)-40+16,(40*y)-40+16},image_blue)
          draw_text({(40*x)-40+2,(40*y)-40+2},string(borad[y][x][2]),BLUE,GREEN,0)
        end if
     end for
  end for
end procedure

function attack()
atom temp
temp=number
number-=number2
number2-=temp
if number<=0 then
return 0
else
return 1
end if
end function

procedure work(atom line, atom row)
draw_sel(line,row)
number+=1
while 1 do
mouse()
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
end if
if floor(mouse_x/40)+1=row and floor(mouse_y/40)+1=line then
  if mouse_button=mb_left then
    if borad[line][row][2]>number+1 then
      number+=1
    end if
  end if
  if mouse_button=mb_right then
    if number>0 then
      number-=1
    end if
    if number=0 then
      draw_game()
      draw_text({10,440},string(number),WHITE,BLACK,0)
      exit
    end if
  end if
end if

if mouse_button=mb_left then
  -- grid1
  if floor(mouse_x/40)+1<=row-1 and floor(mouse_y/40)+1<=line-1 and number>0 and borad[line][row][2]-number>0 then
    if borad[line-1][row-1][1]=0 then
      borad[line][row][2]-=number
      number2=borad[line-1][row-1][2]
      if attack()=1 then
        borad[line-1][row-1][1]=1
        borad[line-1][row-1][2]=number
      else
        borad[line-1][row-1][2]=number2
      end if
      mouse_button=0
      draw_game()
      draw_text({10,440},string(number),WHITE,BLACK,0)
      number=0
      exit
    end if
  end if
  --grid2 
  if floor(mouse_x/40)+1=row and floor(mouse_y/40)+1<=line-1 and number>0 and borad[line][row][2]-number>0 then
    if borad[line-1][row][1]=0 then
      borad[line][row][2]-=number
       number2=borad[line-1][row][2]

       if attack()=1 then
         borad[line-1][row][1]=1
         borad[line-1][row][2]=number
       else
         borad[line-1][row][2]=number2
       end if
      mouse_button=0
      draw_game()
      draw_text({10,440},string(number),WHITE,BLACK,0)
      number=0
      exit
     end if

  end if
  --grid3 
  if floor(mouse_x/40)+1=row+1 and floor(mouse_y/40)+1<=line-1 and number>0 and borad[line][row][2]-number>0 then
    if borad[line-1][row+1][1]=0 then
      borad[line][row][2]-=number
       number2=borad[line-1][row+1][2]

       if attack()=1 then
         borad[line-1][row+1][1]=1
         borad[line-1][row+1][2]=number
       else
         borad[line-1][row+1][2]=number2
       end if
      mouse_button=0
      draw_game()
      draw_text({10,440},string(number),WHITE,BLACK,0)
      number=0
      exit
     end if

  end if
  --grid4 
  if floor(mouse_x/40)+1=row+1 and floor(mouse_y/40)+1=line and number>0 and borad[line][row][2]-number>0 then
    if borad[line][row+1][1]=0 then
      borad[line][row][2]-=number
       number2=borad[line][row+1][2]

       if attack()=1 then
         borad[line][row+1][1]=1
         borad[line][row+1][2]=number
       else
         borad[line][row+1][2]=number2
       end if
      mouse_button=0
      draw_game()
      draw_text({10,440},string(number),WHITE,BLACK,0)
      number=0
      exit
     end if
  end if
  --grid5 
  if floor(mouse_x/40)+1=row+1 and floor(mouse_y/40)+1=line+1 and number>0 and borad[line][row][2]-number>0 then
    if borad[line][row+1][1]=0 then
      borad[line][row][2]-=number
       number2=borad[line+1][row+1][2]

       if attack()=1 then
         borad[line+1][row+1][1]=1
         borad[line+1][row+1][2]=number
       else
         borad[line+1][row+1][2]=number2
       end if
      mouse_button=0
      draw_game()
      draw_text({10,440},string(number),WHITE,BLACK,0)
      number=0
      exit
     end if
  end if
  --grid6 
  if floor(mouse_x/40)+1=row and floor(mouse_y/40)+1=line+1 and number>0 and borad[line][row][2]-number>0 then
    if borad[line+1][row][1]=0 then
      borad[line][row][2]-=number
       number2=borad[line+1][row][2]

       if attack()=1 then
         borad[line+1][row][1]=1
         borad[line+1][row][2]=number
       else
         borad[line+1][row][2]=number2
       end if
      mouse_button=0
      draw_game()
      draw_text({10,440},string(number),WHITE,BLACK,0)
      number=0
      exit
     end if

  end if
  --grid7 
  if floor(mouse_x/40)+1=row-1 and floor(mouse_y/40)+1=line+1 and number>0 and borad[line][row][2]-number>0 then
    if borad[line+1][row-1][1]=0 then
      borad[line][row][2]-=number
       number2=borad[line+1][row-1][2]

       if attack()=1 then
         borad[line+1][row-1][1]=1
         borad[line+1][row-1][2]=number
       else
         borad[line+1][row-1][2]=number2
       end if
      mouse_button=0
      draw_game()
      draw_text({10,440},string(number),WHITE,BLACK,0)
      number=0
      exit
     end if

  end if

  --grid8 
  if floor(mouse_x/40)+1=row-1 and floor(mouse_y/40)+1=line and number>0 and borad[line][row][2]-number>0 then
    if borad[line][row-1][1]=0 then
      borad[line][row][2]-=number
       number2=borad[line][row-1][2]

       if attack()=1 then
         borad[line][row-1][1]=1
         borad[line][row-1][2]=number
       else
         borad[line][row-1][2]=number2
       end if
      mouse_button=0
      draw_game()
      draw_text({10,440},string(number),WHITE,BLACK,0)
      number=0
      exit
     end if
    end if
end if
draw_text({10,440},string(number),WHITE,BLACK,0)
end while
end procedure

procedure run()
  if mouse_x>0 and mouse_x<580 and mouse_y>0 and mouse_y<380 then
    if mouse_button=mb_left then
      if borad[floor(mouse_y/40)+1][floor(mouse_x/40)+1][1]=1 then
         work(floor(mouse_y/40)+1,floor(mouse_x/40)+1)
      end if
    end if
  end if
end procedure

while 1 do
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
end if
mouse()
run()
end while
