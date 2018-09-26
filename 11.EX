include window.e
sequence commands,goto_info,var_info
atom line_number,run_program
run_program=1
line_number=1
commands={}
goto_info={}
var_info={}

procedure goto(sequence name)
atom can
can=0
for i=1 to length(goto_info) do
   if compare(goto_info[i][1],name)=0 then
     line_number=goto_info[i][2] 
     can=1
end if
end for
if can=0 then
  show_msg("goto lable '"&name&"' dose not exists","")
end if
end procedure

procedure add_var(sequence name, atom v)
for i=1 to length(var_info) do
   if compare(var_info[i][1],name) =0 then
     show_msg("var "&name&" all ready exists","")
   end if
end for
var_info=append(var_info,{name,v})
end procedure

procedure set_var(sequence name, atom v)
atom can
can=0
for i=1 to length(var_info) do
   if compare(var_info[i][1],name) =0 then
     var_info[i][2]=v
     can=1
   end if
end for
if can=0 then
  show_msg("in set var var dose not exits "&name,"")
end if
end procedure

procedure add_window(sequence var_name, sequence window_name, atom x, atom y, atom width, atom height)
add_var(var_name,create_ex({"window",x,y,width,height,window_name}))
end procedure

procedure add_richedit(sequence var_name, atom handler, atom x, atom y, atom width, atom height)
add_var(var_name,create_ex({"richedit",x,y,width,height,handler}))
end procedure


procedure lable()
  for i=1 to length(commands) do
     if compare(commands[i][1],"lable")=0 then
       goto_info=append(goto_info,{commands[i][2],i})
     end if
  end for
end procedure

commands=append(commands,{"add_var","number",1})
commands=append(commands,{"add_window","window1","window1",1,1,300,300})
commands=append(commands,{"add_richedit","richedit1",1,1,1,200,200})
commands=append(commands,{"set_var","number",2})
commands=append(commands,{"lable","while"})
commands=append(commands,{"goto","while"})

lable()

procedure check_var()

end procedure

procedure commander()
run_program=0
  for i=line_number to length(commands) do
     if compare(commands[i][1],"add_window")=0 then
       add_window(commands[i][2],commands[i][3],commands[i][4],commands[i][5],commands[i][6],commands[i][7])
     end if
     if compare(commands[i][1],"add_richedit")=0 then
       add_richedit(commands[i][2],commands[i][3],commands[i][4],commands[i][5],commands[i][6],commands[i][7])
     end if
     if compare(commands[i][1],"add_var")=0 then
       add_var(commands[i][2],commands[i][3])
     end if
     if compare(commands[i][1],"set_var")=0 then
       set_var(commands[i][2],commands[i][3])
     end if
     if compare(commands[i][1],"goto")=0 then
       goto(commands[i][2])
       run_program=1
       exit
     end if
  end for
end procedure

while 1 do
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
end if
run()
if run_program=1 then
  commander()
end if
end while

if graphics_mode(18) then
end if
