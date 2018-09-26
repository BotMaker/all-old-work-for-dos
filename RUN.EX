include window.e
include database.e

atom window1,textbox1,textbox2,textbox3,textbox4,textbox5,textbox6,textbox7
atom lable1,lable2,lable3,lable4,lable5,lable6,lable7,button1,button7,button8
window1=create_ex({"window",10,10,190,260,"Settings"})
textbox1=create_ex({"textbox",80,10,100,window1})
textbox2=create_ex({"textbox",80,35,100,window1})
textbox3=create_ex({"textbox",80,60,100,window1})
textbox4=create_ex({"textbox",80,85,100,window1})
textbox5=create_ex({"textbox",80,110,100,window1})
textbox6=create_ex({"textbox",80,135,100,window1})
textbox7=create_ex({"textbox",80,160,100,window1})
lable1=create_ex({"lable",10,10,"window",window1})
lable2=create_ex({"lable",10,35,"handler",window1})
lable3=create_ex({"lable",10,60,"text",window1})
lable4=create_ex({"lable",10,85,"x",window1})
lable5=create_ex({"lable",10,110,"y",window1})
lable6=create_ex({"lable",10,135,"width",window1})
lable7=create_ex({"lable",10,160,"height",window1})
button1=create_ex({"button",10,190,"Ok",window1})
button7=create_ex({"button",50,190,"Delete",window1})
button8=create_ex({"button",120,190,"Move",window1})
--
atom window2,box1
window2=create_ex({"window",215,10,400,360,"Main window"})
--
atom window3,combox1,button2
window3=create_ex({"window",620,10,170,160,"Win32 window"})
combox1=create_ex({"combox",10,10,100,{"Button","Listview","Combox","Richedit","Textbox","Lable","Box"},window3})
button2=create_ex({"button",30,120,"Add Win32",window3})
--
atom window4,richedit1,combox2
window4=create_ex({"window",215,380,550,200,"Code window"})
richedit1=create_ex({"richedit",10,10,300,140,window4})
combox2=create_ex({"combox",320,10,100,{""},window4})
--
atom window5,listview1,listview2,textbox8,textbox9,button3,button4,button5,button6
atom lable8,lable9,lable10
window5=create_ex({"window",5,280,205,300,"menu editer"})
listview1=create_ex({"listview",10,170,80,100,"",window5})
listview2=create_ex({"listview",100,170,80,100,"",window5})
textbox8=create_ex({"textbox",100,30,100,window5})
textbox9=create_ex({"textbox",100,60,100,window5})
button3=create_ex({"button",10,90,"Add Menu",window5})
button4=create_ex({"button",100,90,"Delete Menu",window5})
button5=create_ex({"button",10,120,"Add Menu Item",window5})
button6=create_ex({"button",10,150,"Delete Menu Item",window5})
lable8=create_ex({"lable",10,30,"Menu",window5})
lable9=create_ex({"lable",10,60,"Menu Item",window5})
lable10=create_ex({"lable",10,10,"Menu On/Off",window5})
box1=create_ex({"box",100,10,window5})
atom window6,button_new,button_open,button_save,button_exit
window6=create_ex({"window",620,180,180,190,"Commands"})
button_new=create_ex({"button",5,5,"NEW",window6})
button_open=create_ex({"button",5,30,"OPEN",window6})
button_save=create_ex({"button",5,55,"SAVE",window6})
button_exit=create_ex({"button",5,80,"EXIT",window6})

