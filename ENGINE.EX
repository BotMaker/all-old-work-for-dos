without type_check
global atom key
include engine.e
--transparent

if graphics_mode(18) then
end if

sequence background
background={}
sequence image_enemy, object_info, image_shoot, image_player
atom player_id, player_shoot_id ,enemy_id, enemy_shoot_id, enemy_rand_time, enemy_time
atom attack_wave, can
can=1
attack_wave=1
enemy_rand_time=10
enemy_time=5
player_id=1
player_shoot_id=2
enemy_id=3
enemy_shoot_id=4
object_info={}
object bitmap
bitmap=read_bitmap("ship.bmp")
image_enemy=bitmap[2]
image_enemy=transparent(image_enemy,7)
bitmap=read_bitmap("ship2.bmp")
image_player=bitmap[2]
image_player=transparent(image_player,7)

image_shoot={{0,5,5,0},
             {0,5,5,0},
             {0,5,5,0},
             {0,5,5,0},
             {0,5,5,0},
             {0,5,5,0},
             {0,5,5,0},
             {0,5,5,0}}

sequence string_number
string_number={"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37",
"38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76",
"77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102"}

function string(atom n)
for i=0 to 100 do
   if i=n then
     return string_number[i+1]
   end if
end for
return "0"
end function


procedure new_background()
background={}
   for i=1 to 479 do
      background=append(background,repeat(0,639)) 
   end for
end procedure

procedure add_starts()
atom x
   for i=1 to 479 do
      for j=1 to 639 do
         x= rand(100)
          background[i][j]=0
        if x=50 then
          background[i][j]=7
         end if
      end for
   end for
end procedure

procedure move_background()
sequence temp1, temp2
temp1={}
temp2={}
   for i=1 to length(background)-6 do
      temp1=append(temp1, background[i])
   end for
   for i=length(background)-6 to length(background)-1 do
      temp2=append(temp2, background[i])
   end for
background={}
background=temp2&temp1
screen=background
end procedure

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

function col_1(atom id ,atom x, atom y, atom cx, atom cy, atom delete)
atom x2, y2, cx2, cy2, id2
for i=1 to length(object_info) do
   id2=object_info[i][1]
   x2=object_info[i][2]
   y2=object_info[i][3]
   cx2=object_info[i][4]
   cy2=object_info[i][5]
   if id2=id then
     if x2>=x and x2<=cx and y2<=cy and y2>=y then
       if delete=1 then
         object_info=remove_line(object_info,i)
       end if
       return 1
     end if
   end if
end for
return 0
end function

procedure game()
atom id,x,y,cx,cy, dir,timer, rr, temp_live, key2, number
number=0
move_background()
  for i=1 to length(object_info) do
     id=object_info[i][1]
     x=object_info[i][2]
     y=object_info[i][3]
     cx=object_info[i][4]
     cy=object_info[i][5]
     key2=get_key()
     if id=player_id then
       timer=object_info[i][6]
       timer+=1
       if key2!=-1 then
       if key2=331 then
         x-=8
         cx-=8
       end if
       if key2=333 and x<628 then
         x+=8
         cx+=8
       end if
       if key2=32 and timer>20 then
         object_info=append(object_info,{player_shoot_id,x+2,y-4,x+2+4,y-4+8})
         object_info=append(object_info,{player_shoot_id,x+28,y-4,x+28+4,y-4+8})
         timer=0
       end if
       end if
       write_screen(image_player,{x,y},1)
       object_info[i][6]=timer
     elsif id=player_shoot_id then
       y-=12
       cy-=12
       write_screen(image_shoot,{x,y},0)
     elsif id=enemy_id then
       dir=object_info[i][6]
       timer=object_info[i][7]
       timer+=1
       rr=rand(enemy_rand_time)
       if rr=enemy_time and y>1 then
         object_info=append(object_info,{enemy_shoot_id,x+14,y-4,x+14+4,y-4+8})
       end if
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
       write_screen(image_enemy,{x,y},1)
       object_info[i][6]=dir
       object_info[i][7]=timer
     elsif id=enemy_shoot_id then
       y+=12
       cy+=12
       write_screen(image_shoot,{x,y},0)
     end if
     object_info[i][2]=x
     object_info[i][3]=y
     object_info[i][4]=cx
     object_info[i][5]=cy
     if key2!=-1 then
     if key2=27 then
       object_info={}
       exit
     end if
     end if
  end for
