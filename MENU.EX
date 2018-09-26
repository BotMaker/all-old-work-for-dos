--tuseday 11 oct 2005 22:13:43
--version 0

without type_check
global atom key
include engine.e
screen2={}
new_screen(-1)
if graphics_mode(18) then
end if

atom button1
button1=create_ex({"button","Add Menu",10,130})
atom button2
button2=create_ex({"button","Add Menu Item",93,130})
atom button3
button3=create_ex({"button","Delete Menu",10,157})
atom button4
button4=create_ex({"button","Delete Menu Item",120,157})
atom lable1
lable1=create_ex({"lable",45,28,"Menu Editer"})
atom lable2
lable2=create_ex({"lable",12,63,"Menu"})
atom lable3
lable3=create_ex({"lable",13,90,"Menu Item"})
atom listview1
listview1=create_ex({"listview",268,34,100,100,""})
atom listview2
listview2=create_ex({"listview",379,34,100,100,""})
atom textbox1
textbox1=create_ex({"textbox",94,58,100})
atom textbox2
textbox2=create_ex({"textbox",94,86,100})
sequence menus
menus={}

procedure close2()
  clear_screen()
  ?menus
  abort(0)
end procedure

procedure add_menu()
sequence data, menu_name
atom all_ready_exstis
all_ready_exstis=0
menu_name=get_text({"textbox",textbox1})
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
menu_item_name=get_text({"textbox",textbox2})
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

while 1 do
key=get_key()
if key!=-1 then
  if key=27 then
    if show_q("Do You Want To Exit","About Windows ")=1 then
      close2()
    end if
  end if
end if
draw_screen()
if on_click({"button",button1})=1 then
  add_menu()
end if
if on_click({"button",button2})=1 then
  add_menu_item()
end if
if on_click({"button",button3})=1 then
  delete_menu()
end if
if on_click({"button",button4})=1 then
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
end while