------------------------------------------------------------
--box1=create_ex({"box",100,10,window5})
--menu1=create_ex({"menu",1,1,menus,window2})
--button1=create_ex({"button",10,10,"button1",window1})
--combox1=create_ex({"combox",10,10,100,{"item1"},window3})
--richedit1=create_ex({"richedit",10,50,200,200,window3})
--textbox1=create_ex({"textbox",10,10,100,window3})
--lable1=create_ex({"lable",10,10,"gareth",window1})
------------------------------------------------------------
atom menu1
menu1=0
sequence menus
menus={}
atom can,button_number,textbox_number,richedit_number,listview_number
atom combox_number,lable_number,box_number
sequence buttons,textboxs,info,temp_object,richedits,listviews,comboxs,lables
sequence boxs
atom button,textbox,richedit,listview,combox,lable,box
temp_object={}
buttons={}
info={}
textboxs={}
textbox_number=1
button_number=1
button=0
textbox=0
richedit_number=1
richedits={}
richedit=0
listview=0
listview_number=1
listviews={}
can=0
combox=0
combox_number=1
comboxs={}
lable=0
lable_number=1
lables={}
box=0
box_number=1
boxs={}

procedure new_program(atom id)
if id=1 then
if show_q("do you want to start a new","")=1 then
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
    for i=1 to length(richedits) do
       delete({"richedit",richedits[i][1]})
    end for
    for i=1 to length(boxs) do
       delete({"box",boxs[i][1]})
    end for
set_text({"textbox",textbox1,""})
set_text({"textbox",textbox2,""})
set_text({"textbox",textbox3,""})
set_text({"textbox",textbox4,""})
set_text({"textbox",textbox5,""})
set_text({"textbox",textbox6,""})
set_text({"textbox",textbox7,""})
set_text({"textbox",textbox8,""})
set_text({"textbox",textbox9,""})
delete_all_item({"listview",listview1})
delete_all_item({"listview",listview2})
delete_all_item({"combox",combox2})
delete({"menu",menu1})
temp_object={}
buttons={}
info={}
textboxs={}
textbox_number=1
button_number=1
button=0
textbox=0
richedit_number=1
richedits={}
richedit=0
listview=0
listview_number=1
listviews={}
can=0
combox=0
combox_number=1
comboxs={}
lable=0
lable_number=1
lables={}
box=0
box_number=1
boxs={}
menus={}
end if
else
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
    for i=1 to length(richedits) do
       delete({"richedit",richedits[i][1]})
    end for
    for i=1 to length(boxs) do
       delete({"box",boxs[i][1]})
    end for
set_text({"textbox",textbox1,""})
set_text({"textbox",textbox2,""})
set_text({"textbox",textbox3,""})
set_text({"textbox",textbox4,""})
set_text({"textbox",textbox5,""})
set_text({"textbox",textbox6,""})
set_text({"textbox",textbox7,""})
set_text({"textbox",textbox8,""})
set_text({"textbox",textbox9,""})
delete_all_item({"listview",listview1})
delete_all_item({"listview",listview2})
delete_all_item({"combox",combox2})
delete({"menu",menu1})
temp_object={}
buttons={}
info={}
textboxs={}
textbox_number=1
button_number=1
button=0
textbox=0
richedit_number=1
richedits={}
richedit=0
listview=0
listview_number=1
listviews={}
can=0
combox=0
combox_number=1
comboxs={}
lable=0
lable_number=1
lables={}
box=0
box_number=1
boxs={}
menus={}
end if
end procedure

procedure add_info(sequence key, sequence data)
atom f
f = db_find_key(key)
if f >= 1 then
db_replace_data(f, data)
else
if db_insert(key, data) != DB_OK then
  show_msg("err add info","err")
end if
end if
end procedure

function get_data(sequence key)
atom rec
sequence data
rec=db_find_key(key)
if rec >= 1 then
data=db_record_data(rec)
return data
else
return ""
end if
end function

procedure delete_key(sequence key)
atom d
d=db_find_key(key)
if d >= 1 then
db_delete_record(d)
end if
end procedure

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

procedure open_program()
sequence file_name,data
atom fn
file_name=get_filename("EDB")
if length(file_name)>0 then
  new_program(0)
  if db_open(file_name, DB_LOCK_NO) != DB_OK then
    if db_create(file_name, DB_LOCK_NO) != DB_OK then
      show_msg("err db create","err")
    end if
    if db_create_table("data") != DB_OK then
      show_msg("err db create table","err")
    end if
  end if
  if db_select_table("data") != DB_OK then
    show_msg("err db selete table","err")
  end if
