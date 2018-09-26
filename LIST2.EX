without type_check
include graphics.e
include file.e
include get.e
include font.e
include mouse2.e

if graphics_mode(18) then
end if

 function merge_sort(sequence x)
 -- put x into ascending order using a recursive merge sort
     integer n, mid
     sequence merged, a, b
          n = length(x)
     if n = 0 or n = 1 then
         return x  -- trivial case
     end if
          mid = floor(n/2)
     a = merge_sort(x[1..mid])       -- sort first half of x
     b = merge_sort(x[mid+1..n])     -- sort second half of x
          -- merge the two sorted halves into one
     merged = {}
     while length(a) > 0 and length(b) > 0 do
         if compare(a[1], b[1]) < 0 then
             merged = append(merged, a[1])
             a = a[2..length(a)]
         else
             merged = append(merged, b[1])
             b = b[2..length(b)]
         end if
     end while
     return merged & a & b  -- merged data plus leftovers
 end function

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

sequence drive, d, line
atom test, key
drive="c:\\euphoria\\"
d=""
line=""
d = dir(drive)
for i=1 to length(d) do
  test= compare(d[i][2],"d") 
  if test != 0 then
   line= append(line,d[i])
  end if
end for
sequence temp
temp=""

for i=1 to length(line) do
   for j=1 to length(line[i][1]) do
      if line[i][1][j]='.' then
        if compare(line[i][1][j..length(line[i][1])],".EX")=0 then
          temp=append(temp,line[i])
        end if
      end if
   end for
end for
line=temp
line=merge_sort(line)

sequence bitmap_info, image_exe, image_exe2
bitmap_info={}
object bitmap
bitmap=read_bitmap("exe.bmp")
image_exe=bitmap[2]
bitmap=read_bitmap("exe2.bmp")
image_exe2=bitmap[2]

procedure bitmap_work()
atom x, y
sequence name
rectangle(0,0,640,480,GRAY,1)

   for i=1 to length(bitmap_info) do
      name=bitmap_info[i][1]
      x=bitmap_info[i][2]
      y=bitmap_info[i][3]
      display_image({x,y},image_exe)
      draw_text({x,y+30},name,WHITE,-1,0)
   end for
end procedure

procedure work()
atom xx, yy, pos
xx=5
yy=5
pos=0
for i=1 to length(line) do
   if pos=8 then
     xx+=100
     yy=5
     pos=0
   end if
   bitmap_info=append(bitmap_info,{line[i][1][1..(length(line[i][1])-3)],xx,yy,0})
yy+=46
pos+=1
end for

end procedure

rectangle(0,0,640,480,GRAY,1)
work()
bitmap_work()

procedure mouse_work()
atom x, y, sel, exit_code
sequence name
   for i=1 to length(bitmap_info) do
      name=bitmap_info[i][1]
      x=bitmap_info[i][2]
      y=bitmap_info[i][3]
      sel=bitmap_info[i][4]
      if mouse_x>x and mouse_x <x+25 and mouse_y>y and mouse_y<y+25 and mouse_button=mb_left then
        if sel=1 then
        sel=0
        exit_code=system_exec("ex.exe "&name&".ex",0)
        bitmap_work()
        else
        sel=1
        end if
        display_image({x,y},image_exe2)
        draw_text({x,y+30},name,RED,-1,0)
      elsif mouse_button=mb_left then
        display_image({x,y},image_exe)
        draw_text({x,y+30},name,WHITE,-1,0)
        sel=0
      end if
      bitmap_info[i][4]=sel
   end for
end procedure

while 1 do
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
end if
mouse()
mouse_work()
end while