-- colosuis
for i=1 to length(object_info) do
   for j=1 to length(object_info) do
      id=object_info[j][1]
      x=object_info[j][2]
      y=object_info[j][3]
      cx=object_info[j][4]
      cy=object_info[j][5]
      if id=player_shoot_id then
        if y<0 then
          object_info=remove_line(object_info,j)
          exit
        end if
      end if
      if id=enemy_shoot_id then
        if y>480 then
          object_info=remove_line(object_info,j)
          exit
        end if
      end if
      if id=enemy_id then
        if col_1(player_shoot_id,x,y,cx,cy,1)=1 then
          object_info=remove_line(object_info,j)
          exit
        end if
      end if
      if id=player_id then
        if col_1(enemy_shoot_id,x,y,cx,cy,1)=1 then
          --object_info=remove_line(object_info,j)
          object_info[j][7]-=10
          if object_info[j][7]<0 then
            temp_live=object_info[j][8]
            if temp_live-1 =0 then
              object_info={}
              exit
            end if
            object_info[j][7]=100
            object_info[j][8]=temp_live-1
            object_info[j][2]=310
            object_info[j][3]=410
            object_info[j][4]=342
            object_info[j][5]=442
          end if
          exit
        end if
      end if
   end for
end for
for i=1 to length(object_info) do
   id=object_info[i][1]
   if can=0 then
     if id=enemy_id then
       number+=1
     end if
     if number=0 and i= length(object_info) then
       attack_wave+=1
       can=1
     end if
   end if
end for
end procedure

procedure game2()
atom id,x,y,cx,cy
  for i=1 to length(object_info) do
     id=object_info[i][1]
     x=object_info[i][2]
     y=object_info[i][3]
     cx=object_info[i][4]
     cy=object_info[i][5]
     if id=player_id then
       rectangle(1,440,640,480,6,1)
       draw_text({10,440},"HELATH "&string(object_info[i][7]),RED,6,0,{0,0})
       draw_text({10,460},"LIVES "&string(object_info[i][8]),RED,6,0,{0,0})
       exit
     end if
  end for
end procedure

new_background()
add_starts()
new_screen(0)

object_info=append(object_info,{player_id,310,410,342,442,0,100,3})

atom timer
timer=0

procedure wave()
if attack_wave=1 and can=1 then
timer+=1
if timer<100 then
draw_text({300,240},"WAVE 1",RED,0,0,{0,0})
else
draw_text({280,240},"GET READY",RED,0,0,{0,0})
end if
if timer>150 then
enemy_rand_time=250
enemy_time=125
--line0
object_info=append(object_info,{enemy_id,10,-40,42,-8,0,0})
object_info=append(object_info,{enemy_id,50,-40,82,-8,0,0})
object_info=append(object_info,{enemy_id,90,-40,122,-8,0,0})
object_info=append(object_info,{enemy_id,130,-40,162,-8,0,0})
object_info=append(object_info,{enemy_id,170,-40,202,-8,0,0})
object_info=append(object_info,{enemy_id,210,-40,242,-8,0,0})
object_info=append(object_info,{enemy_id,250,-40,282,-8,0,0})
object_info=append(object_info,{enemy_id,290,-40,322,-8,0,0})
object_info=append(object_info,{enemy_id,330,-40,362,-8,0,0})
object_info=append(object_info,{enemy_id,370,-40,402,-8,0,0})
object_info=append(object_info,{enemy_id,410,-40,442,-8,0,0})
object_info=append(object_info,{enemy_id,450,-40,482,-8,0,0})
-- line1
object_info=append(object_info,{enemy_id,10,10,42,42,0,0})
object_info=append(object_info,{enemy_id,50,10,82,42,0,0})
object_info=append(object_info,{enemy_id,90,10,122,42,0,0})
object_info=append(object_info,{enemy_id,130,10,162,42,0,0})
object_info=append(object_info,{enemy_id,170,10,202,42,0,0})
object_info=append(object_info,{enemy_id,210,10,242,42,0,0})
object_info=append(object_info,{enemy_id,250,10,282,42,0,0})
object_info=append(object_info,{enemy_id,290,10,322,42,0,0})
object_info=append(object_info,{enemy_id,330,10,362,42,0,0})
object_info=append(object_info,{enemy_id,370,10,402,42,0,0})
object_info=append(object_info,{enemy_id,410,10,442,42,0,0})
object_info=append(object_info,{enemy_id,450,10,482,42,0,0})
--done
can=0
timer=0
end if
end if

