without type_check
include graphics.e
include mouse2.e
include font.e
include file.e

constant FILEVIEW_X=1
constant FILEVIEW_Y=2
constant FILEVIEW_WIDTH=3
constant FILEVIEW_HEIGHT=4
constant FILEVIEW_FILES=5
constant FILEVIEW_VARBS=6
constant FILEVIEW_PATH=7
constant FILEVIEW_INIT=8
constant FILEVIEW_DRAW=9
constant FILEVIEW_MODE=10
constant FILEVIEW_FILE_WIDTH=11
constant FILEVIEW_FILE_HEIGHT=12
constant FILEVIEW_NUMBER1=13
constant FILEVIEW_NUMBER2=14
constant FILEVIEW_SEL=15
constant FILEVIEW_TIMER1=16
constant FILEVIEW_CLICK_ON=17
constant FILEVIEW_SEL_NAME=18
constant FILEVIEW_PRESSED_LEFT=19
constant FILEVIEW_PRESSED_RIGHT=20
constant FILEVIEW_TEMP_MX=21
constant FILEVIEW_TEMP_MY=22
constant FILEVIEW_COMMAND1=23
constant FILEVIEW_COMMAND2=24
constant FILEVIEW_COMMAND3=25
constant FILEVIEW_WINDOW_ID=26
constant FILEVIEW_ID=27

atom key, get_button, draw2
draw2=0
get_button=0
object bitmap
bitmap=read_bitmap("exe.bmp")

if graphics_mode(18) then
end if

procedure line(atom x, atom y, atom xx, atom yy, atom color)
draw_line(color,{{x,y},{xx,yy}})
end procedure

function gaz_sort(sequence x)
integer n, mid
sequence merged, a, b
n = length(x)
if n = 0 or n = 1 then
return x  -- trivial case
end if
mid = floor(n/2)
a = gaz_sort(x[1..mid])       -- sort first half of x
b = gaz_sort(x[mid+1..n])     -- sort second half of x
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

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
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

sequence fileview_info
atom fileview_number
fileview_number=1
fileview_info={}

procedure draw_all()
rectangle(1,1,800,600,-1,1)
for i=1 to length(fileview_info) do
   fileview_info[i][FILEVIEW_DRAW]=1
end for
end procedure

function over_fileview(atom xx, atom yy,atom id)
atom x,y,width,mode,height
mode=0
  for i=1 to length(fileview_info) do
  x=fileview_info[i][FILEVIEW_X]
  y=fileview_info[i][FILEVIEW_Y]
  width=fileview_info[i][FILEVIEW_WIDTH]
  height=fileview_info[i][FILEVIEW_HEIGHT]
  if id!=fileview_info[i][FILEVIEW_ID] then
    if xx>x and xx<x+width and yy>y and yy<y+height then
      return 1
    end if
  end if
  end for
return 0
end function

function over_fileview_self(atom xx, atom yy,atom id)
atom x,y,width,mode,height
mode=0
  for i=1 to length(fileview_info) do
  x=fileview_info[i][FILEVIEW_X]
  y=fileview_info[i][FILEVIEW_Y]
  width=fileview_info[i][FILEVIEW_WIDTH]
  height=fileview_info[i][FILEVIEW_HEIGHT]
  if id=fileview_info[i][FILEVIEW_ID] then
    if xx>x and xx<x+width and yy>y and yy<y+height then
      return 1
    end if
  end if
  end for
return 0
end function

function get_over_path(atom xx, atom yy,atom id)
atom x,y,width,mode,height
mode=0
  for i=1 to length(fileview_info) do
  x=fileview_info[i][FILEVIEW_X]
  y=fileview_info[i][FILEVIEW_Y]
  width=fileview_info[i][FILEVIEW_WIDTH]
  height=fileview_info[i][FILEVIEW_HEIGHT]
  if id!=fileview_info[i][FILEVIEW_ID] then
    if xx>x and xx<x+width and yy>y and yy<y+height then
      return fileview_info[i][FILEVIEW_PATH]
    end if
  end if
  end for
end function

