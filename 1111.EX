-- need to do err checking on nested for loops about the varbs being the same
-- need to do err checking on the exit satement to make sure in ther right
-- need to do err checking on the return statement to make sure in ther right
-- add procedure and function code need work doing to improve argumenus
-- need to do work on the sub and function system
--
--
-- need to add these commands
-- current_dir
-- chdir
-- dir
-- 
--
without type_check
without warning
include graphics.e
include machine.e
include get.e
include image.e
include font.e

if graphics_mode(18) then
end if

atom key, run_ok, line_number, key2, mode, execute_number
sequence data_info,code,file_data,goto_info,files, data_sub,subs,funs
atom mode_sub, debug_ok, error_ok, close_ok
sequence mode_line, global_info
sequence varb_name
global_info={}
varb_name={}
close_ok=1
debug_ok=0
error_ok=0
funs={}
execute_number=0
mode_sub=0
mode_line={}
subs={}
files={}
mode=0
data_sub={}
data_info={}
goto_info={}
code={}
file_data={}
run_ok=1
key2=0
line_number=1

function file_read(sequence string)
sequence buffer
object line
atom can
integer fn
can=0
fn = open(string, "r")
 if fn = -1 then
 end if
buffer = {}
while 1 do
 can=0
 line = gets(fn)
 if atom(line) then
  exit   
 end if
 for i=1 to length(line)-1 do
    if line[i]!=32 then
      can=1
      exit
    end if
 end for
 if can=0 then
   elsif can=1 then
   line=line[1..length(line)-1]
   line&={32}
   buffer = append(buffer, line)
 end if
end while
close(fn)
return buffer
end function

procedure file_code()
atom fn
fn = open("code.err", "w")
if fn = -1 then
end if
for i=1 to length(code) do
   for j=1 to length(code[i]) do
      puts(fn,code[i][j]&" ")
   end for
   puts(fn,"\n")
end for
close(fn)
end procedure

procedure file_close_all()
  for i=1 to length(files) do
     close(files[i][1])
  end for
end procedure

procedure err(sequence msg)
--sequence ff
file_data={}
files={}
data_sub={}
goto_info={}
subs={}
file_code()
file_close_all()
font_index={}
varb_name={}
funs={}
crash_message("Program Made By Gareth Mc Daid CopyRights 2005\nProgram End\n")
puts(1,msg&"\n")
--?ff
abort(1)
end procedure

function if_1(sequence string)
atom pos1,pos2,find,find2,number
number=0
pos1=0
pos2=0
find=0
find2=0
--
  for i=1 to length(string) do
     if string[i]='"' then
       find=1
       pos1=i+1
       exit
     end if
  end for
--
if pos1>0 then
--
  for i=pos1 to length(string) do
     if string[i]='"' then
       find2=1
       pos2=i-1
       exit
     end if
  end for
--
end if
--
for i=1 to length(string) do
   if string[i]='(' or string[i]=')' or string[i]='+' or string[i]='-' or string[i]='=' then
     number+=1
   end if
end for
if find=1 and find2=1 then
  for i=pos1 to pos2 do
   if string[i]='(' or string[i]=')' or string[i]='+' or string[i]='-' or string[i]='=' then
       number-=1
     end if
  end for
elsif find=1 and find2=0 then
 err("need 2 if_1")
end if
if number=0 then
  return 1
end if
return 0
end function

procedure add_for_code(sequence string)
sequence temp,name,val,too
atom find1,find2,array
atom pos1,pos2
too=""
array=0
find1=0
name=""
val=""
temp=""
find2=0
pos1=0
pos2=0
--
  for i=1 to length(string) do
   if string[i]!=32 then
     pos1=i
     exit
     end if
  end for
  for i=pos1+3 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
  for i=pos1 to length(string) do
     if string[i]=32 or string[i]='=' then
       pos2=i-1
       exit
     end if
  end for
  --
  name=string[pos1..pos2]
  --
  for i=pos1 to length(string) do
     if string[i]='=' then
       pos1=i+1
       exit
     end if
  end for

  for i=pos1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for

  for i=pos1 to length(string)-1 do
     if string[i]='t' and string[i+1]='o' and string[i-1]=32 then
       for j=pos1 to i do
          if string[j]=']' then
            array=1
            exit
          end if
       end for
       exit
     end if
  end for

  if array=0 then
    for i=pos1 to length(string) do
       if string[i]=32 then
         pos2=i-1
        exit
       end if
     end for
  elsif array=1 then
    for i=pos1 to length(string) do
       if string[i]=']' then
         pos2=i
        exit
       end if
     end for
  end if
  --
  array=0
  val=string[pos1..pos2]
  --
  for i=1 to length(string)-1 do
     if string[i]='t' and string[i+1]='o' and string[i-1]=32 then
       pos1=i+2
       exit
     end if
  end for
  for i=pos1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
  for i=pos1 to length(string) do
     if string[i]=']' then
       array=1
       exit
     end if
  end for
  if array=0 then
    for i=pos1 to length(string) do
       if string[i]=32 then
         pos2=i-1
         exit
       end if
    end for
  elsif array=1 then
    for i=pos1 to length(string) do
       if string[i]=']' then
         pos2=i
         exit
       end if
    end for
  end if
  --
  too=string[pos1..pos2]
  --
  code=append(code,{"for",name,val,too})
end procedure

procedure add_if_code(sequence string)
sequence temp,name,val,too
atom find1,find2,array,com
atom pos1,pos2
com=0
too=""
array=0
find1=0
name=""
val=""
temp=""
find2=0
pos1=0
pos2=0
--
for i=1 to length(string) do
  if string[i]='=' and string[i-1]!='!' and string[i-1]!='<' and string[i-1]!='>' then
    com=1
    exit
  end if
  if string[i]='=' and string[i-1]='!' then
    com=2
    exit
  end if
  if string[i]='<' and string[i+1]!='=' then
    com=3
    exit
  end if
  if string[i]='>' and string[i+1]!='=' then
    com=4
    exit
  end if
  if string[i]='<' and string[i+1]='=' then
    com=5
    exit
  end if
  if string[i]='>' and string[i+1]='=' then
    com=6
    exit
  end if
end for
--
  for i=1 to length(string) do
   if string[i]!=32 then
     pos1=i
     exit
     end if
  end for
  for i=pos1+2 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
if com=1 then
  for i=pos1 to length(string) do
     if string[i]=32 or string[i]='=' then
       pos2=i-1
       exit
     end if
  end for
else
  for i=pos1 to length(string) do
     if string[i]=32 or string[i]='!' or string[i]='<' or string[i]='>' then
       pos2=i-1
       exit
     end if
  end for
end if
  for i=pos1 to pos2 do
     if string[i]='[' then
       array=1
       exit
     end if
  end for
  for i=pos1 to pos2 do
     if string[i]='"' then
       find1=1
       exit
     end if
  end for
  --
  if array=1 then
  for i=pos1 to length(string) do
     if string[i]=']' then
       pos2=i
       exit
     end if
  end for
  name=string[pos1..pos2]
  else
    if find1=1 then
      for i=pos1+1 to length(string) do
         if string[i]='"' then
           pos2=i
           exit
        end if
      end for
      name=string[pos1..pos2]
    else
    name=string[pos1..pos2]
    end if
  end if
  array=0
  find1=0
  --
if com=1 then
  for i=pos1 to length(string) do
     if string[i]='=' then
       pos1=i+1
       exit
     end if
   end for
else
  for i=pos1 to length(string) do
     if string[i]='!' or string[i]='<' or string[i]='>' then
       if com=2 or com=5 or com=6 then
       pos1=i+2
       else
       pos1=i+1
       end if
       exit
     end if
  end for
end if

  for i=pos1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
  for i=pos1 to length(string) do
     if string[i]=32 then
       pos2=i-1
       exit
     end if
  end for
  for i=pos1 to pos2 do
     if string[i]='[' then
       array=1
       exit
     end if
  end for
  for i=pos1 to pos2 do
     if string[i]='"' then
       find1=1
       exit
     end if
  end for
  --
  if array=1 then
  for i=pos1 to length(string) do
     if string[i]=']' then
       pos2=i
       exit
     end if
  end for
  val=string[pos1..pos2]
  else
    if find1=1 then
      for i=pos1+1 to length(string) do
         if string[i]='"' then
           pos2=i
           exit
        end if
      end for
  val=string[pos1..pos2]
    else
  val=string[pos1..pos2]
    end if
  end if
  find1=0
  pos1=0
  pos2=0
  --
  code=append(code,{"if",name,val,com})
end procedure

procedure add_while_code(sequence string)
sequence temp,name,val,too
atom find1,find2,array,com
atom pos1,pos2
com=0
too=""
array=0
find1=0
name=""
val=""
temp=""
find2=0
pos1=0
pos2=0
--
for i=1 to length(string) do
  if string[i]='=' and string[i-1]!='!' and string[i-1]!='<' and string[i-1]!='>' then
    com=1
    exit
  end if
  if string[i]='=' and string[i-1]='!' then
    com=2
    exit
  end if
  if string[i]='<' and string[i+1]!='=' then
    com=3
    exit
  end if
  if string[i]='>' and string[i+1]!='=' then
    com=4
    exit
  end if
  if string[i]='<' and string[i+1]='=' then
    com=5
    exit
  end if
  if string[i]='>' and string[i+1]='=' then
    com=6
    exit
  end if
end for

--
  for i=1 to length(string) do
   if string[i]!=32 then
     pos1=i
     exit
     end if
  end for
  for i=pos1+5 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
if com=1 then
  for i=pos1 to length(string) do
     if string[i]=32 or string[i]='=' then
       pos2=i-1
       exit
     end if
  end for
else
  for i=pos1 to length(string) do
     if string[i]=32 or string[i]='!' or string[i]='<' or string[i]='>' then
       pos2=i-1
       exit
     end if
  end for
end if
  for i=pos1 to pos2 do
     if string[i]='[' then
       array=1
       exit
     end if
  end for
  for i=pos1 to pos2 do
     if string[i]='"' then
       find1=1
       exit
     end if
  end for
  --
  if array=1 then
  for i=pos1 to length(string) do
     if string[i]=']' then
       pos2=i
       exit
     end if
  end for
  name=string[pos1..pos2]
  else
    if find1=1 then
      for i=pos1+1 to length(string) do
         if string[i]='"' then
           pos2=i
           exit
        end if
      end for
      name=string[pos1..pos2]
    else
    name=string[pos1..pos2]
    end if
  end if
  array=0
  find1=0
  --
