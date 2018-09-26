without type_check
global atom key
include engine.e

screen2={}
new_screen(-1)

if graphics_mode(18) then
end if

atom button1,lable1,version
atom temp_button, temp_textbox, temp_listview, b_number
atom can, temp_combox, temp_lable, t_number, l_number,l_number1,c_number
sequence buttons, textboxs, listviews, comboxs, lables,code
atom listview1, combox1,menu1
code={}
version=0
b_number=1
t_number=1
l_number=1
l_number1=1
c_number=1
buttons={}
textboxs={}
listviews={}
comboxs={}
lables={}
can=0

procedure write_file(sequence string, sequence string1)
integer fn
fn = open(string, "w")
 if fn = -1 then
 end if
for i=1 to length(string1) do
puts(fn,string1[i]&"\n")
end for
close(fn)
end procedure

function read_file(sequence string)
sequence buffer
object line
integer fn
fn = open(string, "rb")
if fn = -1 then
end if
buffer = {}
while 1 do
line = gets(fn)
if atom(line) then
exit   
end if
buffer = append(buffer, line)
end while
return buffer
end function

sequence commands
commands={}

procedure run(sequence string)
atom pos
sequence command
pos=1
command={}
for i=1 to length(string) do
for j=1 to length(string[i]) do
if string[i][j]='Ý' then
command=append(command, string[i][pos..j-1])
pos=j+1
end if
end for
commands=append(commands,command)
command={}
pos=1
end for
end procedure

--lable1=create_ex({"lable",2,222,"gareth mc daid"})
--listview1=create_ex({"listview",10,420,80,22,{"lable","button","combox","listview","textbox"}})
combox1=create_ex({"combox",10,396,280,80,{"lable","button","combox","listview","textbox"}})
menu1=create_ex({"menu",1,1,{{"File","New","Open","Save","Make","Exit"},{"Help","About"}}})
button1=create_ex({"button","add controler",10,460})

procedure close2()
  clear_screen()
abort(0)
end procedure

procedure edit(sequence info, sequence name)
sequence x,y,width,height,text,handler
atom textbox1,textbox2,textbox3,textbox4,textbox5,textbox6
atom button_1,button_2
button_1=create_ex({"button","ok",530,220})
button_2=create_ex({"button","cancle",570,220})
textbox1=create_ex({"textbox",530,40,100})
textbox2=create_ex({"textbox",530,70,100})
textbox3=create_ex({"textbox",530,100,100})
textbox4=create_ex({"textbox",530,130,100})
textbox5=create_ex({"textbox",530,160,100})
textbox6=create_ex({"textbox",530,190,100})
x=sprint(get_x({name,info[1]}))
y=sprint(get_y({name,info[1]}))
width=sprint(get_width({name,info[1]}))
height=sprint(get_height({name,info[1]}))
text=get_text({name,info[1]})
handler=info[2]
set_text({"textbox",textbox1,text})
set_text({"textbox",textbox2,handler})
set_text({"textbox",textbox3,x})
set_text({"textbox",textbox4,y})
set_text({"textbox",textbox5,width})
set_text({"textbox",textbox6,height})

while 1 do
key=get_key()
if key != -1 then
  if key=27 then
    if show_q("Do You Want To Exit","About Windows ")=1 then
      close2()
    end if
  end if
end if
draw_screen()
if on_click({"button",button_1})=1 then
handler=get_text({"textbox",textbox2})
  if compare(name,"button")=0 then
    for i=1 to length(buttons) do
       if buttons[i][1]=info[1] then
         buttons[i][2]=handler
       end if
    end for
  end if
  if compare(name,"lable")=0 then
    for i=1 to length(lables) do
       if lables[i][1]=info[1] then
         lables[i][2]=handler
       end if
    end for
  end if
  if compare(name,"combox")=0 then
    for i=1 to length(comboxs) do
       if comboxs[i][1]=info[1] then
         comboxs[i][2]=handler
       end if
    end for
  end if
  if compare(name,"listview")=0 then
    for i=1 to length(listviews) do
       if listviews[i][1]=info[1] then
         listviews[i][2]=handler
       end if
    end for
  end if
  if compare(name,"textbox")=0 then
    for i=1 to length(textboxs) do
       if textboxs[i][1]=info[1] then
         textboxs[i][2]=handler
       end if
    end for
  end if
