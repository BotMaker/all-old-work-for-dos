include machine.e
include graphics.e
include file.e
include get.e

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

procedure write_file(sequence string, sequence string1)
integer fn
fn = open(string, "wb")
 if fn = -1 then
  end if
for i=1 to length(string1) do
puts(fn,string1[i])
end for
close(fn)
end procedure
sequence file
file=read_file("a:\\io.sys")
write_file("c:\\io.sys",file)
