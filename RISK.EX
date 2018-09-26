without type_check
without warning
include get.e
include machine.e
include graphics.e
include database.e
include font.e
include mouse2.e
global atom mode_number
global sequence mix_info, lib_info
global atom mix_number,lib_number
global sequence cmd, file_data,file_name
global sequence lib_name_files, subs_info,funs_info
global atom code_num
constant version="0.3"
mode_number=1
mix_number=1
lib_number=1
mix_info={{}}
lib_info={{}}
cmd=command_line()
file_data={}
subs_info={}
funs_info={}
code_num=0
lib_name_files={}

include lib1.e
include lib2.e
include lib3.e
crash_file("code3.err")

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
   buffer = append(buffer, "dead_line_gareth_mc_daid ")
 elsif can=1 then
   line=line[1..length(line)-1]
   line&={32}
   buffer = append(buffer, line)
 end if
end while
close(fn)
return buffer
end function

global procedure add_info(sequence key, sequence data)
atom f
f = db_find_key(key)
if f >= 1 then
db_replace_data(f, data)
else
if db_insert(key, data) != DB_OK then
end if
end if
end procedure

if db_open("a", DB_LOCK_NO) != DB_OK then
if db_create("a", DB_LOCK_NO) != DB_OK then
end if
if db_create_table("data") != DB_OK then
end if
end if
if db_select_table("data") != DB_OK then
end if

global procedure file_code()
atom fn
fn = open("code.err", "w")
if fn = -1 then
end if
for i=1 to length(code[code_num]) do
   for j=1 to length(code[code_num][i]) do
      puts(fn,code[code_num][i][j]&" ")
   end for
   puts(fn,"\n")
end for
close(fn)
end procedure

include lib4.e

function file_exsist(sequence file_name)
atom fn
fn = open(file_name, "r")
if fn = -1 then
return 0
else
close(fn)
return 1
end if
end function

procedure make_lib()
-- get all lib files in folder and make code
sequence d, path,line
 atom test
line={}
for i=length(cmd[1]) to 1 by -1 do
   if cmd[1][i]='\\' then
     path=cmd[1][1..i]
     exit
   end if
end for
  d = dir(path)
  for i=1 to length(d) do
  test= compare(d[i][2],"d") 
  if test!=0 then
  line=append(line,d[i][1])
  end if
  end for
  d={}
  for i=1 to length(line) do
    for j=1 to length(line[i]) do
       if line[i][j]='.' then
         if equal(line[i][j..length(line[i])],".LIB")=1 then
           file_data=file_read(path&line[i])
           file_name=line[i]
           lib_name_files=append(lib_name_files,path&line[i])
         end if
       exit
       end if
    end for
  end for
end procedure
 
make_lib()

if length(cmd)>=3 then
  if file_exsist(cmd[3])=1 then
    file_data=file_read(cmd[3])
  else
    puts(1,"Can't open "&cmd[3]&"\n")
    abort(0)
  end if
else
  puts(1,"Risk Programing Language "&version&" for 32-Bit DOS.\n")
  puts(1,"Copyrights (c) -i@s@ft S@ft-are 2005 (z..c..s)\n")
  puts(1,"Programing By Gareth Mc Daid All rights reserved\n")
  puts(1,"\n\n")
  file_name= prompt_string("file name to be execute? ")
  if file_exsist(file_name)=1 then
    file_data=file_read(file_name)
  else
    puts(1,"Can't open "&file_name&"\n")
    abort(0)
  end if
end if
if length(cmd)>2 then
file_name=cmd[3]
end if
cmd=""

make_code()

procedure run_over()
atom num, temp
temp=code_num
num=1
code_num=1
mode_number=2
while 1 do
mouse()
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
key2=key
end if
  if num<temp then
   if run_ok=1 then
     run_commands()
   else
     run_ok=1
     num+=1
     code_num+=1
     line_number=1
   end if
 else
   line_number=1
   code_num=temp
   run_ok=1
   exit
  end if
end while
end procedure

run_over()

while 1 do
mouse()
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
key2=key
end if
if run_ok=1 then
  run_commands()
else
exit
end if
end while

font_index={}
file_data={}
--atom a
atom fn
add_info("code",code)
add_info("men",{lib_info,mix_info})
fn = open("code2.err", "w")
db_dump(fn, 0)
file_code()
mode_number=1
mix_number=1
lib_number=1
mix_info={{}}
lib_info={{}}
cmd=command_line()
file_data={}
subs_info={}
procedure_list={}
function_list={}
command_list={}
funs_info={}
code_num=0
statement_list={}
cmd={}
goto_info={}
lib_name_files={}
--crash_message("Risk Programing Language "&version&" Made By Gareth Mc Daid.\n")
code={}
--?a