if com=1 then
  for i=pos1 to length(string) do
     if string[i]='=' then
       pos1=i+1
       exit
     end if
   end for
else
  for i=pos1 to length(string) do
     if string[i]='!' or string[i]='<' or string[i]='>' then
       if com=2 or com=5 or com=6 then
       pos1=i+2
       else
       pos1=i+1
       end if
       exit
     end if
  end for
end if
  for i=pos1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
  for i=pos1 to length(string) do
     if string[i]=32 then
       pos2=i-1
       exit
     end if
  end for
  for i=pos1 to pos2 do
     if string[i]='[' then
       array=1
       exit
     end if
  end for
  for i=pos1 to pos2 do
     if string[i]='"' then
       find1=1
       exit
     end if
  end for
  --
  if array=1 then
  for i=pos1 to length(string) do
     if string[i]=']' then
       pos2=i
       exit
     end if
  end for
  val=string[pos1..pos2]
  else
    if find1=1 then
      for i=pos1+1 to length(string) do
         if string[i]='"' then
           pos2=i
           exit
        end if
      end for
  val=string[pos1..pos2]
    else
  val=string[pos1..pos2]
    end if
  end if
  find1=0
  pos1=0
  pos2=0
  --
  code=append(code,{"while",name,val,com})
end procedure

procedure add_procedure_code(sequence string)
sequence name, arguments,temp
atom pos1,pos2
pos1=0
temp=""
arguments={}
name=""
pos2=0
for i=1 to length(string) do
   if string[i]!=32 then
     pos1=i
     exit
   end if
end for
for i=pos1+1 to length(string) do
   if string[i]='(' then
     pos2=i
     exit
   end if
end for
name=string[pos1..pos2-1]
arguments=append(arguments,name)
for i=pos2+1 to length(string) do
   if string[i]=',' or string[i]=')' then
     name=""
     temp=""
     name=string[pos2+1..i-1]
     for j=1 to length(name) do
        if name[j]!=32 then
          temp&=name[j]
        end if
     end for
     arguments=append(arguments,temp)
     pos2=i
   end if
end for
code=append(code,arguments)
end procedure

procedure add_sub_code(sequence string)
sequence name, arguments,temp
atom pos1,pos2
pos1=0
temp=""
arguments={}
name=""
pos2=0

for i=1 to length(string) do
   if string[i]='(' then
     pos1=i-1
     exit
   end if
end for
for i=pos1 to 1 by -1 do
   if string[i]=32 then
     pos2=i+1
     exit
   end if
end for
arguments=append(arguments,"sub")
name=string[pos2..pos1]
subs=append(subs,name)
arguments=append(arguments,name)
for i=1 to length(string) do
   if string[i]='(' then
     pos2=i
     exit
   end if
end for

for i=pos2+1 to length(string) do
   if string[i]=',' or string[i]=')' then
     name=""
     temp=""
     name=string[pos2+1..i-1]
     for j=1 to length(name) do
        if name[j]!=32 then
          temp&=name[j]
        end if
     end for
     arguments=append(arguments,temp)
     pos2=i
   end if
end for
code=append(code,arguments)
end procedure

procedure add_fun_code(sequence string)
sequence name, arguments,temp
atom pos1,pos2
pos1=0
temp=""
arguments={}
name=""
pos2=0
for i=1 to length(string) do
   if string[i]='(' then
     pos1=i-1
     exit
   end if
end for
for i=pos1 to 1 by -1 do
   if string[i]=32 then
     pos2=i+1
     exit
   end if
end for
arguments=append(arguments,"fun")
name=string[pos2..pos1]
funs=append(funs,name)
arguments=append(arguments,name)
for i=1 to length(string) do
   if string[i]='(' then
     pos2=i
     exit
   end if
end for
for i=pos2+1 to length(string) do
   if string[i]=',' or string[i]=')' then
     name=""
     temp=""
     name=string[pos2+1..i-1]
     for j=1 to length(name) do
        if name[j]!=32 then
          temp&=name[j]
        end if
     end for
     arguments=append(arguments,temp)
     pos2=i
   end if
end for
code=append(code,arguments)
end procedure

procedure add_function_code(sequence string)
sequence name, arguments,temp
atom pos1,pos2
pos1=0
temp=""
arguments={}
name=""
pos2=0
     for j=1 to length(string) do
        if string[j]!=32 then
          name&=string[j]
        end if
     end for
string=name
name=""
for i=1 to length(string) do
   if string[i]='=' then
     pos1=i+1
     exit
   end if
end for
for i=pos1 to length(string) do
   if string[i]='(' then
     pos2=i-1
     exit
   end if
end for
name=string[pos1..pos2]
arguments=append(arguments,name)
name=""
pos1=0
pos2=0
for i=1 to length(string) do
   if string[i]!=32 then
     pos1=i
     exit
   end if
end for
for i=pos1 to length(string) do
   if string[i]='=' then
     pos2=i-1
     exit
   end if
end for
name=string[pos1..pos2]
arguments=append(arguments,name)
name=""
for i=pos1 to length(string) do
   if string[i]='(' then
     pos2=i
     exit
   end if
end for
for i=pos2+1 to length(string) do
   if string[i]=',' or string[i]=')' then
     name=""
     name=string[pos2+1..i-1]
     arguments=append(arguments,name)
     pos2=i
   end if
end for
code=append(code,arguments)
end procedure

function check(sequence string)
sequence temp
atom find1,find2,can,find3
atom pos1,pos2
find3=0
find1=0
temp=""
can=0
find2=0
pos1=0
pos2=0
-- check if comment
for i=1 to length(string) do
   if string[i]!=32 then
     pos1=i
     exit
   end if
end for
for i=pos1+1 to length(string) do
   if string[i]='-' then
     pos2=i
     exit
   end if
end for
if pos2=0 then
  if compare(string[pos1..length(string)],"--")=0 then
    can=1
  end if
else
  if compare(string[pos1..pos2],"--")=0 then
    can=1
  end if
end if
if can=1 then
  return 0
end if
-- end check
find1=0
temp=""
can=0
find2=0
pos1=0
pos2=0
-- check if function
for i=1 to length(string) do
   if string[i]='=' then
      find1=1
      exit
   end if
end for
for i=1 to length(string) do
   if string[i]='(' then
      find2=1
      exit
   end if
end for
for i=1 to length(string) do
   if string[i]=')' then
      find3=1
      exit
   end if
end for
if find1=1 and find2=1 and find3=1 then
  return 9
end if
-- end check
find1=0
temp=""
can=0
find2=0
pos1=0
pos2=0
-- check if sub
  for i=1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
if length(string)>pos1+3 then
  if equal(string[pos1..pos1+3],"sub ")=1 then
    for i=pos1 to length(string) do
         if string[i]='(' then
           find1=1
           exit
         end if
    end for
   if find1=1 then
     return 12
   else
    err("a sub with no () "&string)
   end if
  end if
end if
-- end check sub
find1=0
temp=""
can=0
find2=0
pos1=0
pos2=0
-- check if function sub
  for i=1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
if length(string)>pos1+8 then
  if equal(string[pos1..pos1+8],"function ")=1 then
    for i=pos1 to length(string) do
         if string[i]='(' then
           find1=1
           exit
         end if
    end for
   if find1=1 then
     return 14
   else
    err("a function with no () "&string)
   end if
  end if
end if
-- end check function sub
find1=0
temp=""
can=0
find2=0
pos1=0
pos2=0
-- check if procedure
for i=1 to length(string) do
   if string[i]='=' then
      find1=1
      exit
   end if
end for
for i=1 to length(string) do
   if string[i]='(' then
      find2=1
      exit
   end if
end for
for i=1 to length(string) do
   if string[i]=')' then
      find3=1
      exit
   end if
end for
if find1=0 and find2=1 and find3=1 then
  return 6
end if
-- end check
find1=0
temp=""
can=0
find2=0
pos1=0
pos2=0
-- check if end sub
  for i=1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
if length(string)>pos1+2 then
if equal(string[pos1..pos1+2],"end")=1 then
  for i=pos1 to length(string)-2 do
     if string[i]='s' and string[i+1]='u' and string[i+2]='b' and string[i+3]=32 and string[i-1]=32 then
       find1=1
       exit
     end if
  end for
  if find1=1 then
    return 13
  end if
end if
end if
--end check end while
find1=0
temp=""
can=0
find2=0
pos1=0
pos2=0
-- check if end function
  for i=1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
if length(string)>pos1+2 then
if equal(string[pos1..pos1+2],"end")=1 then
  for i=pos1 to length(string)-8 do
     if string[i]='f' and string[i+1]='u' and string[i+2]='n' and string[i+3]='c' and string[i+4]='t' and string[i+5]='i' and string[i+6]='o'
        and string[i+7]='n' and string[i+8]=32 and string[i-1]=32 then
       find1=1
       exit
     end if
  end for
  if find1=1 then
    return 15
  end if
end if
end if
--end check end function
find1=0
temp=""
can=0
find2=0
pos1=0
pos2=0
-- check if while satement
  for i=1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
if length(string)>pos1+5 then
  if equal(string[pos1..pos1+5],"while ")=1 then
    for i=pos1 to length(string)-1 do
       if string[i]='d' and string[i+1]='o' and string[i-1]=32 and string[i+2]=32 then
         find1=1
         exit
       end if
    end for
    if find1=1 then
      return 7
    elsif find1=0 then
      err("a while satement with out the do staement "&string)
    end if
  end if
end if
-- end check while
find1=0
temp=""
can=0
find2=0
pos1=0
pos2=0
-- check if end while 
  for i=1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
if length(string)>2 then
if equal(string[pos1..pos1+2],"end")=1 then
  for i=pos1 to length(string)-5 do
     if string[i]='w' and string[i+1]='h' and string[i+2]='i'and string[i+3]='l'and string[i+4]='e' and string[i+5]=32 and string[i-1]=32 then
       find1=1
       exit
     end if
  end for
  if find1=1 then
    return 8
  end if
end if
end if
--end check end while
find1=0
temp=""
can=0
find2=0
pos1=0
pos2=0
-- check if if satement
  for i=1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