if attack_wave=2 and can=1 then
timer+=1
if timer<100 then
draw_text({300,240},"WAVE 2",RED,0,0,{0,0})
else
draw_text({280,240},"GET READY",RED,0,0,{0,0})
end if
if timer>150 then
enemy_rand_time=200
enemy_time=100
--line0
object_info=append(object_info,{enemy_id,10,-40,42,-8,0,0})
object_info=append(object_info,{enemy_id,50,-40,82,-8,0,0})
object_info=append(object_info,{enemy_id,90,-40,122,-8,0,0})
object_info=append(object_info,{enemy_id,130,-40,162,-8,0,0})
object_info=append(object_info,{enemy_id,170,-40,202,-8,0,0})
object_info=append(object_info,{enemy_id,210,-40,242,-8,0,0})
object_info=append(object_info,{enemy_id,250,-40,282,-8,0,0})
object_info=append(object_info,{enemy_id,290,-40,322,-8,0,0})
object_info=append(object_info,{enemy_id,330,-40,362,-8,0,0})
object_info=append(object_info,{enemy_id,370,-40,402,-8,0,0})
object_info=append(object_info,{enemy_id,410,-40,442,-8,0,0})
object_info=append(object_info,{enemy_id,450,-40,482,-8,0,0})
-- line1
object_info=append(object_info,{enemy_id,10,10,42,42,0,0})
object_info=append(object_info,{enemy_id,50,10,82,42,0,0})
object_info=append(object_info,{enemy_id,90,10,122,42,0,0})
object_info=append(object_info,{enemy_id,130,10,162,42,0,0})
object_info=append(object_info,{enemy_id,170,10,202,42,0,0})
object_info=append(object_info,{enemy_id,210,10,242,42,0,0})
object_info=append(object_info,{enemy_id,250,10,282,42,0,0})
object_info=append(object_info,{enemy_id,290,10,322,42,0,0})
object_info=append(object_info,{enemy_id,330,10,362,42,0,0})
object_info=append(object_info,{enemy_id,370,10,402,42,0,0})
object_info=append(object_info,{enemy_id,410,10,442,42,0,0})
object_info=append(object_info,{enemy_id,450,10,482,42,0,0})
--done
can=0
timer=0
end if
end if

if attack_wave=3 and can=1 then
timer+=1
if timer<100 then
draw_text({300,240},"WAVE 3",RED,0,0,{0,0})
else
draw_text({280,240},"GET READY",RED,0,0,{0,0})
end if
if timer>150 then
enemy_rand_time=100
enemy_time=50
--line0
object_info=append(object_info,{enemy_id,10,-40,42,-8,0,0})
object_info=append(object_info,{enemy_id,50,-40,82,-8,0,0})
object_info=append(object_info,{enemy_id,90,-40,122,-8,0,0})
object_info=append(object_info,{enemy_id,130,-40,162,-8,0,0})
object_info=append(object_info,{enemy_id,170,-40,202,-8,0,0})
object_info=append(object_info,{enemy_id,210,-40,242,-8,0,0})
object_info=append(object_info,{enemy_id,250,-40,282,-8,0,0})
object_info=append(object_info,{enemy_id,290,-40,322,-8,0,0})
object_info=append(object_info,{enemy_id,330,-40,362,-8,0,0})
object_info=append(object_info,{enemy_id,370,-40,402,-8,0,0})
object_info=append(object_info,{enemy_id,410,-40,442,-8,0,0})
object_info=append(object_info,{enemy_id,450,-40,482,-8,0,0})
-- line1
object_info=append(object_info,{enemy_id,10,10,42,42,0,0})
object_info=append(object_info,{enemy_id,50,10,82,42,0,0})
object_info=append(object_info,{enemy_id,90,10,122,42,0,0})
object_info=append(object_info,{enemy_id,130,10,162,42,0,0})
object_info=append(object_info,{enemy_id,170,10,202,42,0,0})
object_info=append(object_info,{enemy_id,210,10,242,42,0,0})
object_info=append(object_info,{enemy_id,250,10,282,42,0,0})
object_info=append(object_info,{enemy_id,290,10,322,42,0,0})
object_info=append(object_info,{enemy_id,330,10,362,42,0,0})
object_info=append(object_info,{enemy_id,370,10,402,42,0,0})
object_info=append(object_info,{enemy_id,410,10,442,42,0,0})
object_info=append(object_info,{enemy_id,450,10,482,42,0,0})
--done
can=0
timer=0
end if
end if