function over_fileview_dir(atom xx, atom yy)
integer x,y,width,height,draw,mode,init
integer file_width,file_height,number1,number2,sel
integer pressed_left,pressed_right
atom temp_mx,temp_my,timer1
sequence files,varbs,path,click_on,sel_name
   for i=1 to length(fileview_info) do
     x=fileview_info[i][FILEVIEW_X]
     y=fileview_info[i][FILEVIEW_Y]
     width=fileview_info[i][FILEVIEW_WIDTH]
     height=fileview_info[i][FILEVIEW_HEIGHT]
     files=fileview_info[i][FILEVIEW_FILES]
     varbs=fileview_info[i][FILEVIEW_VARBS]
     path=fileview_info[i][FILEVIEW_PATH]
     init=fileview_info[i][FILEVIEW_INIT]
     draw=fileview_info[i][FILEVIEW_DRAW]
     mode=fileview_info[i][FILEVIEW_MODE]
     file_width=fileview_info[i][FILEVIEW_FILE_WIDTH]
     file_height=fileview_info[i][FILEVIEW_FILE_HEIGHT]
     number1=fileview_info[i][FILEVIEW_NUMBER1]
     number2=fileview_info[i][FILEVIEW_NUMBER2]
     sel=fileview_info[i][FILEVIEW_SEL]
     timer1=fileview_info[i][FILEVIEW_TIMER1]
     click_on=fileview_info[i][FILEVIEW_CLICK_ON]
     sel_name=fileview_info[i][FILEVIEW_SEL_NAME]
     pressed_left=fileview_info[i][FILEVIEW_PRESSED_LEFT]
     pressed_right=fileview_info[i][FILEVIEW_PRESSED_RIGHT]
     temp_mx=fileview_info[i][FILEVIEW_TEMP_MX]
     temp_my=fileview_info[i][FILEVIEW_TEMP_MY]
     for j=number1 to length(varbs)-number2 do
        if xx>varbs[j][1]+25 and xx<varbs[j][1]+50 and yy>varbs[j-number1+1][2] and yy<varbs[j-number1+1][2]+25 then
          for k=1 to length(varbs[j][3]) do
             if varbs[j][3][k]='.' then
               if compare(varbs[j][3][k..length(varbs[j][3])],".F")=0 then
                 return varbs[j][3][1..k-1]
               end if
             end if
          end for
        end if
     end for
   end for
return ""
end function