if length(string)>3 then
  if equal(string[pos1..pos1+2],"if ")=1 then
    for i=pos1 to length(string)-4 do
       if string[i]='t' and string[i+1]='h' and string[i+2]='e' and string[i+3]='n' and string[i-1]=32 and string[i+4]=32 then
         find1=1
         exit
       end if
    end for
    if find1=1 then
      return 4
    elsif find1=0 then
      err("a if satement with out the then staement "&string)
    end if
  end if
end if
--end check
find1=0
temp=""
can=0
find2=0
pos1=0
pos2=0
-- check if end if 
  for i=1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
if length(string)>1 then
if equal(string[pos1..pos1+2],"end")=1 then
  for i=pos1 to length(string)-2 do
     if string[i]='i' and string[i+1]='f' and string[i+2]=32 and string[i-1]=32 then
       find1=1
       exit
     end if
  end for
  if find1=1 then
    return 5
  end if
end if
end if
--end check
find1=0
temp=""
can=0
find2=0
pos1=0
pos2=0
-- check if for loop
  for i=1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
if length(string)>pos1+3 then
if equal(string[pos1..pos1+3],"for ")=1 then
  for i=pos1 to length(string)-2 do
     if string[i]='t' and string[i+1]='o'and string[i-1]=32 and string[i+2]=32 then
       find2=1
     end if
     if string[i]='d' and string[i+1]='o'and string[i-1]=32 and string[i+2]=32 then
       find1=1
       exit
     end if
  end for
  if find1=1 and find2=1 then
    return 2
  elsif find1=0 and find2=1 then
    err("err for loop with out closeing do satement "&string)
  elsif find1=1 and find2=0 then
    err("err for loop with out to satement "&string)
  end if
end if
end if
--end check if for loop
find1=0
temp=""
find2=0
pos1=0
pos2=0
-- check if for loop end
  for i=1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
if length(string)>1 then
if equal(string[pos1..pos1+2],"end")=1 then
  for i=pos1 to length(string)-3 do
     if string[i]='f' and string[i+1]='o' and string[i+2]='r' and string[i+3]=32 then
       find1=1
       exit
     end if
  end for
  if find1=1 then
    return 3
  end if
end if
end if
--end check if for loop end
find1=0
temp=""
find2=0
pos1=0
pos2=0

-- check if varb
  for i=1 to length(string) do
     if string[i]='=' then
       find1=1
       temp=string[i+1..length(string)]
       exit
     end if
  end for
  if if_1(temp)=0 then
    find2=1
  end if
if find1=1 and find2=0 then
  return 1
end if
-- end check varb
return 21
end function

procedure add_varb_code(sequence string)
atom pos1,pos2,find,find2,arry,new
sequence arg, name, val, val2
find2=0
val2=""
arry=0
name=""
val=""
arg={}
find=0
pos1=0
pos2=0
new=0
--
  for i=1 to length(string) do
     if string[i]='=' then
       exit
     end if
     if string[i]=']' then
       new=1
       exit
     end if
  end for
--
  for i=1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
--
--
if new=0 then
  for i=pos1 to length(string) do
     if string[i]=32 or string[i]='=' or string[i]='+' or string[i]='-' then
       pos2=i-1
       exit
     end if
  end for
else
  for i=pos1 to length(string) do
     if string[i]=']' then
       pos2=i
       exit
     end if
  end for
end if
--
name=string[pos1..pos2]
pos1=0
pos2=0
for i=1 to length(name) do
   if name[i]='[' then
     arry=1
     pos1=i+1
     exit
   end if
end for
if arry=1 then
  for i=pos1 to length(name) do
     if name[i]=']' then
       pos2=i-1
       exit
     end if
  end for
  val2=name[pos1..pos2]
  name=name[1..pos1-2]
end if
pos1=0
pos2=0
--
for i=1 to length(string) do
   if string[i]='"' then
     pos1=i+1
     exit
   end if
end for
--
if pos1>0 then
for i=pos1 to length(string) do
   if string[i]='"' then
     pos2=i-1
     exit
   end if
end for
end if
--
if pos1>0 and pos2>0 then
  find2=1
elsif pos1>0 and pos2=0 then
  err("err need 2 "&string)
end if
--
if find2=0 then
--
  for i=1 to length(string) do
     if string[i]='=' then
       pos1=i+1
       exit
     end if
  end for
--
--
  for i=pos1 to length(string) do
     if string[i]!=32 then
       pos1=i
       exit
     end if
  end for
--
if new=0 then
--
  for i=pos1+1 to length(string) do
     if string[i]=32 then
       pos2=i-1
       exit
     end if
  end for
else
  for i=pos1 to length(string) do
     if string[i]=']' then
       pos2=i
       exit
     end if
  end for
end if
--
if pos2=0 then
  val=string[pos1..length(string)]
else
  val=string[pos1..pos2]
end if
--
elsif find2=1 then
  val=string[pos1-1..pos2+1]
end if
--
  for i=1 to length(string) do
     if string[i]='=' then
       find=1
       exit
     elsif string[i]='+' then
       find=2
       exit
     elsif string[i]='-' then
       find=3
       exit
     end if
  end for
--
if arry=0 then
if find=1 then
  code=append(code,{"info_set",name,val})
elsif find=2 then
  code=append(code,{"info_plus",name,val})
elsif find=3 then
  code=append(code,{"info_min",name,val})
end if
else
if find=1 then
  code=append(code,{"info_set_array",name,val2,val})
elsif find=2 then
  code=append(code,{"info_plus_array",name,val2,val})
elsif find=3 then
  code=append(code,{"info_min_array",name,val2,val})
end if
end if
end procedure

procedure make_code()
atom temp
  for i=1 to length(file_data) do
     temp=check(file_data[i])
     if temp=1 then
       add_varb_code(file_data[i])
     elsif temp=2 then
       add_for_code(file_data[i])
     elsif temp=3 then
       code=append(code,"end_for")
     elsif temp=4 then
       add_if_code(file_data[i])
     elsif temp=5 then
       code=append(code,"end_if")
     elsif temp=6 then
       add_procedure_code(file_data[i])
     elsif temp=7 then
        add_while_code(file_data[i])
     elsif temp=8 then
       code=append(code,"end_while")
     elsif temp=9 then
       add_function_code(file_data[i])
     elsif temp=12 then
       add_sub_code(file_data[i])
     elsif temp=13 then
       code=append(code,"end_sub")
     elsif temp=14 then
       add_fun_code(file_data[i])
     elsif temp=15 then
       code=append(code,"end_fun")
     elsif temp=21 then
      err("don't no what this is "&file_data[i])
     end if
  end for
end procedure

function remove_line(sequence string, atom line)
sequence temp
temp={}
  for i=1 to length(string) do
     if i=line then
     else
     temp=append(temp,string[i])
     end if
  end for
return temp
end function

function add_line(sequence string, atom line)
sequence temp
temp={}
  for i=1 to length(string) do
     if i=line then
     temp=append(temp,string[i])
     temp=append(temp,"")
     else
     temp=append(temp,string[i])
     end if
  end for
return temp
end function

procedure make_for_loop()
sequence list1, list2
atom number,line
line=1
list1="for1"
list2="for2"
number=0
for k=1 to length(code) do
  for i=line to length(code) do
     if compare(code[i][1],"for")=0 then
        number=1
        for j=i+1 to length(code) do
           if compare(code[j][1],"for")=0 then
             number+=1
           end if
           if compare(code[j],"end_for")=0 then
             number-=1
           end if
           if number=0 then
             line=i+1
             code[i]=append(code[i],list2)
             code=add_line(code,i-1)
             code[i]=append(code[i],"lable")
             code[i]=append(code[i],list1)
             code=add_line(code,j+1)
             code[j+1]={"goto",list1}
             code[j+2]={"lable",list2}
             list1&="1"
             list2&="2"
             exit
           end if
         end for
     end if
  end for
end for
end procedure

procedure make_if_code()
sequence list1, list2
atom number, line
line=1
list1="if1"
list2="if2"
number=0
for k=1 to length(code) do
  for i=line to length(code) do
     if compare(code[i][1],"if")=0 then
        number=1
        for j=i+1 to length(code) do
           if compare(code[j][1],"if")=0 then
             number+=1
           end if
           if compare(code[j],"end_if")=0 then
             number-=1
           end if
           if number=0 then
             line=i+1
             code[i]=append(code[i],list1)
             code[i]=append(code[i],list2)
             code=add_line(code,i)
             code[i+1]=append(code[i+1],"lable")
             code[i+1]=append(code[i+1],list1)
             code[j+1]={"lable",list2}
             list1&="1"
             list2&="2"
             exit
           end if
         end for
     end if
  end for
end for
end procedure

procedure make_while_code()
sequence list1, list2
atom number,line
line=1
list1="while1"
list2="while2"
number=0
for k=1 to length(code) do
  for i=line to length(code) do
     if compare(code[i][1],"while")=0 then
        number=1
        for j=i+1 to length(code) do
           if compare(code[j][1],"while")=0 then
             number+=1
           end if
           if compare(code[j],"end_while")=0 then
             number-=1
           end if
           if number=0 then
             line=i+1
             code[i]=append(code[i],list2)
             code=add_line(code,i-1)
             code[i]=append(code[i],"lable")
             code[i]=append(code[i],list1)
             code=add_line(code,j+1)
             code[j+1]={"goto",list1}
             code[j+2]={"lable",list2}
             list1&="1"
             list2&="2"
             exit
           end if
         end for
     end if
  end for
end for
end procedure

procedure make_sub_code()
sequence list1, list2
atom number,line
line=1
list1="sub1"
list2="sub2"
number=0
for k=1 to length(code) do
  for i=line to length(code) do
     if compare(code[i][1],"sub")=0 then
        number=1
        for j=i+1 to length(code) do
           if compare(code[j][1],"sub")=0 then
             number+=1
           end if
           if compare(code[j],"end_sub")=0 then
             number-=1
           end if
           if number=0 then
             line=i+1
             code[i]=add_line(code[i],1)
             code[i][2]=list1
             code=add_line(code,i-1)
             code=add_line(code,i-1)
             code[i]=append(code[i],"goto")
             code[i]=append(code[i],list2)
             code[i+1]=append(code[i+1],"lable")
             code[i+1]=append(code[i+1],list1)
             code=add_line(code,j+2)
             code[j+2]={"mode","0"}
             code[j+3]={"lable",list2}
             list1&="1"
             list2&="2"
             exit
           end if
         end for
     end if
  end for
end for
end procedure