--button
  data=get_data("button")
  for i=1 to length(data) do
     button=create_ex({"button",data[i][2],data[i][3],data[i][4],window2})
     buttons=append(buttons,{button,data[i][1],{""}})
     button_number+=1
  end for
--textbox
  data=get_data("textbox")
  for i=1 to length(data) do
      textbox=create_ex({"textbox",data[i][2],data[i][3],data[i][4],window2})
      set_text({"textbox",textbox,data[i][1]})
      textboxs=append(textboxs,{textbox,data[i][1]})
      textbox_number+=1
  end for
end if
end procedure

procedure save_program()
sequence file_name, buttons_data,textboxs_data,comboxs_data,listviews_data
sequence richedits_data,lables_data,boxs_data
file_name=""
buttons_data={}
textboxs_data={}
comboxs_data={}
listviews_data={}
richedits_data={}
lables_data={}
boxs_data={}
file_name=get_filename("EDB")
if length(file_name)>0 then
  if db_open(file_name, DB_LOCK_NO) != DB_OK then
    if db_create(file_name, DB_LOCK_NO) != DB_OK then
      show_msg("err db create","err")
    end if
    if db_create_table("data") != DB_OK then
      show_msg("err db create table","err")
    end if
  end if
  if db_select_table("data") != DB_OK then
    show_msg("err db selete table","err")
  end if
--button
  for i=1 to length(buttons) do
     buttons_data=append(buttons_data,{buttons[i][2],get_x({"button",buttons[i][1],0}),get_y({"button",buttons[i][1],0}),get_text({"button",buttons[i][1]})})
  end for
  add_info("button",buttons_data)
--textbox
  for i=1 to length(textboxs) do
     textboxs_data=append(textboxs_data,{textboxs[i][2],get_x({"textbox",textboxs[i][1],0}),get_y({"textbox",textboxs[i][1],0}),get_width({"textbox",textboxs[i][1]})})
  end for
  add_info("textbox",textboxs_data)
end if
end procedure

procedure menu_commands()
if on_click({"button",button_new})=1 then
  new_program(1)
end if
if on_click({"button",button_save})=1 then
  save_program()
end if
if on_click({"button",button_open})=1 then
  open_program()
end if
if on_click({"button",button_exit})=1 then
  new_program(1)
end if
end procedure

procedure add_menu()
sequence data, menu_name
atom all_ready_exstis
all_ready_exstis=0
menu_name=get_text({"textbox",textbox8})
if length(menu_name)>0 then
  data=get_all_item({"listview",listview1})
  for i=1 to length(data) do
     if compare(data[i],menu_name)=0 then
       all_ready_exstis=1
     end if
  end for
  if all_ready_exstis=0 then
    add_item({"listview",listview1,menu_name})
    menus=append(menus,{menu_name})
  else
    show_msg("Menu "&menu_name&" All Ready Exstis","")
  end if
else
  show_msg("Enter A Menu Name","")
end if
end procedure

procedure add_menu_item()
sequence data, menu_name, menu_item_name
atom all_ready_exstis
all_ready_exstis=0
menu_name=get_text({"listview",listview1})
menu_item_name=get_text({"textbox",textbox9})
if length(menu_name)>0 then
  if length(menu_item_name)>0 then
    data=get_all_item({"listview",listview2})
    for i=1 to length(data) do
       if compare(data[i],menu_item_name)=0 then
         all_ready_exstis=1
       end if
    end for
    if all_ready_exstis=0 then
      add_item({"listview",listview2,menu_item_name})
        for i=1 to length(menus) do
           if compare(menus[i][1],menu_name)=0 then
             menus[i]=append(menus[i],menu_item_name)
             exit
           end if
        end for
    else
    show_msg("Menu Item "&menu_item_name&" All Ready Exstis","")
    end if
  else
    show_msg("Enter A Menu Item Name","")
  end if