procedure fileview()
integer x,y,width,height,draw,mode,init,id
integer file_width,file_height,number1,number2,sel
integer pressed_left,pressed_right,pos
integer temp_x,temp_y
atom temp_mx,temp_my,timer1,t0
sequence files,varbs,path,click_on,sel_name,temp
sequence command1,command2,command3
   for i=1 to length(fileview_info) do
     x=fileview_info[i][FILEVIEW_X]
     y=fileview_info[i][FILEVIEW_Y]
     width=fileview_info[i][FILEVIEW_WIDTH]
     height=fileview_info[i][FILEVIEW_HEIGHT]
     files=fileview_info[i][FILEVIEW_FILES]
     varbs=fileview_info[i][FILEVIEW_VARBS]
     path=fileview_info[i][FILEVIEW_PATH]
     init=fileview_info[i][FILEVIEW_INIT]
     draw=fileview_info[i][FILEVIEW_DRAW]
     mode=fileview_info[i][FILEVIEW_MODE]
     file_width=fileview_info[i][FILEVIEW_FILE_WIDTH]
     file_height=fileview_info[i][FILEVIEW_FILE_HEIGHT]
     number1=fileview_info[i][FILEVIEW_NUMBER1]
     number2=fileview_info[i][FILEVIEW_NUMBER2]
     sel=fileview_info[i][FILEVIEW_SEL]
     timer1=fileview_info[i][FILEVIEW_TIMER1]
     click_on=fileview_info[i][FILEVIEW_CLICK_ON]
     sel_name=fileview_info[i][FILEVIEW_SEL_NAME]
     pressed_left=fileview_info[i][FILEVIEW_PRESSED_LEFT]
     pressed_right=fileview_info[i][FILEVIEW_PRESSED_RIGHT]
     temp_mx=fileview_info[i][FILEVIEW_TEMP_MX]
     temp_my=fileview_info[i][FILEVIEW_TEMP_MY]
     command1=fileview_info[i][FILEVIEW_COMMAND1]
     command2=fileview_info[i][FILEVIEW_COMMAND2]
     command3=fileview_info[i][FILEVIEW_COMMAND3]
     pos=fileview_info[i][26]

     if init=1 then
       file_width=width/100
       file_height=height/50
       temp_x=0
       temp_y=0
       for j=1 to length(files) do
          varbs=append(varbs,{x+4+temp_x,y+4+temp_y,files[j]})
          temp_x+=100
          if temp_x>=width then
            temp_x=0
            temp_y+=50
          end if
       end for
       if length(varbs)>file_width*file_height then
         number2=length(varbs)-file_height*file_width
       end if
       init=0
     end if

     if mouse_x>x+width+6 and mouse_x<x+width+6+10 and mouse_y>y and mouse_y<y+12 and mouse_button=mb_left then
       if pos>0 then
         number1-=pos
         number2+=pos
         pos=0
         draw=1
       else
         if number1>1 then
           number1-=file_width
           number2+=file_width
           draw=1
         end if
       end if
       mouse_button=0
     end if

     if mouse_x>x+width+6 and mouse_x<x+width+6+10 and mouse_y>y+height+6-10 and mouse_y<y+height+6 and mouse_button=mb_left then
       if number1<length(varbs)-((file_height*file_width)+file_width) then
         number1+=file_width
         number2-=file_width
         draw=1
       else
         if number2>0 then
           pos=number2
           number1+=number2
           number2=0
           draw=1
         end if
      end if
      mouse_button=0
     end if

     for j=number1 to length(varbs)-number2 do
        if mouse_x>varbs[j][1]+25 and mouse_x<varbs[j][1]+50 and mouse_y>varbs[j-number1+1][2] and mouse_y<varbs[j-number1+1][2]+25 and mouse_button=mb_left then
          t0=time()
          if timer1>t0 then
            click_on=varbs[j][3]
          else
          timer1=time()+.30
          end if
          if timer1=0 then
          timer1=time()+.30
          end if
          if j!=sel then
          sel=j
          draw=1
          sel_name=varbs[j][3]
          end if
          mouse_button=0
          pressed_left=1
          temp_mx=mouse_x/5
          temp_my=mouse_y/5
        end if
     end for

     if get_button=3 and pressed_left>0 then
       if over_fileview(mouse_x,mouse_y,fileview_info[i][FILEVIEW_ID])=1 then
          temp=over_fileview_dir(mouse_x,mouse_y)
          if length(temp)>0 then
            -- over a fileview and a dir
            command1=get_over_path(mouse_x,mouse_y,fileview_info[i][FILEVIEW_ID])&" "&temp&" "&varbs[sel][3]
          else
            -- over a fileview
            command2=get_over_path(mouse_x,mouse_y,fileview_info[i][FILEVIEW_ID])&" "&varbs[sel][3]
          end if
       else
         if over_fileview_self(mouse_x,mouse_y,fileview_info[i][FILEVIEW_ID])=1 then
           temp=over_fileview_dir(mouse_x,mouse_y)
           if length(temp)>0 and compare(varbs[sel][3],temp&".F")!=0 then
             -- over self and over a dir
            command3=path&" "&temp&" "&varbs[sel][3]
           end if
         end if
       end if
       pressed_left=0
       draw=1
     end if

     if pressed_left=1 then
       if temp_mx!=mouse_x/5 and temp_my!=mouse_y/5 then
         pressed_left=2
         temp_mx=mouse_x
         temp_my=mouse_y
       end if
     end if

     if pressed_left=2 then
       if temp_mx!=mouse_x and temp_my!=mouse_y then
         temp_mx=mouse_x
         temp_my=mouse_y
         draw2=1
       end if
     end if

     if draw=1 then
       rectangle(x,y,x+width+6,y+height+6,-1,1)
       rectangle(x,y,x+width+6,y+height+6,0,0)
       rectangle(x+width+6,y,x+width+6+12,y+height,-1,1)
       rectangle(x+width+6,y,x+width+6+12,y+height,0,0)
       --up
       rectangle(x+width+6,y,x+width+6+10,y+12,7,1)
       rectangle(x+width+6,y,x+width+6+11,y+13,0,0)
       line(x+width+6+5,y+1,x+width+6+5,y+1,0)
       line(x+width+6+4,y+2,x+width+6+6,y+2,0)
       line(x+width+6+3,y+3,x+width+6+7,y+3,0)
       line(x+width+6+2,y+4,x+width+6+8,y+4,0)
       --down
        rectangle(x+width+6,y+height+6,x+width+6+10,y+height+6-12,7,1)
        rectangle(x+width+6,y+height+6,x+width+6+11,y+height+6-13,0,0)
        line(x+width+6+2,y+height+6-4,x+width+6+8,y+height+6-4,0)
        line(x+width+6+3,y+height+6-3,x+width+6+7,y+height+6-3,0)
        line(x+width+6+4,y+height+6-2,x+width+6+6,y+height+6-2,0)
        line(x+width+6+5,y+height+6-1,x+width+6+5,y+height+6-1,0)
       for j=number1 to length(varbs)-number2 do
          if sel=j and pressed_left<=1 then
