without type_check
include graphics.e
include image.e
include font.e

if graphics_mode(13) then
end if

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

atom key, p_hp, p_s, c_hp, c_s, sel
p_hp=100
p_s=0
c_hp=100
c_s=0
sel=1

sequence item_list, attack_list
item_list={"soward","arrow","javalin"}
attack_list={}

procedure init()
for i=1 to length(item_list) do
   if compare(item_list[i],"soward")=0 then
     attack_list=append(attack_list,{"soward",3})
   end if
   if compare(item_list[i],"arrow")=0 then
     attack_list=append(attack_list,{"arrow",2})
   end if
   if compare(item_list[i],"javalin")=0 then
     attack_list=append(attack_list,{"jav",2})
   end if
end for
end procedure

rectangle(1,1,320,200,-1,1)
-- midial
rectangle(1,98,320,102,GRAY,1)
-- -player1
draw_text({3,2},"player1",1,-1,0)
draw_text({3,22},"Hp "&sprint(p_hp)&"/100",1,-1,0)
draw_text({3,42},"shiled "&sprint(p_s),1,-1,0)

-- player2
draw_text({3,104},"player2",RED,-1,0)
draw_text({3,124},"Hp 30/100",RED,-1,0)
draw_text({3,144},"shiled 2",RED,-1,0)
-- out line
rectangle(1,1,319,199,1,0)

procedure draw()
for i=1 to length(attack_list) do
   if i=sel then
   draw_text({100,2+20*i-20},attack_list[i][1],1,GRAY,0)
   else
   draw_text({100,2+20*i-20},attack_list[i][1],1,7,0)
   end if
end for
end procedure

init()
draw()

while 1 do
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
 if key=328 then
   if sel>1 then
     sel-=1
   end if
   draw()
 end if
 if key=336 then
   if sel<3 then
     sel+=1
   end if
   draw()
 end if
 if key=13 then

 end if
end if
end while