else
  show_msg("Selete A Menu Name","")
end if
end procedure

procedure delete_menu()
sequence menu_name
menu_name=get_text({"listview",listview1})
if length(menu_name)>0 then
  for i=1 to length(menus) do
     if compare(menus[i][1],menu_name)=0 then
       delete_item({"listview",listview1,menu_name})
       menus=remove_line(menus,i)
       exit
     end if
  end for
else
  show_msg("Selete A Menu Name","")
end if
end procedure

procedure delete_menu_item()
sequence menu_name, menu_item_name
menu_name=get_text({"listview",listview1})
menu_item_name=get_text({"listview",listview2})
if length(menu_name)>0 then
  if length(menu_item_name)>0 then
    for i=1 to length(menus) do
       if compare(menus[i][1],menu_name)=0 then
         delete_item({"listview",listview2,menu_item_name})
         for j=1 to length(menus[i]) do
           if compare(menus[i][j],menu_item_name)=0 then
              menus[i]=remove_line(menus[i],j)
              exit
           end if
         end for
         add_all_item({"listview",listview2,menus[i][2..length(menus[i])]})
         exit
       end if
    end for
  else
    show_msg("Selete A Menu Item Name","")
  end if
else
  show_msg("Selete A Menu Name","")
end if
end procedure

procedure menu_editer()
if on_click({"button",button3})=1 then
  add_menu()
end if
if on_click({"button",button5})=1 then
  add_menu_item()
end if
if on_click({"button",button4})=1 then
  delete_menu()
end if
if on_click({"button",button6})=1 then
  delete_menu_item()
end if
if on_click({"listview",listview1})=1 then
  delete_all_item({"listview",listview2})
  for i=1 to length(menus) do
     if compare(get_text({"listview",listview1}),menus[i][1])=0 then
       add_all_item({"listview",listview2,menus[i][2..length(menus[i])]})
       exit
     end if
  end for
end if
end procedure

procedure move()
if can=1 then
  set_x({"button",button,mouse_x,1})
  set_y({"button",button,mouse_y,1})
    if mouse_button=mb_left then
      can=0
    end if
elsif can=2 then
set_x({"textbox",textbox,mouse_x,1})
set_y({"textbox",textbox,mouse_y,1})
    if mouse_button=mb_left then
      can=0
    end if
elsif can=3 then
set_x({"richedit",richedit,mouse_x,1})
set_y({"richedit",richedit,mouse_y,1})
    if mouse_button=mb_left then
      can=0
    end if
elsif can=4 then
set_x({"listview",listview,mouse_x,1})
set_y({"listview",listview,mouse_y,1})
    if mouse_button=mb_left then
      can=0
    end if
elsif can=5 then
set_x({"combox",combox,mouse_x,1})
set_y({"combox",combox,mouse_y,1})
    if mouse_button=mb_left then
      can=0
    end if
elsif can=6 then
set_x({"lable",lable,mouse_x,1})
set_y({"lable",lable,mouse_y,1})
    if mouse_button=mb_left then
      can=0
    end if
elsif can=7 then
set_x({"box",box,mouse_x,1})
set_y({"box",box,mouse_y,1})
    if mouse_button=mb_left then
      can=0
    end if
