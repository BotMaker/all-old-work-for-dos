--tuseday 11 oct 2005 19:42:45
--version 1

without type_check
global atom key
include engine.e
screen2={}
new_screen(-1)
if graphics_mode(18) then
end if
sequence d,line,line2
atom test
test=0
d={}
line={}
line2={}

  d=dir(current_dir())
  for i=1 to length(d) do
  test= compare(d[i][2],"d") 
  if test!=0 then
  line=append(line,d[i][1])
  line2=append(line2,d[i])
  end if
  end for
line=gaz_sort(line)

atom lable1
lable1=create_ex({"lable",34,29,"File Information"})
atom lable2
lable2=create_ex({"lable",5,54,"File Name"})
atom lable3
lable3=create_ex({"lable",7,104,"File Size"})
atom lable4
lable4=create_ex({"lable",6,79,"File Attributes"})
atom lable5
lable5=create_ex({"lable",30,132,"File Last Modification"})
atom lable6
lable6=create_ex({"lable",7,159,"Date"})
atom lable7
lable7=create_ex({"lable",7,183,"Time"})
atom listview1
listview1=create_ex({"listview",249,28,120,180,line})
atom textbox1
textbox1=create_ex({"textbox",134,51,100})
atom textbox2
textbox2=create_ex({"textbox",134,76,100})
atom textbox3
textbox3=create_ex({"textbox",134,102,100})
atom textbox4
textbox4=create_ex({"textbox",45,156,100})
atom textbox5
textbox5=create_ex({"textbox",46,180,100})

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
if on_click({"listview",listview1})=1 then
-- new
set_text({"textbox",textbox1,""})
set_text({"textbox",textbox2,""})
set_text({"textbox",textbox3,""})
set_text({"textbox",textbox4,""})
set_text({"textbox",textbox5,""})
--
for i=1 to length(line2) do
   if compare(line2[i][1],get_text({"listview",listview1}))=0 then
     set_text({"textbox",textbox1,line2[i][1]})
     set_text({"textbox",textbox2,line2[i][2]})
     set_text({"textbox",textbox3,sprint(line2[i][3])})
     set_text({"textbox",textbox4,sprint(line2[i][4])&" "&sprint(line2[i][5])&" "&sprint(line2[i][6])})
     set_text({"textbox",textbox5,sprint(line2[i][7])&" "&sprint(line2[i][8])&" "&sprint(line2[i][9])})
     exit
   end if
end for
end if
end while