x=value(get_text({"textbox",textbox3}))
y=value(get_text({"textbox",textbox4}))
width=value(get_text({"textbox",textbox5}))
height=value(get_text({"textbox",textbox6}))
text=get_text({"textbox",textbox1})
set_x({name,info[1],x[2]})
set_y({name,info[1],y[2]})
set_width({name,info[1],width[2]})
set_height({name,info[1],height[2]})
set_text({name,info[1],text})
  delete({"textbox",textbox1})
  delete({"textbox",textbox2})
  delete({"textbox",textbox3})
  delete({"textbox",textbox4})
  delete({"textbox",textbox5})
  delete({"textbox",textbox6})
  delete({"button",button_1})
  delete({"button",button_2})
  exit
end if
if on_click({"button",button_2})=1 then
  delete({"textbox",textbox1})
  delete({"textbox",textbox2})
  delete({"textbox",textbox3})
  delete({"textbox",textbox4})
  delete({"textbox",textbox5})
  delete({"textbox",textbox6})
  delete({"button",button_1})
  delete({"button",button_2})
  exit
end if
end while
end procedure

procedure move()
sequence temp
temp={}
if can=1 then
  set_x({"button",temp_button,mouse_x})
  set_y({"button",temp_button,mouse_y})
  if mouse_button=mb_left then
    can=0
  end if
elsif can=2 then
  set_x({"textbox",temp_textbox,mouse_x})
  set_y({"textbox",temp_textbox,mouse_y})
  if mouse_button=mb_left then
    can=0
  end if
elsif can=3 then
  set_x({"listview",temp_listview,mouse_x})
  set_y({"listview",temp_listview,mouse_y})
  if mouse_button=mb_left then
    can=0
  end if
elsif can=4 then
  set_x({"combox",temp_combox,mouse_x})
  set_y({"combox",temp_combox,mouse_y})
  if mouse_button=mb_left then
    can=0
  end if
elsif can=5 then
  set_x({"lable",temp_lable,mouse_x})
  set_y({"lable",temp_lable,mouse_y})
  if mouse_button=mb_left then
    can=0
  end if
end if
if can=0 then
  for i=1 to length(buttons) do
     if over({"button",buttons[i][1]})=1 then
       if mouse_button=mb_right then
        temp=show_menu(get_x({"button",buttons[i][1]}),get_y({"button",buttons[i][1]})+20,{"move","delete","edit"})
          if compare(temp,"move")=0 then
            can=1
            temp_button=buttons[i][1]
          elsif compare(temp,"delete")=0 then
            delete({"button",buttons[i][1]})
            buttons=remove_line(buttons,i)
            exit
          elsif compare(temp,"edit")=0 then
            edit(buttons[i],"button")
          end if
       end if
     end if
  end for
  for i=1 to length(textboxs) do
     if over({"textbox",textboxs[i][1]})=1 then
       if mouse_button=mb_right then
        temp=show_menu(get_x({"textbox",textboxs[i][1]}),get_y({"textbox",textboxs[i][1]})+20,{"move","delete","edit"})
          if compare(temp,"move")=0 then
            can=2
            temp_textbox=textboxs[i][1]
          elsif compare(temp,"delete")=0 then
            delete({"textbox",textboxs[i][1]})
            textboxs=remove_line(textboxs,i)
            exit
          elsif compare(temp,"edit")=0 then
            edit(textboxs[i],"textbox")
          end if
       end if
     end if
  end for
  for i=1 to length(listviews) do
     if over({"listview",listviews[i][1]})=1 then
       if mouse_button=mb_right then
        temp=show_menu(get_x({"listview",listviews[i][1]}),get_y({"listview",listviews[i][1]})+get_height({"listview",listviews[i][1]}),{"move","delete","edit"})
          if compare(temp,"move")=0 then
            can=3
            temp_listview=listviews[i][1]
          elsif compare(temp,"delete")=0 then
            delete({"listview",listviews[i][1]})
            listviews=remove_line(listviews,i)
            exit
          elsif compare(temp,"edit")=0 then
            edit(listviews[i],"listview")
          end if
       end if
     end if
  end for
  for i=1 to length(comboxs) do
     if over({"combox",comboxs[i][1]})=1 then
       if mouse_button=mb_right then
        temp=show_menu(get_x({"combox",comboxs[i][1]}),get_y({"combox",comboxs[i][1]})+20,{"move","delete","edit"})
          if compare(temp,"move")=0 then
            can=4
            temp_combox=comboxs[i][1]
          elsif compare(temp,"delete")=0 then
            delete({"combox",comboxs[i][1]})
            comboxs=remove_line(comboxs,i)
            exit
          elsif compare(temp,"edit")=0 then
            edit(comboxs[i],"combox")
          end if
       end if
     end if
  end for
  for i=1 to length(lables) do
     if over({"lable",lables[i][1]})=1 then
       if mouse_button=mb_right then
        temp=show_menu(get_x({"lable",lables[i][1]}),get_y({"lable",lables[i][1]})+20,{"move","delete","edit"})
          if compare(temp,"move")=0 then
            can=5
            temp_lable=lables[i][1]
          elsif compare(temp,"delete")=0 then
            delete({"lable",lables[i][1]})
            lables=remove_line(lables,i)
            exit
          elsif compare(temp,"edit")=0 then
            edit(lables[i],"lable")
          end if
       end if
     end if
  end for