procedure make_fun_code()
sequence list1, list2
atom number,line
line=1
list1="fun1"
list2="fun2"
number=0
for k=1 to length(code) do
  for i=line to length(code) do
     if compare(code[i][1],"fun")=0 then
        number=1
        for j=i+1 to length(code) do
           if compare(code[j][1],"fun")=0 then
             number+=1
           end if
           if compare(code[j],"end_fun")=0 then
             number-=1
           end if
           if number=0 then
             line=i+1
             code[i]=add_line(code[i],1)
             code[i][2]=list1
             code=add_line(code,i-1)
             code=add_line(code,i-1)
             code[i]=append(code[i],"goto")
             code[i]=append(code[i],list2)
             code[i+1]=append(code[i+1],"lable")
             code[i+1]=append(code[i+1],list1)
             code=add_line(code,j+2)
             code[j+2]={"mode2","0"}
             code[j+3]={"lable",list2}
             list1&="1"
             list2&="2"
             exit
           end if
         end for
     end if
  end for
end for
end procedure

------------------
--mode 0 or 1
------------------
function info_exsist(sequence name)
if mode=0 then
  for i=1 to length(data_info) do
     if equal(data_info[i][1],name)=1 then
       return {1,i,data_info[i][3]}
     end if
  end for
elsif mode=1 then
  for i=1 to length(data_sub[mode_sub]) do
     if equal(data_sub[mode_sub][i][1],name)=1 then
       return {1,i,data_sub[mode_sub][i][3]}
     end if
  end for
end if
return {0,0,0}
end function

procedure info_set(sequence name, object val)
sequence temp
atom exsist,line,type2
exsist=0
line=0
type2=0
temp=info_exsist(name)
exsist=temp[1]
line=temp[2]
type2=temp[3]
--
if mode=0 then
if exsist=0 then
  data_info=append(data_info,{name,val,0,0,0})
elsif exsist=1 and type2=0 then
  if atom(val)=1 then
     if atom(data_info[line][2])=1 then
       data_info[line][2]=val
       else
       err("trying to set string "&name&" to number "&sprint(val))
     end if
      else
     if atom(data_info[line][2])=0 then
       data_info[line][2]=val
       else
       err("trying to set number "&name&" to string "&val)
     end if
  end if
else
err("varb allready exsist as a array")
end if
elsif mode=1 then
if exsist=0 then
  data_sub[mode_sub]=append(data_sub[mode_sub],{name,val,0,0,0})
elsif exsist=1 and type2=0 then
  if atom(val)=1 then
     if atom(data_sub[mode_sub][line][2])=1 then
       data_sub[mode_sub][line][2]=val
       else
       err("trying to set string "&name&" to number "&sprint(val))
     end if
      else
     if atom(data_sub[mode_sub][line][2])=0 then
       data_sub[mode_sub][line][2]=val
       else
       err("trying to set number "&name&" to string "&val)
     end if
  end if
else
err("varb allready exsist as a array")
end if
end if
end procedure

procedure info_plus(sequence name, object val)
sequence temp
atom exsist,line,type2
exsist=0
line=0
type2=0
temp=info_exsist(name)
exsist=temp[1]
line=temp[2]
type2=temp[3]
--
if mode =0 then
if exsist=0 then
  err("varb "&name&" dose not exsist")
elsif exsist=1 and type2=0 then
  if atom(val)=1 then
     if atom(data_info[line][2])=1 then
       data_info[line][2]+=val
       else
       err("trying to set string "&name&" to number "&sprint(val))
     end if
      else
     if atom(data_info[line][2])=0 then
       data_info[line][2]&=val
       else
       err("trying to set number "&name&" to string "&val)
     end if
  end if
else
err("varb allready exsist as a array")
end if
elsif mode=1 then
if exsist=0 then
  err("varb "&name&" dose not exsist")
elsif exsist=1 and type2=0 then
  if atom(val)=1 then
     if atom(data_sub[mode_sub][line][2])=1 then
       data_sub[mode_sub][line][2]+=val
       else
       err("trying to set string "&name&" to number "&sprint(val))
     end if
      else
     if atom(data_sub[mode_sub][line][2])=0 then
       data_sub[mode_sub][line][2]&=val
       else
       err("trying to set number "&name&" to string "&val)
     end if
  end if
else
err("varb allready exsist as a array")
end if
end if
end procedure

procedure info_min(sequence name, object val)
sequence temp
atom exsist,line,type2
exsist=0
line=0
type2=0
temp=info_exsist(name)
exsist=temp[1]
line=temp[2]
type2=temp[3]
--
if mode=0 then
if exsist=0 then
  err("varb "&name&" dose not exsist")
elsif exsist=1 and type2=0 then
  if atom(val)=1 then
     if atom(data_info[line][2])=1 then
       data_info[line][2]-=val
       else
       err("trying to set string "&name&" to number "&sprint(val))
     end if
      else
     if atom(data_info[line][2])=0 then
       err("trying to min equal on a string "&name)
       data_info[line][2]&=val
       else
       err("trying to set number "&name&" to string "&val)
     end if
  end if
else
err("varb allready exsist as a array")
end if
elsif mode=1 then
if exsist=0 then
  err("varb "&name&" dose not exsist")
elsif exsist=1 and type2=0 then
  if atom(val)=1 then
     if atom(data_sub[mode_sub][line][2])=1 then
       data_sub[mode_sub][line][2]-=val
       else
       err("trying to set string "&name&" to number "&sprint(val))
     end if
      else
     if atom(data_sub[mode_sub][line][2])=0 then
       err("trying to min equal on a string "&name)
       data_sub[mode_sub][line][2]&=val
       else
       err("trying to set number "&name&" to string "&val)
     end if
  end if
else
err("varb allready exsist as a array")
end if
end if
end procedure

procedure info_set_array(sequence name, atom number ,object val)
sequence temp
atom exsist,line,type2
exsist=0
line=0
type2=0
temp=info_exsist(name)
exsist=temp[1]
line=temp[2]
type2=temp[3]

if mode=0 then
if exsist=0 then
  data_info=append(data_info,{name,repeat(val,number),1,0,0})
elsif exsist=1 and type2=1 then
  if number>length(data_info[line][2]) then
    if atom(val)=1 then
     if atom(data_info[line][2][1])=1 then
         for i=1 to number-length(data_info[line][2]) do
             data_info[line][2]=append(data_info[line][2],val)
         end for
       else
       err("trying to set string "&name&" to number "&sprint(val))
     end if
    else
       if atom(data_info[line][2][1])=0 then
         for i=1 to number-length(data_info[line][2]) do
             data_info[line][2]=append(data_info[line][2],val)
         end for
         else
         err("trying to set number "&name&" to string "&val)
       end if
    end if
  --  err("array index number "&sprint(number)&" dose not exsist")
  elsif number=0 then
    err("array index number "&sprint(number)&" dose not exsist")
  end if
  if atom(val)=1 then
     if atom(data_info[line][2][number])=1 then
       data_info[line][2][number]=val
       else
       err("trying to set string "&name&" to number "&sprint(val))
     end if
      else
     if atom(data_info[line][2][number])=0 then
       data_info[line][2][number]=val
       else
       err("trying to set number "&name&" to string "&val)
     end if
  end if
else
err("array allready exsist as a varb")
end if
elsif mode=1 then
if exsist=0 then
  data_sub[mode_sub]=append(data_sub[mode_sub],{name,repeat(val,number),1,0,0})
elsif exsist=1 and type2=1 then
  if number>length(data_sub[mode_sub][line][2]) then
    if atom(val)=1 then
     if atom(data_sub[mode_sub][line][2][1])=1 then
         for i=1 to number-length(data_sub[mode_sub][line][2]) do
             data_sub[mode_sub][line][2]=append(data_sub[mode_sub][line][2],val)
         end for
       else
       err("trying to set string "&name&" to number "&sprint(val))
     end if
    else
       if atom(data_sub[mode_sub][line][2][1])=0 then
         for i=1 to number-length(data_sub[mode_sub][line][2]) do
             data_sub[mode_sub][line][2]=append(data_sub[mode_sub][line][2],val)
         end for
         else
         err("trying to set number "&name&" to string "&val)
       end if
    end if
  --  err("array index number "&sprint(number)&" dose not exsist")
  elsif number=0 then
    err("array index number "&sprint(number)&" dose not exsist")
  end if
  if atom(val)=1 then
     if atom(data_sub[mode_sub][line][2][number])=1 then
       data_sub[mode_sub][line][2][number]=val
       else
       err("trying to set string "&name&" to number "&sprint(val))
     end if
      else
     if atom(data_sub[mode_sub][line][2][number])=0 then
       data_sub[mode_sub][line][2][number]=val
       else
       err("trying to set number "&name&" to string "&val)
     end if
  end if
else
err("array allready exsist as a varb")
end if
end if
end procedure

procedure info_plus_array(sequence name, atom number ,object val)
sequence temp
atom exsist,line,type2
exsist=0
line=0
type2=0
temp=info_exsist(name)
exsist=temp[1]
line=temp[2]
type2=temp[3]

if mode=0 then
if exsist=0 then
  err("array"&name&"dose not exsist")
elsif exsist=1 and type2=1 then
  if number>length(data_info[line][2]) then
    err("array index number "&sprint(number)&" dose not exsist")
  elsif number=0 then
    err("array index number "&sprint(number)&" dose not exsist")
  end if
  if atom(val)=1 then
     if atom(data_info[line][2][number])=1 then
       data_info[line][2][number]+=val
       else
       err("trying to set string "&name&" to number "&sprint(val))
     end if
      else
     if atom(data_info[line][2][number])=0 then
       data_info[line][2][number]&=val
       else
       err("trying to set number "&name&" to string "&val)
     end if
  end if
else
err("array allready exsist as a varb")
end if
elsif mode=1 then
if exsist=0 then
  err("array "&name&" dose not exsist")
elsif exsist=1 and type2=1 then
  if number>length(data_sub[mode_sub][line][2]) then
    err("array index number "&sprint(number)&" dose not exsist")
  elsif number=0 then
    err("array index number "&sprint(number)&" dose not exsist")
  end if
  if atom(val)=1 then
     if atom(data_sub[mode_sub][line][2][number])=1 then
       data_sub[mode_sub][line][2][number]+=val
       else
       err("trying to set string "&name&" to number "&sprint(val))
     end if
      else
     if atom(data_sub[mode_sub][line][2][number])=0 then
       data_sub[mode_sub][line][2][number]&=val
       else
       err("trying to set number "&name&" to string "&val)
     end if
  end if
