include graphics.e
include image.e
include font.e
include misc.e
include get.e
include file.e
include wildcard.e
include database.e

sequence  map, image, temp_image
atom key, line, row, pic, screen_pos1, screen_pos2, event_number, image_number
atom width, height
object bitmap
line=1
row=1
pic=0
screen_pos1=1
screen_pos2=1
event_number=1
image={}
temp_image={}
image_number=1
width=50
height=25

if db_open("map", DB_LOCK_NO) != DB_OK then
  if db_create("map", DB_LOCK_NO) != DB_OK then
    puts(1,"err")
  end if
  if db_create_table("file") != DB_OK then
    puts(1,"err")
  end if
  if db_create_table("image") != DB_OK then
    puts(1,"err")
  end if
end if

procedure new_map()
map={}
for i=1 to height do
map=append(map,repeat({0,0},width))
end for
end procedure
new_map()
procedure add_map(sequence key, sequence data)
atom f
f = db_find_key(key)
if f >= 1 then
db_replace_data(f, data)
else
if db_insert(key, data) != DB_OK then
  puts(1,"err")
end if
end if
end procedure

procedure delete_key(sequence name)
atom d
d = db_find_key(name)
db_delete_record(d)
end procedure

procedure make(sequence data)
image={}
if db_select_table("image") != DB_OK then
  puts(1,"err")
end if
add_map(data[1],data[2])
for rec=1 to db_table_size() do
image=append(image,db_record_data(rec))
end for
if db_select_table("file") != DB_OK then
  puts(1,"err")
end if
end procedure

if db_select_table("image") != DB_OK then
  puts(1,"err")
end if
for rec=1 to db_table_size() do
image=append(image,db_record_data(rec))
image_number+=1
end for
if db_select_table("file") != DB_OK then
  puts(1,"err")
end if

procedure read_map(sequence key)
atom f
f = db_find_key(key)
if f >= 1 then
map=db_record_data(f)
end if
end procedure

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

if graphics_mode(13) then
end if

procedure draw()
  for i=screen_pos2 to 9+screen_pos2  do
     for j=screen_pos1 to 15+screen_pos1 do
        if map[i][j][1]=0 then
          display_image({(20*(j-screen_pos1+1))-20,(20*(i-screen_pos2+1))-20},image[1])
        end if
        if map[i][j][1]=1 then
          display_image({(20*(j-screen_pos1+1))-20,(20*(i-screen_pos2+1))-20},image[2])
        end if
        if map[i][j][1]=2 then
          display_image({(20*(j-screen_pos1+1))-20,(20*(i-screen_pos2+1))-20},image[3])
        end if
        if map[i][j][1]=3 then
          display_image({(20*(j-screen_pos1+1))-20,(20*(i-screen_pos2+1))-20},image[4])
        end if
        if map[i][j][1]=4 then
          display_image({(20*(j-screen_pos1+1))-20,(20*(i-screen_pos2+1))-20},image[5])
        end if
        if map[i][j][1]=5 then
          display_image({(20*(j-screen_pos1+1))-20,(20*(i-screen_pos2+1))-20},image[6])
        end if
        if map[i][j][1]=6 then
          display_image({(20*(j-screen_pos1+1))-20,(20*(i-screen_pos2+1))-20},image[7])
        end if
        if map[i][j][1]=7 then
          display_image({(20*(j-screen_pos1+1))-20,(20*(i-screen_pos2+1))-20},image[8])
        end if                                                                              if map[i][j][1]=8 then
          display_image({(20*(j-screen_pos1+1))-20,(20*(i-screen_pos2+1))-20},image[9])
        end if
        if map[i][j][1]=9 then
          display_image({(20*(j-screen_pos1+1))-20,(20*(i-screen_pos2+1))-20},image[10])
        end if
        if map[i][j][1]=10 then
          display_image({(20*(j-screen_pos1+1))-20,(20*(i-screen_pos2+1))-20},image[11])
        end if
        if map[i][j][2]>0 then
          draw_text({(20*(j-screen_pos1+1))-20,(20*(i-screen_pos2+1))-20},sprint(map[i][j][2]),RED,-1,0)
        end if
     end for
  end for
end procedure

procedure draw_pos()
draw()
rectangle((20*(row-screen_pos1+1))-20,(20*(line-screen_pos2+1))-20,(20*(row-screen_pos1+1)),(20*(line-screen_pos2+1)),0,0)
draw_text({10,180},sprint(row),1,-1,0)
draw_text({50,180},sprint(line),1,-1,0)
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
 if row-screen_pos1=1 then
 if screen_pos1>1 then
 screen_pos1-=1
 end if
 row-=1
 pic=0
 draw_pos()
 else
 pic=0
 row-=1
 draw_pos()
 end if
 end if
 end if
 if key=333 then
 if row<length(map[line]) then
 if row-screen_pos1=15 then
 screen_pos1+=1
 row+=1
 pic=0
 draw_pos()
 else
 row+=1
 pic=0
 draw_pos()
 end if
 end if
 end if
 if key=328 then
 if line>1 then
 if line-screen_pos2=1 then
 if screen_pos2>1 then
 screen_pos2-=1
 end if
 line-=1
 pic=0
 draw_pos()
 else
 pic=0
 line-=1
 draw_pos()
 end if
 end if
 end if
 if key=336 then
 if line<length(map) then
 if line-screen_pos2=9 then
 screen_pos2+=1
 line+=1
 pic=0
 draw_pos()
 else
 line+=1
 pic=0
 draw_pos()
 end if
 end if
 end if
 if key='e' then
 if map[line][row][2]>0 then
 map[line][row][2]=0
 else
 map[line][row][2]=event_number
 event_number+=1
 end if
 draw_pos()
 end if
 if key='s' then
 position(1,1)
 add_map(prompt_string("Enter Map? "),map)
 draw_pos()
 end if
 if key='o' then
 position(1,1)
 read_map(prompt_string("Enter Map? "))
 draw_pos()
 end if
 if key='n' then
 position(1,1)
 if compare(prompt_string("Do You To Start A New Map Yes or NO? "),"y") =0 then
 event_number=1
 map={}
 width=prompt_number("What is width of the map? ", {0, 1000})
 height=prompt_number("What is height of the map? ", {0, 1000})
 new_map()
 screen_pos1=1
 screen_pos2=1
 line=1
 row=1
 end if
 draw_pos()
 end if
 if key='p' then
 if pic=length(image) then
 pic=0
 end if
 map[line][row][1]=pic
 draw_pos()
 pic+=1
 end if
 if key='i' then
  bitmap={}
  temp_image={}
  bitmap=read_bitmap(prompt_string("Enter image? "))
  temp_image=bitmap[2]
  if length(temp_image)>0 then
  make({"image"&sprint(image_number),temp_image})
  image_number+=1
  end if
 end if
end if
end while

if graphics_mode(18) then
end if

if db_compress() != DB_OK then
  puts(2, "compress failed!\n")
end if
