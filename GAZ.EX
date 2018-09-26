--monday 10 oct 2005 18:53:23
--version 0

without type_check
global atom key
include engine.e
screen2={}
new_screen(-1)
if graphics_mode(18) then
end if

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
fn = open(string, "r")
if fn = -1 then
end if
buffer = {}
while 1 do
line = gets(fn)
if atom(line) then
exit   
end if
buffer = append(buffer, line[1..length(line)-1])
end while
return buffer
end function

atom button1
button1=create_ex({"button","Encrypt File",69,59})
atom button2
button2=create_ex({"button","Decrypt File",70,89})
atom lable1
lable1=create_ex({"lable",49,31,"Encryption Software"})
atom lable2
lable2=create_ex({"lable",70,118,"Encryption Key"})
atom textbox1
textbox1=create_ex({"textbox",77,142,100})

procedure close2()
  clear_screen()
  abort(0)
end procedure

function encryption(sequence code,sequence string)
atom key,number
number=0
code=value(code)
key=code[2]
for i=1 to length(string) do
   for j=1 to length(string[i]) do
      string[i][j]+=key+number
      number+=1
      if number>22 then
        number=0
      end if
   end for
end for
return string
end function

function dncryption(sequence code,sequence string)
atom key,number
number=0
code=value(code)
key=code[2]
for i=1 to length(string) do
   for j=1 to length(string[i]) do
      string[i][j]-=key+number
      number+=1
      if number>22 then
        number=0
      end if
   end for
end for
return string
end function

sequence file_name,temp
file_name=""
temp=""

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
  file_name=get_filename("")
    if length(file_name)>0 then
      if length(get_text({"textbox",textbox1}))>0 then
        temp=value(get_text({"textbox",textbox1}))
        if temp[2]>0 and temp[2]<21 then
          write_file(file_name,encryption(get_text({"textbox",textbox1}),read_file(file_name)))
          show_msg("File Encryption Ok","About Encryption")
        else
          show_msg("Enter A Number 1 to 20","About Encryption")
        end if
      else
      show_msg("Enter A Encryption Key","About Encryption")
      end if
    end if
end if
if on_click({"button",button2})=1 then
  file_name=get_filename("")
    if length(file_name)>0 then
      if length(get_text({"textbox",textbox1}))>0 then
        temp=value(get_text({"textbox",textbox1}))
        if temp[2]>0 and temp[2]<21 then
          write_file(file_name,dncryption(get_text({"textbox",textbox1}),read_file(file_name)))
          show_msg("File Dncryption Ok","About Encryption")
        else
          show_msg("Enter A Number 1 to 20","About Encryption")
        end if
      else
      show_msg("Enter A Dncryption Key","About Encryption")
      end if
    end if
end if
end while