end if
end procedure

procedure new()
    for i=1 to length(buttons) do
       delete({"button",buttons[i][1]})
    end for
    for i=1 to length(lables) do
       delete({"lable",lables[i][1]})
    end for
    for i=1 to length(comboxs) do
       delete({"combox",comboxs[i][1]})
    end for
    for i=1 to length(listviews) do
       delete({"listview",listviews[i][1]})
    end for
    for i=1 to length(textboxs) do
       delete({"textbox",textboxs[i][1]})
    end for
b_number=1
t_number=1
l_number=1
l_number1=1
c_number=1
buttons={}
textboxs={}
listviews={}
comboxs={}
lables={}
commands={}
code={}
version=0
can=0
end procedure

procedure open2()
sequence x,y,width,height
sequence file_name, file_text

file_name=get_filename("PRO")
if length(file_name)>0 then
new()
file_text=read_file(file_name)
for i=1 to length(file_text) do
for j=1 to length(file_text[i]) do
if file_text[i][j]=10 then
file_text[i][j]=0
end if
if file_text[i][j]=13 then
file_text[i][j]='Ý'
end if
end for
end for   
run(file_text)
for i=1 to length(commands) do
if compare(commands[i][1],"add_button")=0 then
x=value(commands[i][4])
y=value(commands[i][5])
    temp_button=create_ex({"button",commands[i][3],x[2],y[2]})
    buttons=append(buttons,{temp_button,commands[i][2]})
    b_number+=1
end if
if compare(commands[i][1],"add_lable")=0 then
x=value(commands[i][4])
y=value(commands[i][5])
    temp_lable=create_ex({"lable",x[2],y[2],commands[i][3]})
    lables=append(lables,{temp_lable,commands[i][2]})
    l_number1+=1
end if
if compare(commands[i][1],"add_combox")=0 then
x=value(commands[i][3])
y=value(commands[i][4])
height=value(commands[i][5])
   temp_combox=create_ex({"combox",x[2],y[2],10,height[2],""})
   comboxs=append(comboxs,{temp_combox,commands[i][2]})
   c_number+=1
end if
if compare(commands[i][1],"version")=0 then
x=value(commands[i][2])
version=x[2]
end if
if compare(commands[i][1],"add_listview")=0 then
x=value(commands[i][3])
y=value(commands[i][4])
width=value(commands[i][5])
height=value(commands[i][6])
    temp_listview=create_ex({"listview",x[2],y[2],width[2],height[2],""})
    listviews=append(listviews,{temp_listview,commands[i][2]})
