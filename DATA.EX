--monday 10 oct 2005 22:31:58
--version 1

without type_check
global atom key
include engine.e
include database.e
screen2={}
new_screen(-1)
if graphics_mode(18) then
end if

if db_open("data", DB_LOCK_NO) != DB_OK then
  if db_create("data", DB_LOCK_NO) != DB_OK then
    puts(1,"err")
  end if
  if db_create_table("data") != DB_OK then
    puts(1,"err")
  end if
end if
if db_select_table("data") != DB_OK then
  puts(1,"err")
end if
sequence all_data,all_key,data,temp,info
atom temp2
temp2=0
info="Abort Database"
all_key={}
all_data={}
data={}
temp={}

for rec = 1 to db_table_size() do
   data=db_record_data(rec)
   all_data=append(all_data,{db_record_key(rec),data[1],data[2],data[3]})
   all_key=append(all_key,db_record_key(rec))
end for

procedure add_info(sequence key, sequence data)
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

function get_data(sequence key)
atom rec
sequence data
rec=db_find_key(key)
if rec >= 1 then
data=db_record_data(rec)
return {db_record_key(rec),data[1],data[2],data[3]}
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

atom button1
button1=create_ex({"button","Add Data",6,182})
atom button2
button2=create_ex({"button","Delete Data",91,182})
atom button3
button3=create_ex({"button","Show Data",203,181})
atom button4
button4=create_ex({"button","Scan",306,155})
atom button5
button5=create_ex({"button","New",300,181})
atom lable1
lable1=create_ex({"lable",42,26,"Database Program"})
atom lable2
lable2=create_ex({"lable",6,57,"Full Name"})
atom lable4
lable4=create_ex({"lable",6,83,"Date Of Brith"})
atom lable5
lable5=create_ex({"lable",6,110,"Addres"})
atom lable6
lable6=create_ex({"lable",7,139,"Telephone"})
atom listview1
listview1=create_ex({"listview",304,48,200,100,all_key})
atom textbox1
textbox1=create_ex({"textbox",120,54,180})
atom textbox2
textbox2=create_ex({"textbox",120,80,100})
atom textbox3
textbox3=create_ex({"textbox",120,107,180})
atom textbox4
textbox4=create_ex({"textbox",120,136,100})
atom textbox5
textbox5=create_ex({"textbox",362,154,140})

procedure close2()
  clear_screen()
  abort(0)
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
  if length(get_text({"textbox",textbox1}))>0 then
    if show_q("Do You Want To Add Data "&get_text({"textbox",textbox1}),info)=1 then
      if db_find_key(get_text({"textbox",textbox1})) >=1 then
      show_msg("Data Replace",info)
      else
      add_item({"listview",listview1,get_text({"textbox",textbox1})})
      show_msg("Add Data Ok",info)
      end if
      add_info(get_text({"textbox",textbox1}),{get_text({"textbox",textbox2}),get_text({"textbox",textbox3}),get_text({"textbox",textbox4})})
    end if
  else
    show_msg("Enter A Surname",info)
  end if
end if
if on_click({"button",button2})=1 then
  if show_q("Do You Want To Delete Data "&get_text({"listview",listview1}),info)=1 then
    delete_key(get_text({"listview",listview1}))
    delete_item({"listview",listview1,get_text({"listview",listview1})})
    show_msg("Delete Data Ok",info)
  end if
end if
if on_click({"button",button3})=1 then
  temp=get_data(get_text({"listview",listview1}))
  set_text({"textbox",textbox1,temp[1]})
  set_text({"textbox",textbox2,temp[2]})
  set_text({"textbox",textbox3,temp[3]})
  set_text({"textbox",textbox4,temp[4]})
end if
if on_click({"button",button4})=1 then
temp2=0
  if length(get_text({"textbox",textbox5}))>0 then
    temp=""
    temp=get_all_item({"listview",listview1})
    for i=1 to length(temp) do
       if compare(temp[i],get_text({"textbox",textbox5}))=0 then
         set_sel_item({"listview",listview1,i})
         temp=get_data(get_text({"listview",listview1}))
         set_text({"textbox",textbox1,temp[1]})
         set_text({"textbox",textbox2,temp[2]})
         set_text({"textbox",textbox3,temp[3]})
         set_text({"textbox",textbox4,temp[4]})
         show_msg("Surname Found",info)
         temp2=1
         exit
       end if
    end for
  else
    show_msg("Enter A Surname",info)
  end if
  if temp2=0 then
    show_msg("Surname Not Found ",info)
  end if
end if
if on_click({"button",button5})=1 then
  set_text({"textbox",textbox1,""})
  set_text({"textbox",textbox2,""})
  set_text({"textbox",textbox3,""})
  set_text({"textbox",textbox4,""})
end if
end while