else
err("array allready exsist as a varb")
end if
end if
end procedure

procedure info_min_array(sequence name, atom number ,object val)
sequence temp
atom exsist,line,type2
exsist=0
line=0
type2=0
temp=info_exsist(name)
exsist=temp[1]
line=temp[2]
type2=temp[3]

if mode=0 then
if exsist=0 then
  err("array dose not exsist")
elsif exsist=1 and type2=1 then
  if number>length(data_info[line][2]) then
    err("array index number "&sprint(number)&" dose not exsist")
  elsif number=0 then
    err("array index number "&sprint(number)&" dose not exsist")
  end if
  if atom(val)=1 then
     if atom(data_info[line][2][number])=1 then
       data_info[line][2][number]-=val
       else
       err("trying to set string "&name&" to number "&sprint(val))
     end if
      else
     if atom(data_info[line][2][number])=0 then
       err("trying to min equal on a string "&name)
       data_info[line][2][number]=val
       else
       err("trying to set number "&name&" to string "&val)
     end if
  end if
else
err("array allready exsist as a varb")
end if
elsif mode=1 then
if exsist=0 then
  err("array dose not exsist")
elsif exsist=1 and type2=1 then
  if number>length(data_sub[mode_sub][line][2]) then
    err("array index number "&sprint(number)&" dose not exsist")
  elsif number=0 then
    err("array index number "&sprint(number)&" dose not exsist")
  end if
  if atom(val)=1 then
     if atom(data_sub[mode_sub][line][2][number])=1 then
       data_sub[mode_sub][line][2][number]-=val
       else
       err("trying to set string "&name&" to number "&sprint(val))
     end if
      else
     if atom(data_sub[mode_sub][line][2][number])=0 then
       err("trying to min equal on a string "&name)
       data_sub[mode_sub][line][2][number]=val
       else
       err("trying to set number "&name&" to string "&val)
     end if
  end if
else
err("array allready exsist as a varb")
end if
end if
end procedure

function varbs(sequence val)
sequence temp,temp2
atom exsist,line,find,find2,number
number=0
temp2=""
find=0
find2=0
exsist=0
line=0

if mode=0 then
-- cheks if string
  for i=1 to length(val) do
     if val[i]='"' then
       find=1
       exit
     end if
  end for
if find=0 then
temp=val
for k=1 to length(temp) do
   if temp[k]!=32 then
     temp2&=temp[k]
   end if
end for
val=temp2
temp=""
temp2=""
end if
-- check if array and set varb val to name
  for i=1 to length(val) do
     if val[i]='[' then
       for j=i to length(val) do
          if val[j]=']' then
            temp=val[i+1..j-1]
            for k=1 to length(temp) do
               if temp[k]!=32 then
                  temp2&=temp[k]
               end if
            end for
            temp=value(temp2)
            number=temp[2]
            temp=""
            exit
          end if
       end for
       find2=1
       val=val[1..i-1]
       temp=info_exsist(temp2)
       if temp[1]=1 then
         number=data_info[temp[2]][2]
       end if
       exit
     end if
  end for
--
temp=info_exsist(val)
exsist=temp[1]
line=temp[2]
--
if exsist=1 then
  if find2=1 then
    if length(data_info[line][2])<number then
      err(val&" index number out of bounds "&sprint(number))
    end if
    if number=0 then
      err(val&" index number out of bounds "&sprint(number))
    end if
    return data_info[line][2][number]
    else
    if data_info[line][3]=0 then
    return data_info[line][2]
    else
      err(val&" is a array not a varb")
    end if
  end if
else
  if find2=1 then
    err("array dose not exsist "&val&"\n")
    --err("array index out of bounds "&val&"\n")
  end if
  if find=1 then
    return val[2..length(val)-1]
  else
   temp=""
    temp=value(val)
    if temp[1]=GET_SUCCESS then
    return temp[2]
    else
      err(val&" dose not exist")
    end if
  end if
end if
-------------------
elsif mode=1 then
-- cheks if string
  for i=1 to length(val) do
     if val[i]='"' then
       find=1
       exit
     end if
  end for
if find=0 then
temp=val
for k=1 to length(temp) do
   if temp[k]!=32 then
     temp2&=temp[k]
   end if
end for
val=temp2
temp=""
temp2=""
end if
-- check if array and set varb val to name
  for i=1 to length(val) do
     if val[i]='[' then
       for j=i to length(val) do
          if val[j]=']' then
            temp=val[i+1..j-1]
            for k=1 to length(temp) do
               if temp[k]!=32 then
                  temp2&=temp[k]
               end if
            end for
            temp=value(temp2)
            number=temp[2]
            temp=""
            exit
          end if
       end for
       find2=1
       val=val[1..i-1]
       temp=info_exsist(temp2)
       if temp[1]=1 then
         number=data_sub[mode_sub][temp[2]][2]
       end if
       exit
     end if
  end for
--
temp=info_exsist(val)
exsist=temp[1]
line=temp[2]
--
if exsist=1 then
  if find2=1 then
    if length(data_sub[mode_sub][line][2])<number then
      err(val&" index number out of bounds "&sprint(number))
    end if
    if number=0 then
      err(val&" index number out of bounds "&sprint(number))
    end if
    return data_sub[mode_sub][line][2][number]
    else
    if data_sub[mode_sub][line][3]=0 then
    return data_sub[mode_sub][line][2]
    else
      err(val&" is a array not a varb")
    end if
  end if
else
  if find2=1 then
    err("array dose not exsist "&val&"\n")
    --err("array index out of bounds "&val&"\n")
  end if
  if find=1 then
    return val[2..length(val)-1]
  else
   temp=""
    temp=value(val)
    if temp[1]=GET_SUCCESS then
    return temp[2]
    else
      err(val&" dose not exist")
    end if
  end if
end if
end if
end function

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
  err("goto")
end if
end procedure

procedure check_code()
sequence temp,val
atom number, number2
val={}
number2=0
number=0
temp={}
  for i=1 to length(code) do
     if equal(code[i][1],"info_set")=1 then
       temp=append(temp,code[i][2])
     end if
     if equal(code[i][1],"info_plus")=1 then
       temp=append(temp,code[i][2])
     end if
     if equal(code[i][1],"info_min")=1 then
       temp=append(temp,code[i][2])
     end if
     if equal(code[i][1],"info_set_array")=1 then
       temp=append(temp,code[i][2])
     end if
     if equal(code[i][1],"info_plus_array")=1 then
       temp=append(temp,code[i][2])
     end if
     if equal(code[i][1],"info_min_array")=1 then
       temp=append(temp,code[i][2])
     end if
  end for
  for i=1 to length(code) do
     if equal(code[i][1],"if")=1 then
       if length(code[i])!=6 then
          err("this if satement Has no end if satement if "&code[i][2]&" = "&code[i][3]&" then")
       end if
     end if
     if equal(code[i][1],"for")=1 then
       if length(code[i])!=5 then
          err("this for loop Has no end for satement for "&code[i][2]&" = "&code[i][3]&" to "&code[i][4]&" do ")
       end if
       for j=1 to length(temp) do
          if equal(temp[j],code[i][2])=1 then
            err("varb "&code[i][2]&" is trying to be use in a for loop")
          end if
       end for
     end if
  end for
end procedure

procedure set_varbs(sequence name, object val)
sequence temp, temp2
atom array, pos1, exsist,line
temp2=""
array=0
exsist=0
line=0
pos1=0
temp=""
if mode=0 then
  for i=1 to length(name) do
     if name[i]!=32 then
        temp&=name[i]
     end if
     if name[i]='[' then
       array=1
       pos1=i+1
     end if
  end for
name=temp
temp=""
if array=1 then
  for i=pos1 to length(name) do
     if name[i]=']' then
       temp=name[pos1..i-1]
     end if
  end for
    name=name[1..pos1-2]
    temp2=value(temp)
    if temp2[1]=GET_SUCCESS then
      if temp2[2]=0 then
        err("array index number out of bounds 0")
      end if
      info_set_array(name,temp2[2],val)
    else
       temp2=""
       temp2=info_exsist(temp)
       exsist=temp2[1]
       line=temp2[2]
       if exsist=1 then
         info_set_array(name,data_info[line][2],val)
       else
         err("varb not exsist "&temp)
       end if
    end if
else
info_set(name,val)
end if
elsif mode=1 then
  for i=1 to length(name) do
     if name[i]!=32 then
        temp&=name[i]
     end if
     if name[i]='[' then
       array=1
       pos1=i+1
     end if
  end for
name=temp
temp=""
if array=1 then
  for i=pos1 to length(name) do
     if name[i]=']' then
       temp=name[pos1..i-1]
     end if
  end for
    name=name[1..pos1-2]
    temp2=value(temp)
    if temp2[1]=GET_SUCCESS then
      if temp2[2]=0 then
        err("array index number out of bounds 0")
      end if
      info_set_array(name,temp2[2],val)
    else
       temp2=""
       temp2=info_exsist(temp)
       exsist=temp2[1]
       line=temp2[2]
       if exsist=1 then
         info_set_array(name,data_sub[mode_sub][line][2],val)
       else
         err("varb dose not exsist "&temp)
       end if
    end if
else
info_set(name,val)
end if
end if
end procedure

function for_loop(sequence name, atom val, atom too)
sequence temp
atom exsist,line
exsist=0
line=0
temp=info_exsist(name)
exsist=temp[1]
line=temp[2]
--
if mode=0 then
if exsist=0 then
if val>too then
  return 1
end if
data_info=append(data_info,{name,val,0,too+1,0})
else
val=data_info[line][2]
too=data_info[line][4]
if val>=too then
  return 1
end if
data_info[line][2]+=1
if data_info[line][2]>=data_info[line][4] then
  data_info=remove_line(data_info,line)
  return 1
end if
end if
elsif mode=1 then
if exsist=0 then
if val>too then
  return 1
end if
data_sub[mode_sub]=append(data_sub[mode_sub],{name,val,0,too+1,0})
else
val=data_sub[mode_sub][line][2]
too=data_sub[mode_sub][line][4]
if val>=too then
  return 1
end if
data_sub[mode_sub][line][2]+=1
if data_sub[mode_sub][line][2]>=data_sub[mode_sub][line][4] then
  data_sub[mode_sub]=remove_line(data_sub[mode_sub],line)
  return 1
end if
end if
end if
return 0
end function