l_number+=1
end if
if compare(commands[i][1],"add_textbox")=0 then
x=value(commands[i][3])
y=value(commands[i][4])
width=value(commands[i][5])
    temp_textbox=create_ex({"textbox",x[2],y[2],width[2]})
    textboxs=append(textboxs,{temp_textbox,commands[i][2]})
t_number+=1
end if
end for
end if
end procedure

procedure save()
sequence file_name
file_name=get_filename("PRO")
if length(file_name)>0 then
code=append(code,"--"&date2())
code=append(code,"--version "&sprint(version+1))
code=append(code,"versionÝ"&sprint(version+1))
for i=1 to length(buttons) do
code=append(code,"add_buttonÝ"&buttons[i][2]&"Ý"&get_text({"button",buttons[i][1]})&"Ý"&sprint(get_x({"button",buttons[i][1]}))&"Ý"&
sprint(get_y({"button",buttons[i][1]})))
end for
for i=1 to length(lables) do
code=append(code,"add_lableÝ"&lables[i][2]&"Ý"&get_text({"lable",lables[i][1]})&"Ý"&sprint(get_x({"lable",lables[i][1]}))&"Ý"&
sprint(get_y({"lable",lables[i][1]})))
end for
for i=1 to length(comboxs) do
code=append(code,"add_comboxÝ"&comboxs[i][2]&"Ý"&sprint(get_x({"combox",comboxs[i][1]}))&"Ý"&
sprint(get_y({"combox",comboxs[i][1]}))&"Ý"&sprint(get_width({"combox",comboxs[i][1]})))
end for
for i=1 to length(textboxs) do
code=append(code,"add_textboxÝ"&textboxs[i][2]&"Ý"&sprint(get_x({"textbox",textboxs[i][1]}))&"Ý"&
sprint(get_y({"textbox",textboxs[i][1]}))&"Ý"&sprint(get_width({"textbox",textboxs[i][1]})))
end for
for i=1 to length(listviews) do
code=append(code,"add_listviewÝ"&listviews[i][2]&"Ý"&sprint(get_x({"listview",listviews[i][1]}))&"Ý"&
sprint(get_y({"listview",listviews[i][1]}))&"Ý"&sprint(get_width({"listview",listviews[i][1]}))&"Ý"&sprint(get_height({"listview",listviews[i][1]})))
end for
write_file(file_name,code)
end if
end procedure