--         rectangle(varbs[j][1],varbs[j-number1+1][2],varbs[j][1]+100,varbs[j-number1+1][2]+50,RED,1)
          draw_text({varbs[j][1],varbs[j-number1+1][2]+30},varbs[j][3],0,RED,0)
          display_image({varbs[j][1]+25,varbs[j-number1+1][2]},bitmap[2])
          elsif sel!=j then
          rectangle(varbs[j][1],varbs[j-number1+1][2],varbs[j][1]+100,varbs[j-number1+1][2]+50,-1,1)
          draw_text({varbs[j][1],varbs[j-number1+1][2]+30},varbs[j][3],0,-1,0)
          display_image({varbs[j][1]+25,varbs[j-number1+1][2]},bitmap[2])
          end if
       end for
       if pressed_left=2 then
         draw_text({mouse_x,mouse_y+30},varbs[sel][3],0,RED,0)
         display_image({mouse_x+25,mouse_y},bitmap[2])
       end if
       draw=0
     end if

     fileview_info[i][FILEVIEW_VARBS]=varbs
     fileview_info[i][FILEVIEW_INIT]=init
     fileview_info[i][FILEVIEW_DRAW]=draw
     fileview_info[i][FILEVIEW_FILE_WIDTH]=file_width
     fileview_info[i][FILEVIEW_FILE_HEIGHT]=file_height
     fileview_info[i][FILEVIEW_NUMBER1]=number1
     fileview_info[i][FILEVIEW_NUMBER2]=number2
     fileview_info[i][FILEVIEW_SEL]=sel
     fileview_info[i][FILEVIEW_TIMER1]=timer1
     fileview_info[i][FILEVIEW_CLICK_ON]=click_on
     fileview_info[i][FILEVIEW_SEL_NAME]=sel_name
     fileview_info[i][FILEVIEW_PRESSED_LEFT]=pressed_left
     fileview_info[i][FILEVIEW_PRESSED_RIGHT]=pressed_right
     fileview_info[i][FILEVIEW_TEMP_MX]=temp_mx
     fileview_info[i][FILEVIEW_TEMP_MY]=temp_my
     fileview_info[i][FILEVIEW_COMMAND1]=command1
     fileview_info[i][FILEVIEW_COMMAND2]=command2
     fileview_info[i][FILEVIEW_COMMAND3]=command3
     fileview_info[i][26]=pos
   end for
end procedure

atom test
sequence d,line1
procedure init(sequence path)
test=0
d={}
line1={}
  d = dir(path)
  for i=1 to length(d) do
  test= compare(d[i][2],"d") 
  if test=0 then
    if compare(d[i][1],".")=0 or compare(d[i][1],"..")=0  then
    else
    line1=append(line1,d[i][1]&".F")
    end if
  end if
  end for

  d = dir(path)
  for i=1 to length(d) do
  test= compare(d[i][2],"d") 
  if test!=0 then
  line1=append(line1,d[i][1])
  end if
  end for
  test=0
  d={}
   line1=gaz_sort(line1)
end procedure

init("c:\\euphoria")