if attack_wave=4 and can=1 then
timer+=1
if timer<100 then
draw_text({300,240},"WAVE 4",RED,0,0,{0,0})
else
draw_text({280,240},"GET READY",RED,0,0,{0,0})
end if
if timer>150 then
enemy_rand_time=50
enemy_time=25
--line0
object_info=append(object_info,{enemy_id,10,-40,42,-8,0,0})
object_info=append(object_info,{enemy_id,50,-40,82,-8,0,0})
object_info=append(object_info,{enemy_id,90,-40,122,-8,0,0})
object_info=append(object_info,{enemy_id,130,-40,162,-8,0,0})
object_info=append(object_info,{enemy_id,170,-40,202,-8,0,0})
object_info=append(object_info,{enemy_id,210,-40,242,-8,0,0})
object_info=append(object_info,{enemy_id,250,-40,282,-8,0,0})
object_info=append(object_info,{enemy_id,290,-40,322,-8,0,0})
object_info=append(object_info,{enemy_id,330,-40,362,-8,0,0})
object_info=append(object_info,{enemy_id,370,-40,402,-8,0,0})
object_info=append(object_info,{enemy_id,410,-40,442,-8,0,0})
object_info=append(object_info,{enemy_id,450,-40,482,-8,0,0})
-- line1
object_info=append(object_info,{enemy_id,10,10,42,42,0,0})
object_info=append(object_info,{enemy_id,50,10,82,42,0,0})
object_info=append(object_info,{enemy_id,90,10,122,42,0,0})
object_info=append(object_info,{enemy_id,130,10,162,42,0,0})
object_info=append(object_info,{enemy_id,170,10,202,42,0,0})
object_info=append(object_info,{enemy_id,210,10,242,42,0,0})
object_info=append(object_info,{enemy_id,250,10,282,42,0,0})
object_info=append(object_info,{enemy_id,290,10,322,42,0,0})
object_info=append(object_info,{enemy_id,330,10,362,42,0,0})
object_info=append(object_info,{enemy_id,370,10,402,42,0,0})
object_info=append(object_info,{enemy_id,410,10,442,42,0,0})
object_info=append(object_info,{enemy_id,450,10,482,42,0,0})
--done
can=0
timer=0
end if
end if

if attack_wave=5 and can=1 then
timer+=1
if timer<100 then
draw_text({300,240},"WAVE 5",RED,0,0,{0,0})
else
draw_text({280,240},"GET READY",RED,0,0,{0,0})
end if
if timer>150 then
enemy_rand_time=40
enemy_time=20
--line0
object_info=append(object_info,{enemy_id,10,-40,42,-8,0,0})
object_info=append(object_info,{enemy_id,50,-40,82,-8,0,0})
object_info=append(object_info,{enemy_id,90,-40,122,-8,0,0})
object_info=append(object_info,{enemy_id,130,-40,162,-8,0,0})
object_info=append(object_info,{enemy_id,170,-40,202,-8,0,0})
object_info=append(object_info,{enemy_id,210,-40,242,-8,0,0})
object_info=append(object_info,{enemy_id,250,-40,282,-8,0,0})
object_info=append(object_info,{enemy_id,290,-40,322,-8,0,0})
object_info=append(object_info,{enemy_id,330,-40,362,-8,0,0})
object_info=append(object_info,{enemy_id,370,-40,402,-8,0,0})
object_info=append(object_info,{enemy_id,410,-40,442,-8,0,0})
object_info=append(object_info,{enemy_id,450,-40,482,-8,0,0})
-- line1
object_info=append(object_info,{enemy_id,10,10,42,42,0,0})
object_info=append(object_info,{enemy_id,50,10,82,42,0,0})
object_info=append(object_info,{enemy_id,90,10,122,42,0,0})
object_info=append(object_info,{enemy_id,130,10,162,42,0,0})
object_info=append(object_info,{enemy_id,170,10,202,42,0,0})
object_info=append(object_info,{enemy_id,210,10,242,42,0,0})
object_info=append(object_info,{enemy_id,250,10,282,42,0,0})
object_info=append(object_info,{enemy_id,290,10,322,42,0,0})
object_info=append(object_info,{enemy_id,330,10,362,42,0,0})
object_info=append(object_info,{enemy_id,370,10,402,42,0,0})
object_info=append(object_info,{enemy_id,410,10,442,42,0,0})
object_info=append(object_info,{enemy_id,450,10,482,42,0,0})
--done
can=0
timer=0
end if
end if