end if
if can=0 then
  for i=1 to length(buttons) do
     if over({"button",buttons[i][1]})=1 and mouse_button=mb_right then
       info={"button",buttons[i][1]}
       set_text({"textbox",textbox2,buttons[i][2]})
       set_text({"textbox",textbox3,get_text({"button",buttons[i][1]})})
       set_text({"textbox",textbox4,sprint(get_x({"button",buttons[i][1],0}))})
       set_text({"textbox",textbox5,sprint(get_y({"button",buttons[i][1],0}))})
       set_text({"textbox",textbox6,""})
       set_text({"textbox",textbox7,""})
       sel_window=window1
       mouse_button=0
     end if
  end for
  for i=1 to length(textboxs) do
     if over({"textbox",textboxs[i][1]})=1 and mouse_button=mb_right then
       info={"textbox",textboxs[i][1]}
       set_text({"textbox",textbox2,textboxs[i][2]})
       set_text({"textbox",textbox3,get_text({"textbox",textboxs[i][1]})})
       set_text({"textbox",textbox4,sprint(get_x({"textbox",textboxs[i][1],0}))})
       set_text({"textbox",textbox5,sprint(get_y({"textbox",textboxs[i][1],0}))})
       set_text({"textbox",textbox6,sprint(get_width({"textbox",textboxs[i][1],0}))})
       set_text({"textbox",textbox7,""})
       sel_window=window1
       mouse_button=0
     end if
  end for
  for i=1 to length(richedits) do
     if over({"richedit",richedits[i][1]})=1 and mouse_button=mb_right then
       info={"richedit",richedits[i][1]}
       set_text({"textbox",textbox2,richedits[i][2]})
       set_text({"textbox",textbox3,""})
       set_text({"textbox",textbox4,sprint(get_x({"richedit",richedits[i][1],0}))})
       set_text({"textbox",textbox5,sprint(get_y({"richedit",richedits[i][1],0}))})
       set_text({"textbox",textbox6,sprint(get_width({"richedit",richedits[i][1]}))})
       set_text({"textbox",textbox7,sprint(get_height({"richedit",richedits[i][1]}))})
       sel_window=window1
       mouse_button=0
     end if
  end for
  for i=1 to length(comboxs) do
     if over({"combox",comboxs[i][1]})=1 and mouse_button=mb_right then
       info={"combox",comboxs[i][1]}
       set_text({"textbox",textbox2,comboxs[i][2]})
       set_text({"textbox",textbox3,""})
       set_text({"textbox",textbox4,sprint(get_x({"combox",comboxs[i][1],0}))})
       set_text({"textbox",textbox5,sprint(get_y({"combox",comboxs[i][1],0}))})
       set_text({"textbox",textbox6,""})
       set_text({"textbox",textbox7,""})
       sel_window=window1
       mouse_button=0
     end if
  end for
  for i=1 to length(listviews) do
     if over({"listview",listviews[i][1]})=1 and mouse_button=mb_right then
       info={"listview",listviews[i][1]}
       set_text({"textbox",textbox2,listviews[i][2]})
       set_text({"textbox",textbox3,""})
       set_text({"textbox",textbox4,sprint(get_x({"listview",listviews[i][1],0}))})
       set_text({"textbox",textbox5,sprint(get_y({"listview",listviews[i][1],0}))})
       set_text({"textbox",textbox6,sprint(get_width({"listview",listviews[i][1]}))})
       set_text({"textbox",textbox7,sprint(get_height({"listview",listviews[i][1]}))})
       sel_window=window1
       mouse_button=0
     end if
  end for
  for i=1 to length(lables) do
     if over({"lable",lables[i][1]})=1 and mouse_button=mb_right then
       info={"lable",lables[i][1]}
       set_text({"textbox",textbox2,lables[i][2]})
       set_text({"textbox",textbox3,get_text({"lable",lables[i][1]})})
       set_text({"textbox",textbox4,sprint(get_x({"lable",lables[i][1],0}))})
       set_text({"textbox",textbox5,sprint(get_y({"lable",lables[i][1],0}))})
       set_text({"textbox",textbox6,""})
       set_text({"textbox",textbox7,""})
       sel_window=window1
       mouse_button=0
     end if
  end for
  for i=1 to length(boxs) do
     if over({"box",boxs[i][1]})=1 and mouse_button=mb_right then
       info={"box",boxs[i][1]}
       set_text({"textbox",textbox2,boxs[i][2]})
       set_text({"textbox",textbox3,""})
       set_text({"textbox",textbox4,sprint(get_x({"box",boxs[i][1],0}))})
       set_text({"textbox",textbox5,sprint(get_y({"box",boxs[i][1],0}))})
       set_text({"textbox",textbox6,""})
       set_text({"textbox",textbox7,""})
       sel_window=window1
       mouse_button=0
     end if
  end for