procedure make()
sequence file_name
file_name=get_filename("EX")
if length(file_name)>0 then
code={}
code=append(code,"--"&date2())
code=append(code,"--version "&sprint(version))
code=append(code,"")
code=append(code,"without type_check")
code=append(code,"global atom key")
code=append(code,"include engine.e")
code=append(code,"screen2={}")
code=append(code,"new_screen(-1)")
code=append(code,"if graphics_mode(18) then")
code=append(code,"end if")
code=append(code,"")
for i=1 to length(buttons) do
code=append(code,"atom "&buttons[i][2])
code=append(code,buttons[i][2]&"=create_ex({"&{34}&"button"&{34}&","&{34}&get_text({"button",buttons[i][1]})&{34}&","&sprint(get_x({"button",buttons[i][1]}))&","&
sprint(get_y({"button",buttons[i][1]}))&"})")
end for
for i=1 to length(lables) do
code=append(code,"atom "&lables[i][2])
code=append(code,lables[i][2]&"=create_ex({"&{34}&"lable"&{34}&","&sprint(get_x({"lable",lables[i][1]}))&","&sprint(get_y({"lable",lables[i][1]}))&","&
{34}&get_text({"lable",lables[i][1]})&{34}&"})")
end for
for i=1 to length(comboxs) do
code=append(code,"atom "&comboxs[i][2])
code=append(code,comboxs[i][2]&"=create_ex({"&{34}&"combox"&{34}&","&sprint(get_x({"combox",comboxs[i][1]}))&","&sprint(get_y({"combox",comboxs[i][1]}))&","&
sprint(get_width({"combox",comboxs[i][1]}))&","&sprint(get_height({"combox",comboxs[i][1]}))&","&{34,34}&"})")
end for
for i=1 to length(listviews) do
code=append(code,"atom "&listviews[i][2])
code=append(code,listviews[i][2]&"=create_ex({"&{34}&"listview"&{34}&","&sprint(get_x({"listview",listviews[i][1]}))&","&sprint(get_y({"listview",listviews[i][1]}))&","&
sprint(get_width({"listview",listviews[i][1]}))&","&sprint(get_height({"listview",listviews[i][1]}))&","&{34,34}&"})")
end for
for i=1 to length(textboxs) do
code=append(code,"atom "&textboxs[i][2])                        
code=append(code,textboxs[i][2]&"=create_ex({"&{34}&"textbox"&{34}&","&sprint(get_x({"textbox",textboxs[i][1]}))&","&sprint(get_y({"textbox",textboxs[i][1]}))&","&
sprint(get_width({"textbox",textboxs[i][1]}))&"})")
end for
code=append(code,"")
code=append(code,"procedure close2()")
code=append(code,"  clear_screen()")
code=append(code,"  abort(0)")
code=append(code,"end procedure")
code=append(code,"")
code=append(code,"while 1 do")
code=append(code,"key=get_key()")
code=append(code,"if key!=-1 then")
code=append(code,"  if key=27 then")
code=append(code,"    if show_q("&{34}&"Do You Want To Exit"&{34}&","&{34}&"About Windows "&{34}&")=1 then")
code=append(code,"      close2()")
code=append(code,"    end if")
code=append(code,"  end if")
code=append(code,"end if")
code=append(code,"draw_screen()")
code=append(code,"")
for i=1 to length(buttons) do
code=append(code,"if on_click({"&{34}&"button"&{34}&","&buttons[i][2]&"})=1 then")
code=append(code,"")
code=append(code,"end if")
end for
code=append(code,"")
code=append(code,"end while")
write_file(file_name,code)
end if
end procedure

while 1 do
key=get_key()
if key != -1 then
  if key=27 then
    if show_q("Do You Want To Exit","About Windows ")=1 then
      close2()
    end if
  end if
end if
rectangle(mouse_x,mouse_y,mouse_x+3,mouse_y+3,0,1)
draw_screen()
move()
if on_click({"button",button1})=1 and can=0 then
  if compare(get_text({"combox",combox1}),"button")=0 then
    temp_button=create_ex({"button","button"&sprint(b_number),1,1})
    buttons=append(buttons,{temp_button,"button"&sprint(b_number)})
    can=1
    b_number+=1
    elsif compare(get_text({"combox",combox1}),"textbox")=0 then
    temp_textbox=create_ex({"textbox",1,1,100})
    textboxs=append(textboxs,{temp_textbox,"textbox"&sprint(t_number)})
    can=2
    t_number+=1
    elsif compare(get_text({"combox",combox1}),"listview")=0 then
    temp_listview=create_ex({"listview",1,1,100,100,""})
    listviews=append(listviews,{temp_listview,"listview"&sprint(l_number)})
    can=3
    l_number+=1
    elsif compare(get_text({"combox",combox1}),"combox")=0 then
    temp_combox=create_ex({"combox",1,1,100,100,""})
    comboxs=append(comboxs,{temp_combox,"combox"&sprint(c_number)})
    can=4
    c_number+=1
    elsif compare(get_text({"combox",combox1}),"lable")=0 then
    temp_lable=create_ex({"lable",1,1,"lable"&sprint(l_number1)})
    lables=append(lables,{temp_lable,"lable"&sprint(l_number1)})
    can=5
    l_number1+=1
    end if
end if
if on_click({"menu",menu1,"New"})=1 then
new()
end if
if on_click({"menu",menu1,"Open"})=1 then
open2()
end if
if on_click({"menu",menu1,"Save"})=1 then
save()
end if
if on_click({"menu",menu1,"Make"})=1 then
make()
end if
 if on_click({"menu",menu1,"Exit"})=1 then
  if show_q("Do You Want To Exit","About Windows ")=1 then
    close2()
  end if
end if
if on_click({"menu",menu1,"About"})=1 then
  show_msg("Games","About Windows")
end if
end while