if attack_wave=6 and can=1 then
timer+=1
if timer<100 then
draw_text({300,240},"WAVE 6",RED,0,0,{0,0})
else
draw_text({280,240},"GET READY",RED,0,0,{0,0})
end if
if timer>150 then
enemy_rand_time=30
enemy_time=15
--line0
object_info=append(object_info,{enemy_id,10,-40,42,-8,0,0})
object_info=append(object_info,{enemy_id,50,-40,82,-8,0,0})
object_info=append(object_info,{enemy_id,90,-40,122,-8,0,0})
object_info=append(object_info,{enemy_id,130,-40,162,-8,0,0})
object_info=append(object_info,{enemy_id,170,-40,202,-8,0,0})
object_info=append(object_info,{enemy_id,210,-40,242,-8,0,0})
object_info=append(object_info,{enemy_id,250,-40,282,-8,0,0})
object_info=append(object_info,{enemy_id,290,-40,322,-8,0,0})
object_info=append(object_info,{enemy_id,330,-40,362,-8,0,0})
object_info=append(object_info,{enemy_id,370,-40,402,-8,0,0})
object_info=append(object_info,{enemy_id,410,-40,442,-8,0,0})
object_info=append(object_info,{enemy_id,450,-40,482,-8,0,0})
-- line1
object_info=append(object_info,{enemy_id,10,10,42,42,0,0})
object_info=append(object_info,{enemy_id,50,10,82,42,0,0})
object_info=append(object_info,{enemy_id,90,10,122,42,0,0})
object_info=append(object_info,{enemy_id,130,10,162,42,0,0})
object_info=append(object_info,{enemy_id,170,10,202,42,0,0})
object_info=append(object_info,{enemy_id,210,10,242,42,0,0})
object_info=append(object_info,{enemy_id,250,10,282,42,0,0})
object_info=append(object_info,{enemy_id,290,10,322,42,0,0})
object_info=append(object_info,{enemy_id,330,10,362,42,0,0})
object_info=append(object_info,{enemy_id,370,10,402,42,0,0})
object_info=append(object_info,{enemy_id,410,10,442,42,0,0})
object_info=append(object_info,{enemy_id,450,10,482,42,0,0})
--done
can=0
timer=0
end if
end if

if attack_wave=7 and can=1 then
timer+=1
if timer<100 then
draw_text({300,240},"WAVE 7",RED,0,0,{0,0})
else
draw_text({280,240},"GET READY",RED,0,0,{0,0})
end if
if timer>150 then
enemy_rand_time=20
enemy_time=10
--line0
object_info=append(object_info,{enemy_id,10,-40,42,-8,0,0})
object_info=append(object_info,{enemy_id,50,-40,82,-8,0,0})
object_info=append(object_info,{enemy_id,90,-40,122,-8,0,0})
object_info=append(object_info,{enemy_id,130,-40,162,-8,0,0})
object_info=append(object_info,{enemy_id,170,-40,202,-8,0,0})
object_info=append(object_info,{enemy_id,210,-40,242,-8,0,0})
object_info=append(object_info,{enemy_id,250,-40,282,-8,0,0})
object_info=append(object_info,{enemy_id,290,-40,322,-8,0,0})
object_info=append(object_info,{enemy_id,330,-40,362,-8,0,0})
object_info=append(object_info,{enemy_id,370,-40,402,-8,0,0})
object_info=append(object_info,{enemy_id,410,-40,442,-8,0,0})
object_info=append(object_info,{enemy_id,450,-40,482,-8,0,0})
-- line1
object_info=append(object_info,{enemy_id,10,10,42,42,0,0})
object_info=append(object_info,{enemy_id,50,10,82,42,0,0})
object_info=append(object_info,{enemy_id,90,10,122,42,0,0})
object_info=append(object_info,{enemy_id,130,10,162,42,0,0})
object_info=append(object_info,{enemy_id,170,10,202,42,0,0})
object_info=append(object_info,{enemy_id,210,10,242,42,0,0})
object_info=append(object_info,{enemy_id,250,10,282,42,0,0})
object_info=append(object_info,{enemy_id,290,10,322,42,0,0})
object_info=append(object_info,{enemy_id,330,10,362,42,0,0})
object_info=append(object_info,{enemy_id,370,10,402,42,0,0})
object_info=append(object_info,{enemy_id,410,10,442,42,0,0})
object_info=append(object_info,{enemy_id,450,10,482,42,0,0})
--done
can=0
timer=0
end if
end if

end procedure

while 1 do
if length(object_info)=0 then
key=get_key()
if key != -1 then
if key=27 then
exit
end if
end if
end if
game()
game2()
wave()
draw_screen()
end while