rectangle(1,1,800,600,-1,1)
fileview_info=append(fileview_info,{1,1,300,300,line1,{},"c:\\euphoria",1,1,0,0,0,1,0,0,0,"","",0,0,0,0,"","","",0,fileview_number})
fileview_number+=1
init("c:\\")
fileview_info=append(fileview_info,{320,1,300,300,line1,{},"c:\\",1,1,0,0,0,1,0,0,0,"","",0,0,0,0,"","","",0,fileview_number})
fileview_number+=1
init("c:\\euphoria\\doc")
fileview_info=append(fileview_info,{2,310,300,300,line1,{},"c:\\euphoria\\doc",1,1,0,0,0,1,0,0,0,"","",0,0,0,0,"","","",0,fileview_number})

atom temp_x,temp_y
sequence s
s={}
temp_x=0
temp_y=0
procedure draw_mouse()
  if temp_x!=mouse_x or temp_y!=mouse_y then
    display_image({temp_x,temp_y},s)
    s=save_image({mouse_x,mouse_y},{mouse_x+5,mouse_y+5})
    rectangle(mouse_x,mouse_y,mouse_x+5,mouse_y+5,RED,1)
    temp_x=mouse_x
    temp_y=mouse_y
  end if
end procedure

procedure init_fileview(sequence string, atom id)
for i=1 to length(fileview_info) do
   if fileview_info[i][FILEVIEW_ID]=id then
     fileview_info[i][FILEVIEW_FILES]=string[1]
     fileview_info[i][FILEVIEW_VARBS]=""
     fileview_info[i][FILEVIEW_PATH]=string[2]
     fileview_info[i][FILEVIEW_INIT]=1
     fileview_info[i][FILEVIEW_DRAW]=1
     fileview_info[i][FILEVIEW_NUMBER1]=1
     fileview_info[i][FILEVIEW_NUMBER2]=0
     fileview_info[i][FILEVIEW_SEL]=0
     fileview_info[i][FILEVIEW_TIMER1]=0
     fileview_info[i][FILEVIEW_CLICK_ON]=""
     fileview_info[i][FILEVIEW_SEL_NAME]=""
     fileview_info[i][FILEVIEW_PRESSED_LEFT]=0
     fileview_info[i][FILEVIEW_PRESSED_RIGHT]=0
     fileview_info[i][FILEVIEW_TEMP_MX]=0
     fileview_info[i][FILEVIEW_TEMP_MY]=0
     exit
   end if
end for
end procedure

function get_path(atom id)
for i=1 to length(fileview_info) do
   if fileview_info[i][FILEVIEW_ID]=id then
     return fileview_info[i][FILEVIEW_PATH]
   end if
end for
end function

function get_fileview_command(atom id,atom n)
sequence temp
  for i=1 to length(fileview_info) do
     if fileview_info[i][FILEVIEW_ID]=id then
       if n=1 then
         temp=fileview_info[i][FILEVIEW_COMMAND1]
         fileview_info[i][FILEVIEW_COMMAND1]=""
         return temp
       elsif n=2 then
         temp=fileview_info[i][FILEVIEW_COMMAND2]
         fileview_info[i][FILEVIEW_COMMAND2]=""
         return temp
       elsif n=3 then
         temp=fileview_info[i][FILEVIEW_COMMAND3]
         fileview_info[i][FILEVIEW_COMMAND3]=""
         return temp
       elsif n=4 then
         temp=fileview_info[i][FILEVIEW_CLICK_ON]
         fileview_info[i][FILEVIEW_CLICK_ON]=""
        return temp
       end if
     end if
  end for
end function

procedure on_click_dir(sequence string,atom id)
sequence temp
for i=1 to length(string) do
   if string[i]='.' then
     if compare(string[i+1..length(string)],"F")=0 then
       temp=get_path(id)
       if temp[length(temp)]=92 then
         init(get_path(id)&string[1..i-1])
         init_fileview({line1,get_path(id)&string[1..i-1]},id)
       else
         init(get_path(id)&{92}&string[1..i-1])
         init_fileview({line1,get_path(id)&{92}&string[1..i-1]},id)
       end if
     end if
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
mouse()
draw_mouse()
get_button=mouse_button
fileview()
if draw2=1 then
  draw_all()
  draw2=0
end if
on_click_dir(get_fileview_command(1,4),1)
on_click_dir(get_fileview_command(2,4),2)
on_click_dir(get_fileview_command(3,4),3)
end while
