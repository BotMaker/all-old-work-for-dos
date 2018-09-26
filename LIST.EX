without type_check
include graphics.e
include file.e
include get.e
include font.e

if graphics_mode(18) then
end if

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

function merge_sort(sequence x)
integer n, mid
sequence merged, a, b
n = length(x)
if n = 0 or n = 1 then
return x  -- trivial case
end if
mid = floor(n/2)
a = merge_sort(x[1..mid])       -- sort first half of x
b = merge_sort(x[mid+1..n])     -- sort second half of x
merged = {}
while length(a) > 0 and length(b) > 0 do
if compare(a[1], b[1]) < 0 then
merged = append(merged, a[1])
a = a[2..length(a)]
else
merged = append(merged, b[1])
b = b[2..length(b)]
end if
end while
return merged & a & b  -- merged data plus leftovers
end function

sequence drive, d, line
atom test, key
drive="c:\\euphoria\\"
d=""
line=""
d = dir(drive)
for i=1 to length(d) do
  test= compare(d[i][2],"d") 
  if test != 0 then
   line= append(line,d[i])
  end if
end for
sequence temp
temp=""

for i=1 to length(line) do
   for j=1 to length(line[i][1]) do
      if line[i][1][j]='.' then
        if compare(line[i][1][j..length(line[i][1])],".EX")=0 then
          temp=append(temp,line[i])
        end if
      end if
   end for
end for
line=temp
line=merge_sort(line)

atom color, number, max_number, exit_code
color=0
number=1
max_number=length(line)
procedure work()

for i=1 to length(line) do
  color=0
  if i=number then
    color=1
  end if
  draw_text({1,16*i},line[i][1],WHITE,color,0)
  position(2,20)
  puts(1,"file size")
  position(2,32)
  puts(1,"                ")
  position(2,32)
  print(1,line[number][3])

end for

end procedure
work()
while 1 do
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
 if key=328 and number>1 then
   number-=1
   work()
 end if
 if key=336 and number<max_number then
   number+=1
   work()
 end if
 if key=13 then
   exit_code = system_exec("ex.exe "&line[number][1], 0)
   work()
 end if
end if
end while

