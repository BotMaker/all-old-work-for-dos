without type_check
without warning

include graphics.e
include mouse2.e
include font.e
include image.e

atom key

if graphics_mode(18) then
end if

procedure line(atom x, atom y, atom xx, atom yy, atom color)
  draw_line(color,{{x,y},{xx,yy}})
end procedure

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
  polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

sequence text, buffer
integer chr1,line1
text={}
chr1=0
line1=1
buffer={}

procedure display_line()
  if length(buffer)<=1 then
    position(1,1)
    puts(1,text)
  else
    for i=1 to length(buffer) do
      position(i,1)
      puts(1,buffer[i])
    end for
  end if
end procedure

procedure insert_chr(integer chr)
  sequence a,b
  if length(text)>0 then
    a=text[1..chr1]
    b=text[chr1+1..length(text)]
    text=a&chr&b
   end if
   if length(text)=0 then
     text&=chr
   end if
   chr1+=1
end procedure

procedure user_input()
 if key >2 and key <256 then
   if key!=128 and key!=64 and key!=27 and key!=13 and key!=8 and key!=4 then
     insert_chr(key)
     display_line()
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
user_input()
end while