function while_do(object v1, object v2, atom com)
atom find
find=0
if com=1 then
  if atom(v1)=1 then
       find=1
      else
       find=2
     end if
  if find=1 then
    if v1=v2 then
      return 0
    else
      return 1
    end if
  elsif find=2 then
    if compare(v1,v2)=0 then
      return 0
    else
      return 1
    end if
  end if
elsif com=2 then
  if atom(v1)=1 then
       find=1
      else
       find=2
     end if
  if find=1 then
    if v1!=v2 then
      return 0
    else
      return 1
    end if
  elsif find=2 then
    if compare(v1,v2)!=0 then
      return 0
    else
      return 1
    end if
  end if
elsif com=3 then
  if atom(v1)=1 then
       find=1
      else
       find=2
     end if
  if find=1 then
    if v1<v2 then
      return 0
    else
      return 1
    end if
  elsif find=2 then
    err("in while satement tring to do a exspsion on a string that dont return a value")
  end if
elsif com=4 then
  if atom(v1)=1 then
       find=1
      else
       find=2
     end if
  if find=1 then
    if v1>v2 then
      return 0
    else
      return 1
    end if
  elsif find=2 then
    err("in while satement tring to do a exspsion on a string that dont return a value")
  end if
elsif com=5 then
  if atom(v1)=1 then
       find=1
      else
       find=2
     end if
  if find=1 then
    if v1<=v2 then
      return 0
    else
      return 1
    end if
  elsif find=2 then
    err("in while satement tring to do a exspsion on a string that dont return a value")
  end if
elsif com=6 then
  if atom(v1)=1 then
       find=1
      else
       find=2
     end if
  if find=1 then
    if v1>=v2 then
      return 0
    else
      return 1
    end if
  elsif find=2 then
    err("in while satement tring to do a exspsion on a string that dont return a value")
  end if
end if
return 0
end function

function if_do(object v1, object v2, atom com ,sequence name1, sequence name2)
atom find
find=0
if com=1 then
  if atom(v1)=1 then
       find=1
      else
       find=2
     end if
  if find=1 then
    if v1=v2 then
      goto(name1)
    else
      goto(name2)
    end if
  elsif find=2 then
    if compare(v1,v2)=0 then
      goto(name1)
    else
      goto(name2)
    end if
  end if
elsif com=2 then
  if atom(v1)=1 then
       find=1
      else
       find=2
     end if
  if find=1 then
    if v1!=v2 then
      goto(name1)
    else
      goto(name2)
    end if
  elsif find=2 then
    if compare(v1,v2)!=0 then
      goto(name1)
    else
      goto(name2)
    end if
  end if
elsif com=3 then
  if atom(v1)=1 then
       find=1
      else
       find=2
     end if
  if find=1 then
    if v1<v2 then
      goto(name1)
    else
      goto(name2)
    end if
  elsif find=2 then
     err("in if satement tring to do a exspsion on a string that dont return a value")
  end if
elsif com=4 then
  if atom(v1)=1 then
       find=1
      else
       find=2
     end if
  if find=1 then
    if v1>v2 then
      goto(name1)
    else
      goto(name2)
    end if
  elsif find=2 then
     err("in if satement tring to do a exspsion on a string that dont return a value")
  end if
elsif com=5 then
  if atom(v1)=1 then
       find=1
      else
       find=2
     end if
  if find=1 then
    if v1<=v2 then
      goto(name1)
    else
      goto(name2)
    end if
  elsif find=2 then
     err("in if satement tring to do a exspsion on a string that dont return a value")
  end if
elsif com=6 then
  if atom(v1)=1 then
       find=1
      else
       find=2
     end if
  if find=1 then
    if v1>=v2 then
      goto(name1)
    else
      goto(name2)
    end if
  elsif find=2 then
     err("in if satement tring to do a exspsion on a string that dont return a value")
  end if
end if
return 1
end function

procedure line(atom x, atom y, atom xx, atom yy, atom color)
draw_line(color,{{x,y},{xx,yy}})
end procedure

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

atom brush_color, brush_style, pen_color, font_color
brush_color=1
brush_style=1
pen_color=-1
font_color=-1

procedure get_key1(sequence name)
set_varbs(name,key2)
key2=0
end procedure

procedure get_pixel1(atom x, atom y, sequence name)
atom color
color=get_pixel({x,y})
set_varbs(name,color)
end procedure

procedure draw_text2(atom x, atom y, object string)
 if atom(string)=1 then
   draw_text({x,y},sprint(string),font_color,0,0)
 else
   draw_text({x,y},string,font_color,0,0)
 end if
end procedure

procedure graphic_mode(atom mode)
if mode=1 then
  if graphics_mode(13) then
  end if
  brush_color=1
  brush_style=1
  pen_color=-1
  font_color=-1
  bk_color(BLACK)
  clear_screen()
elsif mode=2 then
  if graphics_mode(18) then
  end if
  brush_color=1
  brush_style=1
  pen_color=-1
  font_color=-1
  bk_color(BLACK)
  clear_screen()
elsif mode=3 then
  if graphics_mode(258) then
  end if
  brush_color=1
  brush_style=1
  pen_color=-1
  font_color=-1
  bk_color(BLACK)
  clear_screen()
end if
end procedure

procedure date2(sequence name, atom v)
sequence now
now=date()
set_varbs(name,now[v])
end procedure

procedure time2(sequence name)
set_varbs(name,time())
end procedure

procedure string_copy(sequence name, sequence string, atom pos1, atom pos2)
set_varbs(name,string[pos1..pos2])
end procedure

procedure string_chr_at(sequence name, sequence string, atom pos1)
set_varbs(name,string[pos1..pos1])
end procedure

procedure string_length(sequence name, sequence string)
set_varbs(name,length(string))
end procedure

procedure floor2(sequence name, atom v)
set_varbs(name,floor(v))
end procedure

procedure random(sequence name, atom v)
set_varbs(name,rand(v))
end procedure

procedure string_insert(sequence name, sequence string, sequence string2, atom pos)
sequence temp
temp=""
temp=string[1..pos]
string=string[pos+1..length(string)]
temp&=string2&string
set_varbs(name,temp)
end procedure

procedure string_remove_chr(sequence name, sequence string, atom pos)
sequence temp
temp=""
temp=string[1..pos-1]
string=string[pos+1..length(string)]
temp&=string
set_varbs(name,temp)
end procedure

procedure string_remove(sequence name, sequence string, atom pos, atom pos2)
sequence temp
temp=""
temp=string[1..pos]
string=string[pos2+1..length(string)]
temp&=string
set_varbs(name,temp)
end procedure

procedure string_chr(sequence name, atom v)
set_varbs(name,{v})
end procedure

procedure string(sequence name, atom v)
set_varbs(name,sprint(v))
end procedure

procedure is_string(sequence name, object v)
 if atom(v)=1 then
   set_varbs(name,0)
  else
   set_varbs(name,1)
  end if
end procedure

procedure is_real(sequence name, object v)
 if atom(v)=1 then
   set_varbs(name,1)
  else
   set_varbs(name,0)
  end if
end procedure

procedure real(sequence name, sequence v)
sequence temp
temp=value(v)
set_varbs(name,temp[2])
end procedure

procedure string_width(sequence name, sequence v)
atom width
width=length(v)
width*=8
set_varbs(name,width)
end procedure

procedure file_text_open_read(sequence name, sequence file_name)
atom fn
sequence buffer
object line
buffer = {}
fn = open(file_name, "r")
set_varbs(name,fn)
if fn = -1 then
else
while 1 do
 line = gets(fn)
 if atom(line) then
  exit   
 end if
 buffer = append(buffer, line[1..length(line)-1])
end while
files=append(files,{fn,1,buffer,0})
end if
end procedure

procedure file_text_read_string(sequence name, atom id)
atom file_number, line
  for i=1 to length(files) do
     if files[i][1]=id then
       file_number=i
       line=files[i][2]
       exit
     end if
  end for
set_varbs(name,files[file_number][3][line])
end procedure

procedure file_text_read_real(sequence name, atom id)
atom file_number, line
sequence v
  for i=1 to length(files) do
     if files[i][1]=id then
       file_number=i
       line=files[i][2]
       exit
     end if
  end for
v=value(files[file_number][3][line])
if v[1]=GET_SUCCESS then
set_varbs(name,v[2])
else
 err("tring to read real its not a number its a string")
end if
end procedure

procedure file_text_readln(atom id)
atom file_number, line
  for i=1 to length(files) do
     if files[i][1]=id then
       file_number=i
       line=files[i][2]+1
       exit
     end if
  end for
  if line<=length(files[file_number][3]) then
    files[file_number][2]=line
  else
    files[file_number][4]=1
  end if
end procedure

procedure file_text_open_write(sequence name, sequence file_name)
atom fn
fn = open(file_name, "w")
if fn = -1 then
  err("file not found "&file_name)
end if
set_varbs(name,fn)
files=append(files,{fn,1,""})
end procedure

procedure file_text_open_append(sequence name, sequence file_name)
atom fn
fn = open(file_name, "a")
if fn = -1 then
  err("file not found "&file_name)
end if
set_varbs(name,fn)
files=append(files,{fn,1,""})
end procedure

procedure file_text_write_string(atom id, sequence string)
puts(id,string)
end procedure

procedure file_text_write_real(atom id, atom v)
puts(id,sprint(v))
end procedure

procedure file_text_writeln(atom id)
puts(id,"\n")
end procedure

procedure eof(sequence name,atom id)
atom file_number
  for i=1 to length(files) do
     if files[i][1]=id then
       file_number=i
       exit
     end if
  end for
if files[file_number][4]=1 or length(files[file_number][3])=0 then
  set_varbs(name,1)
else
  set_varbs(name,0)
end if
end procedure

procedure file_exsist(sequence name, sequence string)
atom fn
fn = open(string, "r")
if fn = -1 then
set_varbs(name,0)
else
set_varbs(name,1)
close(fn)
end if
end procedure

procedure file_close(atom id)
atom file_number, line
  for i=1 to length(files) do
     if files[i][1]=id then
       file_number=i
       line=files[i][2]+1
       exit
     end if
  end for
  files=remove_line(files,file_number)
  close(id)
end procedure

