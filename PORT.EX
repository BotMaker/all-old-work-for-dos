without type_check
include graphics.e
include machine.e
include get.e

atom key, info, addres
info=0
addres=0
sequence info2
if graphics_mode(18) then
end if

while 1 do
info+=0.1
if info >100000 then
  info=0
info2=peek({6000000+addres,1000})
clear_screen()
position(1,1)
for i=1 to length(info2)-81 by 40 do
puts(1,info2[i..i+40]&"\n")
end for
addres+=1000
end if
key=get_key()
if key != -1 then
 if key=27 then
  clear_screen()
  ?addres
  exit
 end if
end if
end while

while 1 do
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
end if
end while