end if
end procedure

procedure gaz()
sequence x,y,width,height,window,handler
  if on_click({"button",button2})=1 then
    if compare(get_text({"combox",combox1}),"Button")=0 then
      button=create_ex({"button",mouse_x,mouse_y,"button"&sprint(button_number),window2})
      buttons=append(buttons,{button,"button"&sprint(button_number),{""}})
      mouse_button=0
      button_number+=1
      sel_window=window2
      can=1
    end if
    if compare(get_text({"combox",combox1}),"Textbox")=0 then
      textbox=create_ex({"textbox",mouse_x,mouse_y,100,window2})
      set_text({"textbox",textbox,"textbox"&sprint(textbox_number)})
      textboxs=append(textboxs,{textbox,"textbox"&sprint(textbox_number)})
      mouse_button=0
      textbox_number+=1
      sel_window=window2
      can=2
    end if
    if compare(get_text({"combox",combox1}),"Richedit")=0 then
      richedit=create_ex({"richedit",mouse_x,mouse_y,100,100,window2})
      set_text({"richedit",richedit,{"richedit"&sprint(richedit_number)}})
      richedits=append(richedits,{richedit,"richedit"&sprint(richedit_number)})
      mouse_button=0
      richedit_number+=1
      sel_window=window2
      can=3
    end if
    if compare(get_text({"combox",combox1}),"Listview")=0 then
      listview=create_ex({"listview",mouse_x,mouse_y,100,100,{"listview"&sprint(listview_number)},window2})
      listviews=append(listviews,{listview,"listview"&sprint(listview_number),{""}})
      mouse_button=0
      listview_number+=1
      sel_window=window2
      can=4
    end if
    if compare(get_text({"combox",combox1}),"Combox")=0 then
      combox=create_ex({"combox",mouse_x,mouse_y,100,{"combox"&sprint(combox_number)},window2})
      comboxs=append(comboxs,{combox,"combox"&sprint(combox_number),{""}})
      mouse_button=0
      combox_number+=1
      sel_window=window2
      can=5
    end if
    if compare(get_text({"combox",combox1}),"Lable")=0 then
      lable=create_ex({"lable",mouse_x,mouse_y,"lable"&sprint(lable_number),window2})
      lables=append(lables,{lable,"lable"&sprint(lable_number)})
      mouse_button=0
      lable_number+=1
      sel_window=window2
      can=6
    end if
    if compare(get_text({"combox",combox1}),"Box")=0 then
      box=create_ex({"box",mouse_x,mouse_y,window2})
      boxs=append(boxs,{box,"box"&sprint(box_number),{""}})
      mouse_button=0
      box_number+=1
      sel_window=window2
      can=7
    end if
  end if
  if on_click({"button",button1})=1 then
    x=value(get_text({"textbox",textbox4}))
    y=value(get_text({"textbox",textbox5}))
    width=value(get_text({"textbox",textbox6}))
    height=value(get_text({"textbox",textbox7}))
    window=get_text({"textbox",textbox1})
    handler=get_text({"textbox",textbox2})
  if length(info)>0 then
  if compare(info[1],"button")=0 then
    set_text({"button",info[2],get_text({"textbox",textbox3})})
    set_x({"button",info[2],x[2],0})
    set_y({"button",info[2],y[2],0})
    for i=1 to length(buttons) do
       if buttons[i][1]=info[2] then
         buttons[i][2]=handler
         exit
       end if
    end for
  end if
  if compare(info[1],"textbox")=0 then
    set_text({"textbox",info[2],get_text({"textbox",textbox3})})
    set_x({"textbox",info[2],x[2],0})
    set_y({"textbox",info[2],y[2],0})
    set_width({"textbox",info[2],width[2],0})
    for i=1 to length(textboxs) do
       if textboxs[i][1]=info[2] then
         textboxs[i][2]=handler
         exit
       end if
    end for
   end if
  if compare(info[1],"listview")=0 then
    set_x({"listview",info[2],x[2],0})
    set_y({"listview",info[2],y[2],0})
    set_width({"listview",info[2],width[2],0})
    set_height({"listview",info[2],height[2],0})
    for i=1 to length(listviews) do
       if listviews[i][1]=info[2] then
         listviews[i][2]=handler
         exit
       end if
    end for
  end if
  if compare(info[1],"richedit")=0 then
    set_x({"richedit",info[2],x[2],0})
    set_y({"richedit",info[2],y[2],0})
    set_width({"richedit",info[2],width[2],0})
    set_height({"richedit",info[2],height[2],0})
    for i=1 to length(richedits) do
       if richedits[i][1]=info[2] then
         richedits[i][2]=handler
         exit
       end if
    end for
  end if
  if compare(info[1],"combox")=0 then
    set_x({"combox",info[2],x[2],0})
    set_y({"combox",info[2],y[2],0})
    set_height({"combox",info[2],height[2],0})
    for i=1 to length(comboxs) do
       if comboxs[i][1]=info[2] then
         comboxs[i][2]=handler
         exit
       end if
    end for
  end if
  if compare(info[1],"lable")=0 then
    set_text({"lable",info[2],get_text({"textbox",textbox3})})
    set_x({"lable",info[2],x[2],0})
    set_y({"lable",info[2],y[2],0})
    for i=1 to length(lables) do
       if lables[i][1]=info[2] then
         lables[i][2]=handler
         exit
       end if
    end for
  end if
  if compare(info[1],"box")=0 then
    set_x({"box",info[2],x[2],0})
    set_y({"box",info[2],y[2],0})
    for i=1 to length(boxs) do
       if boxs[i][1]=info[2] then
         boxs[i][2]=handler
         exit
       end if
    end for
  end if