procedure next(atom line, sequence name)
 if mode_sub>0 then
   for j=1 to length(data_sub[mode_sub]) do
      if equal(data_sub[mode_sub][j][1],name)=1 then
        data_sub[mode_sub]=remove_line(data_sub[mode_sub],j)
        exit
      end if
   end for
   else
   for j=1 to length(data_info) do
      if equal(data_info[j][1],name)=1 then
        data_info[j]=remove_line(data_info[j],j)
        exit
      end if
   end for
   end if
   for i=line to length(code) do
      if equal(code[i][1],"goto")=1 then
        line_number=i+1
        exit
       end if
   end for
end procedure

procedure global2(sequence name)
  for i=1 to length(data_info) do
     if equal(name,data_info[i][1])=1 then
      data_info[i][5]=1
      exit
     end if
  end for
end procedure

procedure run_commands()
object val
sequence args,temp
sequence te
atom length1, length2, stop
atom x,y,xx,yy
x=0
val=""
y=0
xx=0
yy=0
stop=0
length1=0
length2=0
args={}
run_ok=0
execute_number+=1
  for i=line_number to length(code) do
--   if stop=1 then
     for j=1 to length(funs) do
        if equal(code[i][1],funs[j]) then
          for k=1 to length(code) do
           if equal(code[k][1],"fun")=1 then
              if equal(code[k][3],funs[j])=1 then
                -- i is the function name k is the function
                length1=length(code[k])-1
                length2=length(code[i])
                if length1=length2 then
                   varb_name=append(varb_name,code[i][2])
                   for l=3 to length(code[i])  do
                      args=append(args,varbs(code[i][l]))
                   end for
                   data_sub=append(data_sub,{})
                   mode=1
                   mode_sub+=1
                   --
                   if mode_sub>1 then
                     for m=1 to length(data_sub[mode_sub-1]) do
                        if data_sub[mode_sub-1][m][5]=1 then
                          data_sub[mode_sub]=append(data_sub[mode_sub],data_sub[mode_sub-1][m])
                        end if
                     end for
                   else
                   for l=1 to length(data_info) do
                      if data_info[l][5]=1 then
                        for m=1 to length(data_sub[mode_sub]) do
                           if equal(data_sub[mode_sub][m],data_info[l][1])=1 then
                             x=1
                           end if
                        end for
                        if x=0 then
                          data_sub[mode_sub]=append(data_sub[mode_sub],data_info[l])
                        end if
                      end if
                   end for
                   x=0
                   end if
                   --
                   for l=4 to length(code[k]) do
                      info_set(code[k][l],args[l-3])
                   end for
                   mode_line=append(mode_line,i+1)
                   goto(code[k][2])
                   stop=1
                   exit
                elsif length1>length2 then
                  err("function "&code[i][1]&" takes "&sprint(length1-2)&" arguments")
                elsif length1<length2 then
                  err("function "&code[i][1]&" takes "&sprint(length1-2)&" arguments trying to pass\n "&sprint(length2-2)&" arguments ")
                end if
              end if
            end if
           end for
        end if
     end for
     if equal(code[i][1],"mode2")=1 then
       err("exit function "&""&" with out return a value")
     end if
     if equal(code[i][1],"return")=1 then
        --
        if mode_sub>1 then
          for j=1 to length(data_sub[mode_sub]) do
             if data_sub[mode_sub][j][5]=1 then
               for k=1 to length(data_sub[mode_sub-1]) do
                  if equal(data_sub[mode_sub][j][1],data_sub[mode_sub-1][k][1])=1 then
                    data_sub[mode_sub-1][k]=data_sub[mode_sub][j]
                    exit
                  end if
               end for
             end if
          end for
        else
          for j=1 to length(data_sub[1]) do
            if data_sub[1][j][5]=1 then
              for k=1 to length(data_info) do
                 if equal(data_sub[1][j][1],data_info[k][1])=1 then
                   data_info[k]=data_sub[1][j]
                   exit
                 end if
              end for
            end if
          end for
        end if
        --
        val=varbs(code[i][2])
        data_sub[mode_sub]={}
        if length(mode_line)>0 then
        line_number=mode_line[length(mode_line)]
        mode_line=remove_line(mode_line,length(mode_line))
        end if
        mode_sub-=1
        if mode_sub=0 then
        mode=0
        end if
        set_varbs(varb_name[length(varb_name)],val)
        varb_name=remove_line(varb_name,length(varb_name))
        run_ok=1
        exit
     end if
     length1=0
     length2=0
     args={}
     for j=1 to length(subs) do
        if equal(code[i][1],subs[j]) then
          for k=1 to length(code) do
             if equal(code[k][1],"sub")=1 then
               if equal(code[k][3],subs[j])=1 then
                 length1=length(code[k])-3
                 length2=length(code[i])-1
                 if length1>0 then
                 if length1=length2 then
                   for l=2 to length(code[i])  do
                      args=append(args,varbs(code[i][l]))
                   end for
                   data_sub=append(data_sub,{})
                   mode=1
                   mode_sub+=1
                   for l=4 to length(code[k]) do
                      info_set(code[k][l],args[l-3])
                   end for
                   mode_line=append(mode_line,i+1)
                   --
                   if mode_sub>1 then
                     for m=1 to length(data_sub[mode_sub-1]) do
                        if data_sub[mode_sub-1][m][5]=1 then
                          data_sub[mode_sub]=append(data_sub[mode_sub],data_sub[mode_sub-1][m])
                        end if
                     end for
                   else
                   for l=1 to length(data_info) do
                      if data_info[l][5]=1 then
                        for m=1 to length(data_sub[mode_sub]) do
                           if equal(data_sub[mode_sub][m],data_info[l][1])=1 then
                             x=1
                           end if
                        end for
                        if x=0 then
                          data_sub[mode_sub]=append(data_sub[mode_sub],data_info[l])
                        end if
                      end if
                   end for
                   x=0
                   end if
                   --
                   goto(code[k][2])
                   stop=1
                   exit
                 else
                 err("sub "&subs[j]&" takes "&sprint(length1)&" arguments")
                 end if
                 else
                   mode=1
                   mode_line=append(mode_line,i+1)
                   data_sub=append(data_sub,{})
                   mode_sub+=1
                   --
                   if mode_sub>1 then
                     for m=1 to length(data_sub[mode_sub-1]) do
                        if data_sub[mode_sub-1][m][5]=1 then
                          data_sub[mode_sub]=append(data_sub[mode_sub],data_sub[mode_sub-1][m])
                        end if
                     end for
                   else
                   for l=1 to length(data_info) do
                      if data_info[l][5]=1 then
                        for m=1 to length(data_sub[mode_sub]) do
                           if equal(data_sub[mode_sub][m],data_info[l][1])=1 then
                             x=1
                           end if
                        end for
                        if x=0 then
                          data_sub[mode_sub]=append(data_sub[mode_sub],data_info[l])
                        end if
                      end if
                   end for
                   x=0
                   end if
                   --
                   goto(code[k][2])
                   stop=1
                   exit
                 end if
               end if
             end if
          end for
        end if
       if stop=1 then
         exit
       end if
     end for
     if stop=1 then
       run_ok=1
       exit
     end if
     if equal(code[i][1],"mode")=1 then
        --
        if mode_sub>1 then
          for j=1 to length(data_sub[mode_sub]) do
             if data_sub[mode_sub][j][5]=1 then
               for k=1 to length(data_sub[mode_sub-1]) do
                  if equal(data_sub[mode_sub][j][1],data_sub[mode_sub-1][k][1])=1 then
                    data_sub[mode_sub-1][k]=data_sub[mode_sub][j]
                    exit
                  end if
               end for
             end if
          end for
        else
          for j=1 to length(data_sub[1]) do
            if data_sub[1][j][5]=1 then
              for k=1 to length(data_info) do
                 if equal(data_sub[1][j][1],data_info[k][1])=1 then
                   data_info[k]=data_sub[1][j]
                   exit
                 end if
              end for
            end if
          end for
        end if
        --
        data_sub[mode_sub]={}
        if length(mode_line)>0 then
        line_number=mode_line[length(mode_line)]
        mode_line=remove_line(mode_line,length(mode_line))
        end if
        mode_sub-=1
        if mode_sub=0 then
        mode=0
        end if
        run_ok=1
        exit
     end if
--  end if
--file text system --
     if compare(code[i][1],"file_text_open_read")=0 then
       file_text_open_read(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"file_text_read_string")=0 then
       file_text_read_string(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"file_text_read_real")=0 then
       file_text_read_real(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"file_text_readln")=0 then
       file_text_readln(varbs(code[i][2]))
     end if
     if compare(code[i][1],"file_text_open_write")=0 then
       file_text_open_write(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"file_text_open_append")=0 then
       file_text_open_append(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"file_text_write_string")=0 then
       file_text_write_string(varbs(code[i][2]),varbs(code[i][3]))
     end if
     if compare(code[i][1],"file_text_write_real")=0 then
       file_text_write_real(varbs(code[i][2]),varbs(code[i][3]))
     end if
     if compare(code[i][1],"file_text_writeln")=0 then
       file_text_writeln(varbs(code[i][2]))
     end if
     if compare(code[i][1],"eof")=0 then
       eof(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"file_exsist")=0 then
       file_exsist(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"file_close")=0 then
       file_close(varbs(code[i][2]))
     end if
-- end file text 
-- string system --
     if compare(code[i][1],"string_chr")=0 then
       string_chr(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"string_width")=0 then
       string_width(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"is_real")=0 then
      is_real(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"real")=0 then
       real(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"string")=0 then
       string(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"is_string")=0 then
       is_string(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"string_remove_chr")=0 then
       string_remove_chr(code[i][2],varbs(code[i][3]),varbs(code[i][4]))
     end if
     if compare(code[i][1],"string_insert")=0 then
       string_insert(code[i][2],varbs(code[i][3]),varbs(code[i][4]),varbs(code[i][5]))
     end if
     if compare(code[i][1],"string_copy")=0 then
       string_copy(code[i][2],varbs(code[i][3]),varbs(code[i][4]),varbs(code[i][5]))
     end if
     if compare(code[i][1],"string_remove")=0 then
       string_remove(code[i][2],varbs(code[i][3]),varbs(code[i][4]),varbs(code[i][5]))
     end if

     if compare(code[i][1],"string_chr_at")=0 then
       string_chr_at(code[i][2],varbs(code[i][3]),varbs(code[i][4]))
     end if
     if compare(code[i][1],"string_length")=0 then
       string_length(code[i][2],varbs(code[i][3]))
     end if
-- end string --
-- mise system
     if compare(code[i][1],"date")=0 then
       date2(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"time")=0 then
       time2(code[i][2])
     end if
-- end mise -- 
-- input system --
     if compare(code[i][1],"get_key")=0 then
       get_key1(code[i][2])
     end if
-- end input --
-- graphics system --
     if compare(code[i][1],"draw_text")=0 then
       draw_text2(varbs(code[i][2]),varbs(code[i][3]),varbs(code[i][4]))
     end if
     if compare(code[i][1],"get_pixel")=0 then
       get_pixel1(varbs(code[i][3]),varbs(code[i][4]),code[i][2])
     end if
     if compare(code[i][1],"cls")=0 then
       clear_screen()
     end if
     if compare(code[i][1],"graphics_mode")=0 then
       graphic_mode(varbs(code[i][2]))
     end if
     if compare(code[i][1],"bk_color")=0 then
       bk_color(varbs(code[i][2]))
     end if
     if compare(code[i][1],"brush_color")=0 then
       brush_color=floor(varbs(code[i][2]))
     end if
     if compare(code[i][1],"pen_color")=0 then
       pen_color=floor(varbs(code[i][2]))
     end if
     if compare(code[i][1],"font_color")=0 then
       font_color=floor(varbs(code[i][2]))
     end if
     if compare(code[i][1],"brush_style")=0 then
       if floor(varbs(code[i][2]))>1 then
         err("tring to set brush style to value higher than one")
       end if
       brush_style=floor(varbs(code[i][2]))
     end if
     if compare(code[i][1],"draw_cir")=0 then
       -- fats as it can go
       x=varbs(code[i][2])
       xx=varbs(code[i][4])
       y=varbs(code[i][3])
       yy=varbs(code[i][5])
        ellipse(brush_color,brush_style,{x,y} ,{xx,yy})
        ellipse(pen_color,0,{x,y} ,{xx,yy})
     end if
     if compare(code[i][1],"draw_rectangle")=0 then
       -- fats as it can go
       x=varbs(code[i][2])
       xx=varbs(code[i][4])
       y=varbs(code[i][3])
       yy=varbs(code[i][5])
       polygon(brush_color,brush_style, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
       polygon(pen_color,0, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
     end if
     if compare(code[i][1],"draw_line")=0 then
       line(varbs(code[i][2]),varbs(code[i][3]),varbs(code[i][4]),varbs(code[i][5]),pen_color)
     end if
     if compare(code[i][1],"draw_pixel")=0 then
        pixel(pen_color,{varbs(code[i][2]), varbs(code[i][3])})
     end if
-- end graphics ---
     -- main program
-- main program --
     if equal(code[i][1],"info_set")=1 then
       info_set(code[i][2],varbs(code[i][3]))
     end if
     if equal(code[i][1],"info_plus")=1 then
       info_plus(code[i][2],varbs(code[i][3]))
     end if
     if equal(code[i][1],"info_min")=1 then
       info_min(code[i][2],varbs(code[i][3]))
     end if
     if equal(code[i][1],"info_set_array")=1 then
       info_set_array(code[i][2],varbs(code[i][3]),varbs(code[i][4]))
     end if
     if equal(code[i][1],"info_plus_array")=1 then
       info_plus_array(code[i][2],varbs(code[i][3]),varbs(code[i][4]))
     end if
     if equal(code[i][1],"info_min_array")=1 then
       info_min_array(code[i][2],varbs(code[i][3]),varbs(code[i][4]))
     end if
     if equal(code[i][1],"for")=1 then
       temp=info_exsist(code[i][2])
       if temp[1]=0 then
         if for_loop(code[i][2],varbs(code[i][3]),varbs(code[i][4]))=1 then
           goto(code[i][5])
           run_ok=1
           exit
         end if
       else
         if for_loop(code[i][2],0,0)=1 then
           goto(code[i][5])
           run_ok=1
           exit
         end if
       end if
     end if
     if compare(code[i][1],"exit")=0 then
       next(i,code[i][2]) 
       run_ok=1
       exit
     end if
     if equal(code[i][1],"while")=1 then
       if while_do(varbs(code[i][2]),varbs(code[i][3]),code[i][4])=1 then
         goto(code[i][5])
         run_ok=1
         exit
       end if
     end if
     if compare(code[i][1],"if")=0 then
       if if_do(varbs(code[i][2]),varbs(code[i][3]),code[i][4],code[i][5],code[i][6])=1 then
         run_ok=1
         exit
       end if
     end if
     if compare(code[i][1],"goto")=0 then
       goto(code[i][2])
       run_ok=1
       exit
     end if
     if compare(code[i][1],"global")=0 then
       global2(code[i][2])
     end if
     if compare(code[i][1],"sleep")=0 then
       sleep(varbs(code[i][2]))
     end if
     if compare(code[i][1],"floor")=0 then
       floor2(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"random")=0 then
       random(code[i][2],varbs(code[i][3]))
     end if
     if compare(code[i][1],"abort")=0 then
       file_data={}
       files={}
       data_sub={}
       goto_info={}
       subs={}
       file_code()
       file_close_all()
       varb_name={}
       funs={}
       font_index={}
       crash_message("Program Made By Gareth Mc Daid CopyRights 2005\nProgram End\n")
       ?te
       abort(0)
     end if
   end for
end procedure

procedure check_file()
sequence temp
temp=""
  for i=1 to length(file_data) do
    for j=1 to length(file_data[i]) do
       if file_data[i][j]='-' and file_data[i][j+1]='-' then
         exit
       end if
       if file_data[i][j]='-' and file_data[i][j+1]!='=' then
         for k=j to length(file_data[i]) do
           if file_data[i][k]='=' then
             err("the = sign is to far a way from - \n"&file_data[i])
           end if
         end for
       end if
       if file_data[i][j]='<' and file_data[i][j+1]!='=' then
         for k=j to length(file_data[i]) do
           if file_data[i][k]='=' then
             err("the = sign is to far a way from < \n"&file_data[i])
           end if
         end for
       end if
       if file_data[i][j]='>' and file_data[i][j+1]!='=' then
         for k=j to length(file_data[i]) do
           if file_data[i][k]='=' then
             err("the = sign is to far a way from > \n"&file_data[i])
           end if
         end for
       end if
       if file_data[i][j]='!' and file_data[i][j+1]!='=' then
         err("the = sign is to far a way from ! \n"&file_data[i])
       end if
       if file_data[i][j]='+' and file_data[i][j+1]!='=' then
         err("the = sign is to far a way from + \n"&file_data[i])
       end if
       if file_data[i][j]='[' and file_data[i][j-1]=32 then
         err("the [] are to far a way from the array \n"&file_data[i])
       end if
    end for
  end for
end procedure

--
procedure check_all_commands_code()
sequence list
sequence temp
atom ok
list=
{
"draw_text",
"draw_rectangle",
"draw_pixel",
"draw_cir",
"draw_line",
"mode",
"for",
"if",
"exit",
"while",
"brush_color",
"graphics_mode",
"font_color",
"lable",
"brush_style",
"pen_color",
"bk_color",
"time",
"date",
"goto",
"sub",
"cls",
"info_set",
"info_set_array",
"info_plus",
"info_min",
"info_plus_array",
"info_min_array",
"get_pixel",
"get_key",
"string_length",
"string_chr",
"string_chr_at",
"string_insert",
"string_remove_chr",
"string_copy",
"file_text_open_read",
"file_text_read_string",
"file_text_read_real",
"eof",
"file_text_readln",
"file_text_open_write",
"file_text_open_append",
"file_text_write_string",
"file_text_write_real",
"file_text_writeln",
"file_close",
"fun",
"mode2",
"return",
"abort",
"string_width",
"real",
"sleep",
"floor",
"random",
"string",
"file_exsist",
"is_string",
"is_real",
"global",
"string_remove"
}
temp=""
ok=0
  for i=1 to length(code) do
    ok=0
    if equal(code[i][1],"sub")=1 then
      temp=append(temp,code[i][3])
      for j=1 to length(list) do
         if equal(code[i][3],list[j])=1 then
           err("sub "&code[i][3]&" is a in builed command")
         end if
      end for
    end if
    if equal(code[i][1],"fun")=1 then
      temp=append(temp,code[i][3])
      for j=1 to length(list) do
         if equal(code[i][3],list[j])=1 then
           err("function "&code[i][3]&" is a in builed command")
         end if
      end for
    end if
    for j=1 to length(list) do
      if equal(code[i][1],list[j])=1 then
        ok=1
        exit
      end if
    end for
    for j=1 to length(temp) do
      if equal(code[i][1],temp[j])=1 then
        ok=1
        exit
      end if
    end for
    if ok=0 then
      for j=1 to length(subs) do
         if equal(code[i][1],subs[j])=1 then
           err("sub "&code[i][1]&" has not bin found ")
         end if
      end for
      for j=1 to length(funs) do
         if equal(code[i][1],funs[j])=1 then
           err("function "&code[i][1]&" has not bin found ")
         end if
      end for
        err("Command "&code[i][1]&" has not bin found ")
    end if
  end for
  temp={}
  for i=1 to length(code) do
     for j=1 to length(code[i]) do
        if atom(code[i][j])=0 then
        if length(code[i][j])=0 then
          temp=append(temp,{i,j})
        end if
        end if
     end for
  end for
  for i=1 to length(temp) do
     code[temp[i][1]]=remove_line(code[temp[i][1]],temp[i][2])
  end for
end procedure
--
--
--
file_data=file_read("lib")
file_data&=file_read("2.txt")
--
check_file()
--
make_code()
--
make_for_loop()
--
make_if_code()
--
make_while_code()
--
make_sub_code()
--
make_fun_code()
--
check_all_commands_code()
--
--
--
for i=1 to length(code) do
 if compare(code[i][1],"lable")=0 then
 goto_info=append(goto_info,{code[i][2],i})
 end if
end for
--
--
check_code()
--
--
--
while 1 do
key=get_key()
if key != -1 then
if close_ok=1 then
 if key=27 then
  exit
 end if
end if
key2=key
end if
if run_ok=1 then
  run_commands()
end if
if debug_ok=1 then
position(2,70)
?execute_number
position(1,75)
?time()
end if
end while
sequence te
file_data={}
files={}
data_sub={}
goto_info={}
subs={}
file_code()
file_close_all()
varb_name={}
funs={}
font_index={}
crash_message("Program Made By Gareth Mc Daid CopyRights 2005\nProgram End\n")
?te