end if
end if
--delete
  if on_click({"button",button7})=1 then
    if length(info)>0 then
    delete({info[1],info[2]})
    draw_a_window=window2
    set_text({"textbox",textbox2,""})
    set_text({"textbox",textbox3,""})
    set_text({"textbox",textbox4,""})
    set_text({"textbox",textbox5,""})
    set_text({"textbox",textbox6,""})
    set_text({"textbox",textbox7,""})
    info={}
    end if
  end if
  if on_click({"button",button8})=1 then
    if length(info)>0 then
    set_text({"textbox",textbox2,""})
    set_text({"textbox",textbox3,""})
    set_text({"textbox",textbox4,""})
    set_text({"textbox",textbox5,""})
    set_text({"textbox",textbox6,""})
    set_text({"textbox",textbox7,""})
    if compare(info[1],"button")=0 then
    button=info[2]
    can=1
    end if
    if compare(info[1],"textbox")=0 then
    textbox=info[2]
    can=2
    end if
    if compare(info[1],"listview")=0 then
    listview=info[2]
    can=4
    end if
    if compare(info[1],"richedit")=0 then
    richedit=info[2]
    can=3
    end if
    if compare(info[1],"combox")=0 then
    combox=info[2]
    can=5
    end if
    if compare(info[1],"lable")=0 then
    lable=info[2]
    can=6
    end if
    if compare(info[1],"box")=0 then
    box=info[2]
    can=7
    end if
    info={}
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
run()
gaz()
move()
menu_editer()
menu_commands()
if on_click({"box",box1})=1 then
  if get_sel({"box",box1})=1 then
    menu1=create_ex({"menu",1,1,menus,window2})
  else
    delete({"menu",menu1})
  end if
end if
end while

if graphics_mode(18) then
end if
