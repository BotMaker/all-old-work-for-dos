without type_check
include graphics.e
include mouse2.e
include image.e
include font.e
include file.e
include get.e

atom window_number,button_number,combox_number,menu_number,fileview_number
atom richedit_number,textbox_number,lable_number,box_number,toolbar_number
global atom draw_all,sel_window,selete,close_window,key,draw_a_window
global sequence file_names,file_images,image_1,dir_name
global atom drive,same_dir,next_dir1,back_dir1
atom listview_number
atom get_button
sequence window_info, button_info,combox_info,richedit_info,textbox_info,toolbar_info
sequence lable_info,listview_info,menu_info,box_info,workbar_info,fileview_info
workbar_info={1,600,800,1,"",""}

toolbar_number=0
toolbar_info={}

image_1={}
file_images={}
file_names={}
fileview_info={}
fileview_number=1
draw_all=0
close_window=1
selete=1
draw_a_window=0
sel_window=0
if graphics_mode(258) then
end if

constant WINDOW_X=1
constant WINDOW_Y=2
constant WINDOW_WIDTH=3
constant WINDOW_HEIGHT=4
constant WINDOW_BAR_TEXT=5
constant WINDOW_DRAW=6
constant WINDOW_MODE=7
constant WINDOW_TEMP=8
constant WINDOW_TEMP_X=9
constant WINDOW_TEMP_Y=10
constant WINDOW_TEMP_MX=11
constant WINDOW_TEMP_MY=12
constant WINDOW_MIN=13
constant WINDOW_CLOSE=14
constant WINDOW_WORK=15
constant WINDOW_BACKGROUND_COLOR=16
constant WINDOW_ID=17
constant WINDOW_SELETE_COLOR=9
constant WINDOW_DESELETE_COLOR=7

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
constant FILEVIEW_WINDOW_ID=27
constant FILEVIEW_ID=28

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


window_number=0
window_info={}
button_number=0
button_info={}
combox_info={}
combox_number=0
richedit_number=0
richedit_info={}
textbox_info={}
textbox_number=0
lable_number=0
lable_info={}
listview_info={}
listview_number=0
menu_number=0
menu_info={}
box_info={}
box_number=0

global function remove_line(sequence string, atom line)
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

global function gaz_sort(sequence x)
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

procedure line(atom x, atom y, atom xx, atom yy, atom color)
draw_line(color,{{x,y},{xx,yy}})
end procedure

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

global function date2()
sequence info, temp
info=date()
if info[7]=1 then
  info[7]="sunday "
elsif info[7]=2 then
  info[7]="monday "
elsif info[7]=3 then
  info[7]="tuseday "
elsif info[7]=4 then
  info[7]="wensaday "
elsif info[7]=5 then
  info[7]="thrusday "
elsif info[7]=6 then
  info[7]="friday "
elsif info[7]=7 then
  info[7]="saturday "
end if
if info[2]=1 then
  info[2]="jan "
elsif info[2]=2 then
  info[2]="feb "
elsif info[2]=3 then
  info[2]="mar "
elsif info[2]=4 then
  info[2]="apr "
elsif info[2]=5 then
  info[2]="may "
elsif info[2]=6 then
  info[2]="jun "
elsif info[2]=7 then
  info[2]="jul "
elsif info[2]=8 then
  info[2]="arg "
elsif info[2]=9 then
  info[2]="sep "
elsif info[2]=10 then
  info[2]="oct "
elsif info[2]=11 then
  info[2]="nov "
elsif info[2]=12 then
  info[2]="dec "
end if
info[1]="2"&"0"&"0"&sprintf("%d",info[1]-100)
temp=info[7]
temp&=sprintf("%d",info[3])&" "
temp&=info[2]
temp&=info[1]&" "
temp&=sprintf("%d",info[4])&":"
if info[5]<10 then
temp&="0"&sprintf("%d",info[5])&":"
else
temp&=sprintf("%d",info[5])&":"
end if
if info[6]<10 then
  temp&="0"&sprintf("%d",info[6])
else
temp&=sprintf("%d",info[6])
end if
return temp
end function

function on_click_window_bar(atom xx, atom yy)
atom x,y,width,mode
mode=0
for i=1 to length(window_info) do
   x=window_info[i][WINDOW_X]
   y=window_info[i][WINDOW_Y]
   width=window_info[i][WINDOW_WIDTH]
   if i=length(window_info) then
   mode=1
   end if
   if mode=1 then
   if xx>x and xx<x+width and yy>y and yy<y+20 then
   return 1
   end if
   end if
  end for
return 0
end function

function mouse_over_window(atom xx, atom yy)
atom x,y,width,mode,height
mode=0
  for i=1 to length(window_info) do
  x=window_info[i][WINDOW_X]
  y=window_info[i][WINDOW_Y]
  width=window_info[i][WINDOW_WIDTH]
  height=window_info[i][WINDOW_HEIGHT]
  if i=length(window_info) then
  mode=1
  end if
  if mode=1 then
  if xx>x and xx<x+width and yy>y and yy<y+height then
  return 1
  end if
  end if
  end for
return 0
end function

function clear(atom xx, atom yy, atom id)
atom x,y,width,height
sequence info
info={}
  for i=1 to length(window_info) do
     x=window_info[i][WINDOW_X]
     y=window_info[i][WINDOW_Y]+20
     width=window_info[i][WINDOW_WIDTH]
     height=window_info[i][WINDOW_HEIGHT]
     if id!=window_info[i][WINDOW_ID] then
     if xx<x then
     info=append(info,1)
     elsif xx>x+width then
     info=append(info,1)
     elsif yy<y then
     info=append(info,1)
     elsif yy>y+height-20 then
     info=append(info,1)
     else
     info=append(info,0)
     end if
     end if
  end for
  if length(info)>0 then
  for i=1 to length(info) do
  if info[i]=0 then
  return 0
  end if
  end for
  return 1
  else
  return 0
  end if
end function

global procedure set_window(atom id,atom v)
atom ok
ok=0
   for i=1 to length(window_info) do
      if window_info[i][WINDOW_ID]=id then
       window_info[i][WINDOW_WORK]=v
       for j=1 to length(window_info) do
            if window_info[j][WINDOW_WORK]=1 then
              draw_all=window_info[j][WINDOW_ID]
              ok=1
              exit
          end if
       end for
       exit
      end if
   end for
if ok=0 then
  rectangle(1,1,800,600,-1,1)
end if
end procedure

global function stop(atom id)
  for i=1 to length(window_info) do
     if window_info[i][WINDOW_ID]=id then
       if window_info[i][WINDOW_CLOSE]=1 then
         window_info[i][WINDOW_CLOSE]=0
         return 1
       end if
     end if
  end for
return 0
end function

global procedure add_item(sequence string)
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
         listview_info[i][7]=append(listview_info[i][7],string[3])
         listview_info[i][5]=1
         listview_info[i][6]=0
         listview_info[i][8]=1
         listview_info[i][9]=0
         listview_info[i][10]=0
         listview_info[i][12]=1
         exit
       end if
     end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
         if length(combox_info[i][7])>0 then
         combox_info[i][7]=append(combox_info[i][7],string[3])
         else
         combox_info[i][7]=string[3]
         end if
         combox_info[i][3]=0
         combox_info[i][5]=0
         combox_info[i][6]=0
         combox_info[i][9]=1
         combox_info[i][10]=0
         combox_info[i][11]=1
         combox_info[i][13]=0
         combox_info[i][15]=1
         exit
       end if
     end for
  end if
end procedure

global procedure add_all_item(sequence string)
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
         listview_info[i][7]=string[3]
         listview_info[i][5]=1
         listview_info[i][6]=0
         listview_info[i][8]=1
         listview_info[i][9]=0
         listview_info[i][10]=0
         listview_info[i][12]=1
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
         combox_info[i][7]=string[3]
         combox_info[i][3]=0
         combox_info[i][5]=0
         combox_info[i][6]=0
         combox_info[i][9]=1
         combox_info[i][10]=0
         combox_info[i][11]=1
         combox_info[i][13]=0
         combox_info[i][15]=1
       end if
     end for
  end if
end procedure

global procedure delete_item(sequence string)
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
         for j=1 to length(listview_info[i][7]) do
           if compare(string[3],listview_info[i][7][j])=0 then
             listview_info[i][7]=remove_line(listview_info[i][7],j)
             listview_info[i][5]=1
             listview_info[i][6]=0
             listview_info[i][8]=1
             listview_info[i][9]=0
             listview_info[i][10]=0
             listview_info[i][12]=1
             exit
           end if
         end for
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
         for j=1 to length(combox_info[i][7]) do
           if compare(string[3],combox_info[i][7][j])=0 then
             combox_info[i][7]=remove_line(combox_info[i][7],j)
             combox_info[i][5]=0
             combox_info[i][6]=0
             combox_info[i][9]=1
             combox_info[i][10]=0
             combox_info[i][11]=1
             combox_info[i][13]=0
             combox_info[i][3]=0
             combox_info[i][15]=1
             exit
           end if
         end for
       end if
    end for
  end if
end procedure

global procedure delete_all_item(sequence string)
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
             listview_info[i][7]=""
             listview_info[i][5]=1
             listview_info[i][6]=0
             listview_info[i][8]=1
             listview_info[i][9]=0
             listview_info[i][10]=0
             listview_info[i][12]=1
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
             combox_info[i][7]=""
             combox_info[i][5]=0
             combox_info[i][6]=0
             combox_info[i][9]=1
             combox_info[i][10]=0
             combox_info[i][11]=1
             combox_info[i][13]=0
             combox_info[i][3]=0
             combox_info[i][15]=1
             exit
       end if
    end for
  end if
end procedure

global procedure replace_item(sequence string)
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
         for j=1 to length(listview_info[i][7]) do
           if compare(string[3],listview_info[i][7][j])=0 then
             listview_info[i][7][j]=string[4]
             listview_info[i][5]=1
             listview_info[i][6]=0
             listview_info[i][8]=1
             listview_info[i][9]=0
             listview_info[i][10]=0
             listview_info[i][12]=1
             exit
           end if
         end for
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
         for j=1 to length(combox_info[i][7]) do
           if compare(string[3],combox_info[i][7][j])=0 then
             combox_info[i][7][j]=string[4]
             combox_info[i][5]=0
             combox_info[i][6]=0
             combox_info[i][9]=1
             combox_info[i][10]=0
             combox_info[i][11]=1
             combox_info[i][13]=0
             combox_info[i][3]=0
             combox_info[i][15]=1
             exit
           end if
         end for
       end if
    end for
  end if
end procedure

global function get_all_item(sequence string)
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
           return listview_info[i][7]
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
           return combox_info[i][7]
       end if
    end for
  end if
end function

global function get_sel(sequence string)
  if compare(string[1],"box")=0 then
    for i=1 to length(box_info) do
       if box_info[i][9]=string[2] then
           return box_info[i][5]
       end if
    end for
  end if
end function

global procedure set_sel_item(sequence string)
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
         listview_info[i][10]=string[3]
       end if
    end for
  end if
end procedure

global function get_text(sequence string)
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][9]=string[2] then
         return button_info[i][5]
       end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][13]=string[2] then
        return textbox_info[i][5]
       end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][9]=string[2] then
        return lable_info[i][5]
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
         if listview_info[i][10]=0 then
           return ""
         else
           return listview_info[i][7][listview_info[i][10]]
         end if
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
           return combox_info[i][8]
       end if
    end for
  end if
  if compare(string[1],"richedit")=0 then
    for i=1 to length(richedit_info) do
       if richedit_info[i][17]=string[2] then
        return richedit_info[i][5]
       end if
    end for
  end if
return ""
end function

global procedure set_text(sequence string)
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][6]=string[2] then
         button_info[i][1]=string[3]
       end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][13]=string[2] then
         textbox_info[i][5]=string[3]
         textbox_info[i][7]=0
         textbox_info[i][10]=1
       end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][9]=string[2] then
         lable_info[i][5]=string[3]
       end if
    end for
  end if
  if compare(string[1],"richedit")=0 then
    for i=1 to length(richedit_info) do
       if richedit_info[i][17]=string[2] then
           richedit_info[i][5]=string[3]
           richedit_info[i][6]=0
           richedit_info[i][7]=1
           richedit_info[i][10]=1
           richedit_info[i][11]=0
           richedit_info[i][14]=1
       end if
    end for
  end if
end procedure

global procedure set_width(sequence string)
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][13]=string[2] then
         textbox_info[i][3]=string[3]
       end if
    end for
  end if
  if compare(string[1],"richedit")=0 then
    for i=1 to length(richedit_info) do
       if richedit_info[i][17]=string[2] then
           richedit_info[i][3]=string[3]
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
           listview_info[i][3]=string[3]
       end if
    end for
  end if
end procedure

global procedure set_height(sequence string)
  if compare(string[1],"richedit")=0 then
    for i=1 to length(richedit_info) do
       if richedit_info[i][17]=string[2] then
           richedit_info[i][4]=string[3]
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
           listview_info[i][4]=string[3]
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
           combox_info[i][4]=string[3]
       end if
    end for
  end if
end procedure

global procedure selete_window(atom id)
sequence temp
temp={}
for i=1 to length(window_info) do
   if window_info[i][WINDOW_ID]=id then
     temp=window_info[i]
     window_info=remove_line(window_info,i)
     exit
   end if
end for
window_info=append(window_info,temp)
for i=1 to length(button_info) do
   button_info[i][6]=1
end for
for i=1 to length(combox_info) do
   combox_info[i][15]=1
end for
for i=1 to length(richedit_info) do
      richedit_info[i][8]=1
end for
for i=1 to length(lable_info) do
      lable_info[i][6]=1
end for
for i=1 to length(textbox_info) do
      textbox_info[i][10]=1
end for
for i=1 to length(listview_info) do
      listview_info[i][12]=1
end for
for i=1 to length(menu_info) do
      menu_info[i][13]=1
end for
for i=1 to length(box_info) do
      box_info[i][6]=1
end for
for i=1 to length(toolbar_info) do
      toolbar_info[i][7]=1
end for
for i=1 to length(fileview_info) do
      fileview_info[i][FILEVIEW_DRAW]=1
end for
end procedure

global procedure draw_all_windows(atom id)
rectangle(1,1,800,600,-1,1)
selete_window(id)
for i=1 to length(window_info) do
   window_info[i][6]=1
end for
workbar_info[4]=1
end procedure

global procedure delete_window(atom id)
for i=1 to length(window_info) do
   if window_info[i][WINDOW_ID]=id then
     window_info=remove_line(window_info,i)
     exit
   end if
end for
-- button
for j=1 to length(button_info) do
for i=1 to length(button_info) do
   if button_info[i][8]=id then
     button_info=remove_line(button_info,i)
     exit
   end if
end for
end for
--combox
for j=1 to length(combox_info) do
for i=1 to length(combox_info) do
   if combox_info[i][17]=id then
     combox_info=remove_line(combox_info,i)
     exit
   end if
end for
end for
--richedit
for j=1 to length(richedit_info) do
for i=1 to length(richedit_info) do
   if richedit_info[i][16]=id then
     richedit_info=remove_line(richedit_info,i)
     exit
   end if
end for
end for
--lable
for j=1 to length(lable_info) do
for i=1 to length(lable_info) do
   if lable_info[i][8]=id then
     lable_info=remove_line(lable_info,i)
     exit
   end if
end for
end for
for j=1 to length(textbox_info) do
for i=1 to length(textbox_info) do
   if textbox_info[i][12]=id then
     textbox_info=remove_line(textbox_info,i)
     exit
   end if
end for
end for
for j=1 to length(menu_info) do
for i=1 to length(menu_info) do
   if menu_info[i][15]=id then
     menu_info=remove_line(menu_info,i)
     exit
   end if
end for
end for
for j=1 to length(listview_info) do
for i=1 to length(listview_info) do
   if listview_info[i][14]=id then
     listview_info=remove_line(listview_info,i)
     exit
   end if
end for
end for
for j=1 to length(box_info) do
for i=1 to length(box_info) do
   if box_info[i][8]=id then
     box_info=remove_line(box_info,i)
     exit
   end if
end for
end for
for j=1 to length(toolbar_info) do
for i=1 to length(toolbar_info) do
   if toolbar_info[i][10]=id then
     toolbar_info=remove_line(toolbar_info,i)
     exit
   end if
end for
end for
if length(window_info)>0 then
  draw_all_windows(window_info[length(window_info)][WINDOW_ID])
else
rectangle(1,1,800,600,-1,1)
end if
end procedure

global procedure delete(sequence string)
if compare(string[1],"button")=0 then
for i=1 to length(button_info) do
   if button_info[i][9]=string[2] then
     button_info=remove_line(button_info,i)
     exit
   end if
end for
end if
--combox
if compare(string[1],"combox")=0 then
for i=1 to length(combox_info) do
   if combox_info[i][18]=string[2] then
     combox_info=remove_line(combox_info,i)
     exit
   end if
end for
end if
--richedit
if compare(string[1],"richedit")=0 then
for i=1 to length(richedit_info) do
   if richedit_info[i][17]=string[2] then
     richedit_info=remove_line(richedit_info,i)
     exit
   end if
end for
end if
--lable
if compare(string[1],"lable")=0 then
for i=1 to length(lable_info) do
   if lable_info[i][9]=string[2] then
     lable_info=remove_line(lable_info,i)
     exit
   end if
end for
end if
if compare(string[1],"textbox")=0 then
for i=1 to length(textbox_info) do
   if textbox_info[i][13]=string[2] then
     textbox_info=remove_line(textbox_info,i)
     exit
   end if
end for
end if
if compare(string[1],"menu")=0 then
for i=1 to length(menu_info) do
   if menu_info[i][16]=string[2] then
     menu_info=remove_line(menu_info,i)
     exit
   end if
end for
end if
if compare(string[1],"listview")=0 then
for i=1 to length(listview_info) do
   if listview_info[i][15]=string[2] then
     listview_info=remove_line(listview_info,i)
     exit
   end if
end for
end if
if compare(string[1],"box")=0 then
for i=1 to length(box_info) do
   if box_info[i][9]=string[2] then
     box_info=remove_line(box_info,i)
     exit
   end if
end for
end if
end procedure

global procedure draw_window(atom id)
for i=1 to length(window_info) do
   if window_info[i][WINDOW_ID]=id then
   window_info[i][6]=1
   end if
end for
for i=1 to length(button_info) do
   if button_info[i][8]=id then
     button_info[i][6]=1
   end if
end for
for i=1 to length(combox_info) do
   if combox_info[i][17]=id then
      combox_info[i][15]=1
   end if
end for
for i=1 to length(richedit_info) do
   if richedit_info[i][16]=id then
      richedit_info[i][8]=1
   end if
end for
for i=1 to length(lable_info) do
   if lable_info[i][8]=id then
      lable_info[i][6]=1
   end if
end for
for i=1 to length(textbox_info) do
   if textbox_info[i][12]=id then
      textbox_info[i][10]=1
   end if
end for
for i=1 to length(listview_info) do
   if listview_info[i][14]=id then
      listview_info[i][12]=1
   end if
end for
for i=1 to length(menu_info) do
   if menu_info[i][15]=id then
      menu_info[i][13]=1
   end if
end for
for i=1 to length(box_info) do
   if box_info[i][8]=id then
      box_info[i][6]=1
   end if
end for
end procedure

global procedure init_fileview(sequence string, atom id)
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

global function get_path(atom id)
for i=1 to length(fileview_info) do
   if fileview_info[i][FILEVIEW_ID]=id then
     return fileview_info[i][FILEVIEW_PATH]
   end if
end for
end function

global function get_fileview_command(atom id,atom n)
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
return ""
end function

global function create_ex(sequence string)
  if compare(string[1],"window")=0 then
    window_number+=1
    window_info=append(window_info,{string[2],string[3],string[4],string[5],string[6],1,1,0,0,0,0,0,0,0,1,-1,window_number})
    return window_number
  end if
  if compare(string[1],"fileview")=0 then
    fileview_number+=1
    fileview_info=append(fileview_info,{string[2],string[3],string[4],string[5],string[6],{},string[7],1,1,0,0,0,1,0,0,0,"","",0,0,0,0,"","","",0,string[8],fileview_number})
    return fileview_number
  end if
  if compare(string[1],"toolbar")=0 then
    toolbar_number+=1
    toolbar_info=append(toolbar_info,{1,1,0,0,0,string[2],1,0,0,string[3],toolbar_number})
    return toolbar_number
  end if
  if compare(string[1],"button")=0 then
    button_number+=1
    button_info=append(button_info,{string[2],string[3],0,0,string[4],1,0,string[5],button_number})
    return button_number
 end if
  if compare(string[1],"combox")=0 then
    combox_number+=1
    combox_info=append(combox_info,{string[2],string[3],0,string[4],0,0,string[5],"",1,0,1,1,0,"",1,0,string[6],combox_number})
    return combox_number
 end if
  if compare(string[1],"richedit")=0 then
    richedit_number+=1
    richedit_info=append(richedit_info,{string[2],string[3],string[4],string[5],{""},0,1,1,1,1,0,1,0,1,0,string[6],richedit_number,0})
    return richedit_number
  end if
  if compare(string[1],"lable")=0 then
    lable_number+=1
    lable_info=append(lable_info,{string[2],string[3],0,20,string[4],1,0,string[5],lable_number})
    return lable_number
 end if
  if compare(string[1],"textbox")=0 then
    textbox_number+=1
    textbox_info=append(textbox_info,{string[2],string[3],string[4],20,"",0,0,"",1,1,0,string[5],textbox_number})
    return textbox_number
  end if
  if compare(string[1],"menu")=0 then
    menu_number+=1
    menu_info=append(menu_info,{string[2],string[3],string[4],0,0,0,0,0,{0},{0},"",1,1,0,string[5],menu_number})
    return menu_number
  end if
  if compare(string[1],"listview")=0 then
    listview_number+=1
    listview_info=append(listview_info,{string[2],string[3],string[4],string[5],1,0,string[6],1,0,0,"",1,0,string[7],listview_number})
    return listview_number
  end if
  if compare(string[1],"box")=0 then
    box_number+=1
    box_info=append(box_info,{string[2],string[3],16,16,0,1,0,string[4],box_number,0})
    return box_number
  end if
end function

global function on_click(sequence string)
  if compare(string[1],"toolbar")=0 then
    for i=1 to length(toolbar_info) do
       if toolbar_info[i][11]=string[2] then
         if toolbar_info[i][9]=string[3] then
           toolbar_info[i][9]=0
           mouse_button=0
           return 1
         else
          return 0
         end if
       end if
    end for
  end if
  if compare(string[1],"menu")=0 then
    for i=1 to length(menu_info) do
       if menu_info[i][16]=string[2] then
         if compare(menu_info[i][11],string[3])=0 then
           mouse_button=0
           menu_info[i][11]=""
           return 1
         else
           return 0
         end if
       end if
    end for
  end if
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][9]=string[2] then
         if button_info[i][4]=1 then
           button_info[i][4]=0
           mouse_button=0
           return 1
         else
          return 0
         end if
       end if
    end for
  end if
  if compare(string[1],"box")=0 then
    for i=1 to length(box_info) do
       if box_info[i][9]=string[2] then
         if box_info[i][10]=1 then
           box_info[i][10]=0
           mouse_button=0
           return 1
         else
          return 0
         end if
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
         if length(listview_info[i][11])>0 then
           listview_info[i][11]=""
           mouse_button=0
           return 1
         else
           return 0
         end if
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
         if length(combox_info[i][14])>0 then
           combox_info[i][14]=""
           mouse_button=0
           return 1
         else
           return 0
         end if
       end if
    end for
  end if
return 0
end function

global function get_x(sequence string)
atom window_x,window_id
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][9]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=button_info[i][8] then
              window_x=window_info[j][WINDOW_X]
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for           
         if string[3]=1 then
         return button_info[i][1]+window_x
         else
         return button_info[i][1]
         end if
      end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=listview_info[i][14] then
              window_x=window_info[j][WINDOW_X]
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for           
         if string[3]=1 then
         return listview_info[i][1]+window_x
         else
         return listview_info[i][1]
         end if
      end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=combox_info[i][17] then
              window_x=window_info[j][WINDOW_X]
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for           
         if string[3]=1 then
         return combox_info[i][1]+window_x
         else
         return combox_info[i][1]
         end if
      end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][13]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=textbox_info[i][12] then
              window_x=window_info[j][WINDOW_X]
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for           
         if string[3]=1 then
         return textbox_info[i][1]+window_x
         else
         return textbox_info[i][1]
         end if
      end if
    end for
  end if
  if compare(string[1],"richedit")=0 then
    for i=1 to length(richedit_info) do
       if richedit_info[i][17]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=richedit_info[i][16] then
              window_x=window_info[j][WINDOW_X]
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for           
         if string[3]=1 then
         return richedit_info[i][1]+window_x
         else
         return richedit_info[i][1]
         end if
      end if
    end for
  end if
  if compare(string[1],"box")=0 then
    for i=1 to length(box_info) do
       if box_info[i][9]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=box_info[i][8] then
              window_x=window_info[j][WINDOW_X]
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for           
         if string[3]=1 then
         return box_info[i][1]+window_x
         else
         return box_info[i][1]
         end if
      end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][9]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=lable_info[i][8] then
              window_x=window_info[j][WINDOW_X]
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for           
         if string[3]=1 then
         return lable_info[i][1]+window_x
         else
         return lable_info[i][1]
         end if
      end if
    end for
  end if
end function

global function get_y(sequence string)
atom window_y,window_id
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][9]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=button_info[i][8] then
              window_y=window_info[j][WINDOW_Y]+20
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for           
         if string[3]=1 then
         return button_info[i][2]+window_y
         else
         return button_info[i][2]
         end if
      end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=listview_info[i][14] then
              window_y=window_info[j][WINDOW_Y]+20
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for           
         if string[3]=1 then
         return listview_info[i][2]+window_y
         else
         return listview_info[i][2]
         end if
      end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=combox_info[i][17] then
              window_y=window_info[j][WINDOW_Y]+20
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for           
         if string[3]=1 then
         return combox_info[i][2]+window_y
         else
         return combox_info[i][2]
         end if
      end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][13]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=textbox_info[i][12] then
              window_y=window_info[j][WINDOW_Y]+20
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for           
         if string[3]=1 then
         return textbox_info[i][2]+window_y
         else
         return textbox_info[i][2]
         end if
      end if
    end for
  end if
  if compare(string[1],"richedit")=0 then
    for i=1 to length(richedit_info) do
       if richedit_info[i][17]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=richedit_info[i][16] then
              window_y=window_info[j][WINDOW_Y]+20
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for           
         if string[3]=1 then
         return richedit_info[i][2]+window_y
         else
         return richedit_info[i][2]
         end if
      end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][9]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=lable_info[i][8] then
              window_y=window_info[j][WINDOW_Y]+20
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for           
         if string[3]=1 then
         return lable_info[i][2]+window_y
         else
         return lable_info[i][2]
         end if
      end if
    end for
  end if
  if compare(string[1],"box")=0 then
    for i=1 to length(box_info) do
       if box_info[i][9]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=box_info[i][8] then
              window_y=window_info[j][WINDOW_Y]+20
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for           
         if string[3]=1 then
         return box_info[i][2]+window_y
         else
         return box_info[i][2]
         end if
      end if
    end for
  end if
end function

global function get_width(sequence string)
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][9]=string[2] then
         return button_info[i][3]
      end if
    end for
  end if
  if compare(string[1],"richedit")=0 then
    for i=1 to length(richedit_info) do
       if richedit_info[i][17]=string[2] then
         return richedit_info[i][3]
      end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
         return listview_info[i][3]
      end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
         return combox_info[i][3]
      end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][13]=string[2] then
         return textbox_info[i][3]
      end if
    end for
  end if
  if compare(string[1],"box")=0 then
    for i=1 to length(box_info) do
       if box_info[i][9]=string[2] then
         return box_info[i][3]
      end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][9]=string[2] then
         return lable_info[i][3]
      end if
    end for
  end if
end function

global function get_height(sequence string)
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][9]=string[2] then
         return 20
      end if
    end for
  end if
  if compare(string[1],"richedit")=0 then
    for i=1 to length(richedit_info) do
       if richedit_info[i][17]=string[2] then
         return richedit_info[i][4]
      end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
         return listview_info[i][4]
      end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
         return combox_info[i][4]
      end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][13]=string[2] then
         return textbox_info[i][4]
      end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][9]=string[2] then
         return lable_info[i][4]
      end if
    end for
  end if
  if compare(string[1],"box")=0 then
    for i=1 to length(box_info) do
       if box_info[i][9]=string[2] then
         return box_info[i][4]
      end if
    end for
  end if
end function

global function over(sequence string)
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][9]=string[2] then
         if mouse_x>get_x({"button",string[2],1}) and mouse_x<(get_x({"button",string[2],1})+get_width({"button",string[2]}))
         and mouse_y>get_y({"button",string[2],1}) and mouse_y<(get_y({"button",string[2],1})+get_height({"button",string[2]})) then
         return 1
         else
         return 0
         end if
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
         if mouse_x>get_x({"combox",string[2],1}) and mouse_x<(get_x({"combox",string[2],1})+get_width({"combox",string[2]}))
         and mouse_y>get_y({"combox",string[2],1}) and mouse_y<(get_y({"combox",string[2],1})+20) then
         return 1
         else
         return 0
         end if
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
         if mouse_x>get_x({"listview",string[2],1}) and mouse_x<(get_x({"listview",string[2],1})+get_width({"listview",string[2]}))
         and mouse_y>get_y({"listview",string[2],1}) and mouse_y<(get_y({"listview",string[2],1})+get_height({"listview",string[2]})) then
         return 1
         else
         return 0
         end if
       end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][13]=string[2] then
         if mouse_x>get_x({"textbox",string[2],1}) and mouse_x<(get_x({"textbox",string[2],1})+get_width({"textbox",string[2]}))
         and mouse_y>get_y({"textbox",string[2],1}) and mouse_y<(get_y({"textbox",string[2],1})+get_height({"textbox",string[2]})) then
         return 1
         else
         return 0
         end if
       end if
    end for
  end if
  if compare(string[1],"richedit")=0 then
    for i=1 to length(richedit_info) do
       if richedit_info[i][17]=string[2] then
         if mouse_x>get_x({"richedit",string[2],1}) and mouse_x<(get_x({"richedit",string[2],1})+get_width({"richedit",string[2]}))
         and mouse_y>get_y({"richedit",string[2],1}) and mouse_y<(get_y({"richedit",string[2],1})+get_height({"richedit",string[2]})) then
         return 1
         else
         return 0
         end if
       end if
    end for
  end if
  if compare(string[1],"box")=0 then
    for i=1 to length(box_info) do
       if box_info[i][9]=string[2] then
         if mouse_x>get_x({"box",string[2],1}) and mouse_x<(get_x({"box",string[2],1})+get_width({"box",string[2]}))
         and mouse_y>get_y({"box",string[2],1}) and mouse_y<(get_y({"box",string[2],1})+get_height({"box",string[2]})) then
         return 1
         else
         return 0
         end if
       end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][9]=string[2] then
         if mouse_x>get_x({"lable",string[2],1}) and mouse_x<(get_x({"lable",string[2],1})+get_width({"lable",string[2]}))
         and mouse_y>get_y({"lable",string[2],1}) and mouse_y<(get_y({"lable",string[2],1})+get_height({"lable",string[2]})) then
         return 1
         else
         return 0
         end if
       end if
    end for
  end if
return 0
end function

global procedure set_x(sequence string)
atom window_x,window_id
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][9]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=button_info[i][8] then
              window_id=window_info[j][WINDOW_ID]
              window_x=window_info[j][WINDOW_X]
              exit
            end if
         end for
         if string[4]=1 then
         button_info[i][1]=string[3]-window_x
         else
         button_info[i][1]=string[3]
         end if
         draw_window(window_id)
      end if
    end for
  end if
  if compare(string[1],"richedit")=0 then
    for i=1 to length(richedit_info) do
       if richedit_info[i][17]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=richedit_info[i][16] then
              window_id=window_info[j][WINDOW_ID]
              window_x=window_info[j][WINDOW_X]
              exit
            end if
         end for
         if string[4]=1 then
         richedit_info[i][1]=string[3]-window_x
         else
         richedit_info[i][1]=string[3]
         end if
         draw_window(window_id)
      end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=listview_info[i][14] then
              window_id=window_info[j][WINDOW_ID]
              window_x=window_info[j][WINDOW_X]
              exit
            end if
         end for
         if string[4]=1 then
         listview_info[i][1]=string[3]-window_x
         else
         listview_info[i][1]=string[3]
         end if
         draw_window(window_id)
      end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=combox_info[i][17] then
              window_id=window_info[j][WINDOW_ID]
              window_x=window_info[j][WINDOW_X]
              exit
            end if
         end for
         if string[4]=1 then
         combox_info[i][1]=string[3]-window_x
         else
         combox_info[i][1]=string[3]
         end if
         draw_window(window_id)
      end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][13]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=textbox_info[i][12] then
              window_id=window_info[j][WINDOW_ID]
              window_x=window_info[j][WINDOW_X]
              exit
            end if
         end for
         if string[4]=1 then
         textbox_info[i][1]=string[3]-window_x
         else
         textbox_info[i][1]=string[3]
         end if
         draw_window(window_id)
      end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][9]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=lable_info[i][8] then
              window_id=window_info[j][WINDOW_ID]
              window_x=window_info[j][WINDOW_X]
              exit
            end if
         end for
         if string[4]=1 then
         lable_info[i][1]=string[3]-window_x
         else
         lable_info[i][1]=string[3]
         end if
         draw_window(window_id)
      end if
    end for
  end if
  if compare(string[1],"box")=0 then
    for i=1 to length(box_info) do
       if box_info[i][9]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=box_info[i][8] then
              window_id=window_info[j][WINDOW_ID]
              window_x=window_info[j][WINDOW_X]
              exit
            end if
         end for
         if string[4]=1 then
         box_info[i][1]=string[3]-window_x
         else
         box_info[i][1]=string[3]
         end if
         draw_window(window_id)
      end if
    end for
  end if
end procedure

global procedure set_y(sequence string)
atom window_y,window_id
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][9]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=button_info[i][8] then
              window_y=window_info[j][WINDOW_Y]+20
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for
         if string[4]=1 then
         button_info[i][2]=string[3]-window_y
         else
         button_info[i][2]=string[3]
         end if
         draw_window(window_id)
         exit
         end if
    end for
  end if
  if compare(string[1],"richedit")=0 then
    for i=1 to length(richedit_info) do
       if richedit_info[i][17]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=richedit_info[i][16] then
              window_y=window_info[j][WINDOW_Y]+20
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for
         if string[4]=1 then
         richedit_info[i][2]=string[3]-window_y
         else
         richedit_info[i][2]=string[3]
         end if
         draw_window(window_id)
         exit
         end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][15]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=listview_info[i][14] then
              window_y=window_info[j][WINDOW_Y]+20
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for
         if string[4]=1 then
         listview_info[i][2]=string[3]-window_y
         else
         listview_info[i][2]=string[3]
         end if
         draw_window(window_id)
         exit
         end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][18]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=combox_info[i][17] then
              window_y=window_info[j][WINDOW_Y]+20
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for
         if string[4]=1 then
         combox_info[i][2]=string[3]-window_y
         else
         combox_info[i][2]=string[3]
         end if
         draw_window(window_id)
         exit
         end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][13]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=textbox_info[i][12] then
              window_y=window_info[j][WINDOW_Y]+20
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for
         if string[4]=1 then
         textbox_info[i][2]=string[3]-window_y
         else
         textbox_info[i][2]=string[3]
         end if
         draw_window(window_id)
         exit
         end if
    end for
  end if
  if compare(string[1],"box")=0 then
    for i=1 to length(box_info) do
       if box_info[i][9]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=box_info[i][8] then
              window_y=window_info[j][WINDOW_Y]+20
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for
         if string[4]=1 then
         box_info[i][2]=string[3]-window_y
         else
         box_info[i][2]=string[3]
         end if
         draw_window(window_id)
         exit
         end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][9]=string[2] then
         for j=1 to length(window_info) do
            if window_info[j][WINDOW_ID]=lable_info[i][8] then
              window_y=window_info[j][WINDOW_Y]+20
              window_id=window_info[j][WINDOW_ID]
              exit
            end if
         end for
         if string[4]=1 then
         lable_info[i][2]=string[3]-window_y
         else
         lable_info[i][2]=string[3]
         end if
         draw_window(window_id)
         exit
         end if
    end for
  end if
end procedure

global function read_file(sequence string)
sequence buffer
object line
integer fn
fn = open(string, "r")
 if fn = -1 then
   return ""
 end if
buffer = {}
while 1 do
 line = gets(fn)
 if atom(line) then
  exit   
 end if
 buffer = append(buffer, line[1..length(line)-1])
end while
close(fn)
return buffer
end function

function string_insert(atom pos, atom insert, sequence string2)
sequence a,b
if length(string2)>0 then
a=string2[1..pos]
b=string2[pos+1..length(string2)]
string2=a&insert&b
return string2
end if
if length(string2)=0 then
return string2&insert
end if
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

function remove_string(atom pos, sequence string2)
sequence temp
temp=""
for i=1 to length(string2) do
   if pos!=i then
     temp&=string2[i]
   end if
end for
string2=temp
return string2
end function

procedure button(atom id)
atom x,y,width,sel,draw,mode,window_id
sequence name
  for i=1 to length(button_info) do
     x=button_info[i][1]
     y=button_info[i][2]
     width=button_info[i][3]
     sel=button_info[i][4]
     name=button_info[i][5]
     draw=button_info[i][6]
     mode=button_info[i][7]
     window_id=button_info[i][8]
     if window_id=id then
       for j=1 to length(window_info) do
       if window_info[j][WINDOW_ID]=id then
       x+=window_info[j][WINDOW_X]
       y+=window_info[j][WINDOW_Y]+20
       if j=length(window_info) then
       mode=1
       else
       mode=0
       end if
       if x>window_info[j][WINDOW_X]+window_info[j][WINDOW_WIDTH]-width then
       draw=0
       mode=0
       end if
       if x<window_info[j][WINDOW_X] then
       draw=0
       mode=0
       end if
       if y>window_info[j][WINDOW_Y]+window_info[j][WINDOW_HEIGHT]-20 then
       draw=0
       mode=0
       end if
       if y<window_info[j][WINDOW_Y]+20 then
       draw=0
       mode=0
       end if
       end if
       end for
       width=length(name)
       width+=2
       width=width*8
       if draw=1 then
       rectangle(x+1,y+1,x+width-1,y+17,7,1)
       rectangle(x,y,x+width,y+18,0,0)
       draw_text({x+8,y+1},name,0,7,0)
       draw=0
       end if
       if mode=1 then
       if mouse_x>x and mouse_x< x+width and mouse_y>y and mouse_y<y+18 then
       rectangle(x+6,y+1,x+width-6,y+17,0,0)
       else
       rectangle(x+6,y+1,x+width-6,y+17,7,0)
       end if
       if mouse_x>x and mouse_x< x+width and mouse_y>y and mouse_y<y+18 and mouse_button=mb_left then
       sel=1
       end if
       end if
     end if
       button_info[i][3]=width
       button_info[i][4]=sel
       button_info[i][6]=draw
       button_info[i][7]=mode
  end for
end procedure

procedure combox(atom id)
atom window_id,mode,draw,x,y,height,width,open,sel,number1,number2,init
atom text_number,can,sel2
sequence string,sel_name,temp
for i=1 to length(combox_info) do
     x=combox_info[i][1]
     y=combox_info[i][2]
     width=combox_info[i][3]
     height=combox_info[i][4]
     height-=12
     text_number=height/16
     text_number-=1
     open=combox_info[i][5]
     sel=combox_info[i][6]
     string=combox_info[i][7]
     sel_name=combox_info[i][8]
     number1=combox_info[i][9]
     number2=combox_info[i][10]
     init=combox_info[i][11]
     sel2=combox_info[i][12]
     can=combox_info[i][13]
     temp=combox_info[i][14]
     draw=combox_info[i][15]
     mode=combox_info[i][16]
     window_id=combox_info[i][17]
     if init=1 then
     if length(string)>text_number then
     number2=length(string)-text_number
     can=1
     end if
     for j=1 to length(string) do
     if width<length(string[j]) then
     width=length(string[j])
     end if
     end for
     width+=1
     width=width*8
     init=0
     end if
     if window_id=id then
     for j=1 to length(window_info) do
     if window_info[j][WINDOW_ID]=id then
     x+=window_info[j][WINDOW_X]
     y+=window_info[j][WINDOW_Y]+20
     if j=length(window_info) then
     mode=1
     else
     mode=0
     end if
     if x>window_info[j][WINDOW_X]+window_info[j][WINDOW_WIDTH]-width then
     draw=0
     mode=0
     end if
     if x<window_info[j][WINDOW_X] then
     draw=0
     mode=0
     end if
     if y+text_number*16>window_info[j][WINDOW_Y]+window_info[j][WINDOW_HEIGHT]-20 then
     draw=0
     mode=0
     end if
     if y<window_info[j][WINDOW_Y]+20 then
     draw=0
     mode=0
     end if
     end if
     end for
     if mode=1 then
     if open=0 then
     draw_text({x+2,y+2},sel_name,BLACK,7,0)
     end if
     if mouse_x>x+width and mouse_x<x+width+16 and mouse_y>y and mouse_y<y+20 and mouse_button=mb_left then
     open=1
     rectangle(x,y+20,x+width,y+height,7,1)
     rectangle(x,y+20,x+width,y+height,0,0)
     rectangle(x,y+20,x+width,y+height,0,0)
     mouse_button=0
     for j=number1 to length(string)-number2 do
     if mouse_x>x and mouse_x<x+width and mouse_y>y+22+16*(j-number1+1)-16 and mouse_y<y+22+16*(j-number1+1) and mouse_button=mb_left then
     sel_name=string[j]
     end if
     if sel=j then
     rectangle(x+2,y+22+16*(j-number1+1)-16,x+width-1,y+22+16*(j-number1+1),9,1)
     draw_text({x+2,y+22+16*(j-number1+1)-16},string[j],BLACK,9,0)
     else
     rectangle(x+2,y+22+16*(j-number1+1)-16,x+width-1,y+22+16*(j-number1+1),7,1)
     draw_text({x+2,y+22+16*(j-number1+1)-16},string[j],BLACK,7,0)
     end if
     end for
     if can=1 then
     rectangle(x+width,y+20,x+width+16,y+height,0,0)
     rectangle(x+width+1,y+20,x+width+16,y+36,9,1)
     rectangle(x+width+1,y+height-16,x+width+16,y+height,9,1)
     end if
     end if
     if open=1 then
     for j=number1 to length(string)-number2 do
     if mouse_x>x and mouse_x<x+width-1 and mouse_y>y+22+16*(j-number1+1)-16 and mouse_y<y+22+16*(j-number1+1) then
     sel=j
     end if
     if mouse_x>x+width or mouse_x<x then
     sel=0
     sel2=0
     end if
     if mouse_y<y+22 or mouse_y>y+height then
     sel=0
     sel2=0
     end if
     if mouse_x>x and mouse_x<x+width-1 and mouse_y>y+22+16*(j-number1+1)-16 and mouse_y<y+22+16*(j-number1+1) and mouse_button=mb_left then
     sel_name=string[j]
     temp=string[j]
     end if
     end for
     if can=1 then
     if mouse_x>x+width+1 and mouse_x<x+width+16 and mouse_y>y+20 and mouse_y<y+36 and mouse_button=mb_left then
     if number1>1 then
     number1-=1
     number2+=1
     end if
     mouse_button=0
     sel-=1
     end if
     if mouse_x>x+width+1 and mouse_x<x+width+16 and mouse_y>y+height-16 and mouse_y<y+height and mouse_button=mb_left then
     if number2>0 then
     number1+=1
     number2-=1
     end if
     mouse_button=0
     sel-=1
     end if
     end if
     if sel2!=sel then
     for j=number1 to length(string)-number2 do
     if sel=j then
     rectangle(x+2,y+22+16*(j-number1+1)-16,x+width-1,y+22+16*(j-number1+1),9,1)
     draw_text({x+2,y+22+16*(j-number1+1)-16},string[j],BLACK,9,0)
     else
     rectangle(x+2,y+22+16*(j-number1+1)-16,x+width-1,y+22+16*(j-number1+1),7,1)
     draw_text({x+2,y+22+16*(j-number1+1)-16},string[j],BLACK,7,0)
     end if
     end for
     sel2=sel
     end if
     end if
     if mouse_button=mb_left then
     open=0
     draw_a_window=window_id
     end if
     end if
     if draw=1 then
     rectangle(x,y,x+width,y+20,7,1)
     rectangle(x,y,x+width,y+20,0,0)
     rectangle(x+width,y,x+width+16,y+20,7,1)
     rectangle(x+width,y,x+width+16,y+20,0,0)
     draw_text({x+2,y+2},sel_name,BLACK,7,0)
     draw=0
     end if
     end if
     combox_info[i][3]=width
     combox_info[i][5]=open
     combox_info[i][6]=sel
     combox_info[i][8]=sel_name
     combox_info[i][9]=number1
     combox_info[i][10]=number2
     combox_info[i][11]=init
     combox_info[i][12]=sel2
     combox_info[i][13]=can
     combox_info[i][14]=temp
     combox_info[i][15]=draw
     combox_info[i][16]=mode
   end for
end procedure

procedure textbox(atom id)
atom x,y,width,sel,height,chr1,screen_chr1,text_width,draw,mode
atom window_id
sequence text,temp
  for i=1 to length(textbox_info) do
     x=textbox_info[i][1]
     y=textbox_info[i][2]
     width=textbox_info[i][3]
     height=textbox_info[i][4]
     text_width=floor((width-8)/8)
     text=textbox_info[i][5]
     sel=textbox_info[i][6]
     chr1=textbox_info[i][7]
     temp=textbox_info[i][8]
     screen_chr1=textbox_info[i][9]
     draw=textbox_info[i][10]
     mode=textbox_info[i][11]
     window_id=textbox_info[i][12]

     if window_id=id then
     for j=1 to length(window_info) do
     if window_info[j][WINDOW_ID]=id then
     x+=window_info[j][WINDOW_X]
     y+=window_info[j][WINDOW_Y]+20
     if j=length(window_info) then
     mode=1
     else
     mode=0
     end if
     if x>window_info[j][WINDOW_X]+window_info[j][WINDOW_WIDTH]-width then
     draw=0
     mode=0
     end if
     if x<window_info[j][WINDOW_X] then
     draw=0
     mode=0
     end if
     if y+height>window_info[j][WINDOW_Y]+window_info[j][WINDOW_HEIGHT] then
     draw=0
     mode=0
     end if
     if y<window_info[j][WINDOW_Y] then
     draw=0
     mode=0
     end if
     end if
     end for
     if mode=1 then
     if length(text)>text_width then
       temp=text[screen_chr1..length(text)]
       if length(temp)<text_width then
         temp=temp[1..length(temp)]
       else
         temp=temp[1..text_width]
       end if
         draw_text({x+2,y+2},temp,0,7,0)
     else
       draw_text({x+2,y+2},text[screen_chr1..length(text)],0,7,0)
     end if
     if sel=1 then
     if key !=-1 then
     if key >2 and key <256 then
     if key!=128 and key!=64 and key!=27 and key!=16 and key!=13 and key!=8 and key!=4 then
     if chr1-(screen_chr1-1)=text_width then
     screen_chr1+=1
     end if
     text=string_insert(chr1,key,text)
     chr1+=1
     rectangle(x+2,y+1,x+width-1,y+19,7,1)
     line(x+2+(chr1-screen_chr1+1)*8,y+18,x+2+(chr1-screen_chr1+1)*8+8,y+18,0)
     end if
     end if
     if key=331 and chr1>0 then
     if length(text)>text_width and chr1-(screen_chr1)+1=0 then
     screen_chr1-=1
     end if
     chr1-=1
     rectangle(x+2,y+1,x+width-1,y+19,7,1)
     line(x+2+(chr1-screen_chr1+1)*8,y+18,x+2+(chr1-screen_chr1+1)*8+8,y+18,0)
     end if
     if key=333 and chr1<length(text) then
     if chr1-(screen_chr1-1)=text_width and length(text)>text_width then
     screen_chr1+=1
     end if
     chr1+=1
     rectangle(x+2,y+1,x+width-1,y+19,7,1)
     line(x+2+(chr1-screen_chr1+1)*8,y+18,x+2+(chr1-screen_chr1+1)*8+8,y+18,0)
     end if
     if key=8 and chr1>=1 then
     if length(text)>text_width and chr1-(screen_chr1)+1=0 then
     screen_chr1-=2
     elsif length(text)>text_width and screen_chr1>1 then
     screen_chr1-=1
     end if
     text=remove_string(chr1,text)
     chr1-=1
     rectangle(x+2,y+1,x+width-1,y+19,7,1)
     line(x+2+(chr1-screen_chr1+1)*8,y+18,x+2+(chr1-screen_chr1+1)*8+8,y+18,0)
     end if
     if key=339 and chr1>=0 and chr1!=length(text) then
     text=remove_string(chr1+1,text)
     rectangle(x+2,y+1,x+width-1,y+19,7,1)
     line(x+2+(chr1-screen_chr1+1)*8,y+18,x+2+(chr1-screen_chr1+1)*8+8,y+18,0)
     end if
     if key=13 then
     sel=0
     end if
     end if
     else
     if mouse_x>x and mouse_x<x+width and mouse_y>y and mouse_y<y+height and mouse_button=mb_left then
     for j=1 to length(textbox_info) do
     textbox_info[j][6]=0
     end for
     for j=1 to length(richedit_info) do
     richedit_info[j][18]=0
     end for
     sel=1
     draw=1
     draw_a_window=window_id
     mouse_button=0
     end if
     end if
     end if
     if draw=1 then
       rectangle(x,y,x+width,y+height,7,1)
       rectangle(x,y,x+width,y+height,0,0)
       rectangle(x+1,y+1,x+width-1,y+height-1,WHITE,1)
       if sel=1 then
       rectangle(x+2,y+1,x+width-1,y+19,7,1)
       line(x+2+(chr1-screen_chr1+1)*8,y+18,x+2+(chr1-screen_chr1+1)*8+8,y+18,0)
       end if
       if length(text)>text_width then
       temp=text[screen_chr1..length(text)]
       if length(temp)<text_width then
       temp=temp[1..length(temp)]
       else
       temp=temp[1..text_width]
       end if
       draw_text({x+2,y+2},temp,0,7,0)
       else
       draw_text({x+2,y+2},text[screen_chr1..length(text)],0,7,0)
       end if
       draw=0
     end if
     end if
     textbox_info[i][5]=text
     textbox_info[i][6]=sel
     textbox_info[i][7]=chr1
     textbox_info[i][8]=temp
     textbox_info[i][9]=screen_chr1
     textbox_info[i][10]=draw
     textbox_info[i][11]=mode
  end for
end procedure

procedure richedit(atom id)
atom line1,chr1,x,y,width,height,draw,mode,window_id
atom number1,number2,init,text_height,can,screen_chr1,text_width,temp_p,sel
sequence text,temp
for l=1 to length(richedit_info) do
    x=richedit_info[l][1]
    y=richedit_info[l][2]
    width=richedit_info[l][3]
    text_width=floor((width-8)/8)-1
    height=richedit_info[l][4]
    text_height=height/18
    text_height-=3
    text=richedit_info[l][5]
    chr1=richedit_info[l][6]
    line1=richedit_info[l][7]
    draw=richedit_info[l][8]
    mode=richedit_info[l][9]
    number1=richedit_info[l][10]
    number2=richedit_info[l][11]
    init=richedit_info[l][12]
    can=richedit_info[l][13]
    screen_chr1=richedit_info[l][14]
    temp_p=richedit_info[l][15]
    window_id=richedit_info[l][16]
    sel=richedit_info[l][18]
     if window_id=id then
     if init=1 then
       if length(text)>text_height then
         number2=length(text)-text_height
         number2+=temp_p-1
       can=1
       init=0
     end if
     end if
     for j=1 to length(window_info) do
     if window_info[j][WINDOW_ID]=id then
     x+=window_info[j][WINDOW_X]
     y+=window_info[j][WINDOW_Y]+20
     if j=length(window_info) then
     mode=1
     else
     mode=0
     end if
     if x>window_info[j][WINDOW_X]+window_info[j][WINDOW_WIDTH]-width then
     draw=0
     mode=0
     end if
     if x<window_info[j][WINDOW_X] then
     draw=0
     mode=0
     end if
     if y+(text_height+2)*18>window_info[j][WINDOW_Y]+window_info[j][WINDOW_HEIGHT]-20 then
     draw=0
     mode=0
     end if
     if y<window_info[j][WINDOW_Y]+20 then
     draw=0
     mode=0
     end if
     end if
     end for
     if mode=1  then
     if mouse_x>x and mouse_x<x+width and mouse_y>y and mouse_y<y+height and mouse_button =mb_left then
       for j=1 to length(richedit_info) do
          richedit_info[j][18]=0
       end for
       for j=1 to length(textbox_info) do
         textbox_info[j][6]=0
       end for
         sel=1
         draw=1
         draw_a_window=window_id
     end if
     if sel=1 then
     for i=number1 to length(text)-number2 do
       if length(text[i])>0 and screen_chr1<=length(text[i]) then
         if length(text[i])>text_width then
           temp=text[i][screen_chr1..length(text[i])]
           if length(temp)<text_width then
             temp=temp[1..length(temp)]
           else
             temp=temp[1..text_width]
           end if
           if length(temp)>0 then
             draw_text({x,y+19*(i-number1+1)-18},temp,BLACK,7,0)
           end if
         else
           draw_text({x,y+19*(i-number1+1)-18},text[i][screen_chr1..length(text[i])],BLACK,7,0)
         end if
       end if
     end for

     if key=335 then
       rectangle(x,y,x+width-1,y+height-1,WHITE,1)
       chr1=length(text[line1])
        if chr1>text_width then
          screen_chr1=chr1-text_width+1
        end if
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
     end if

     if key=329 then
       rectangle(x,y,x+width-1,y+height-1,WHITE,1)
        if line1>1+text_height then
         line1-=8
         number1-=8
         temp_p+=8
        end if
       chr1=1
       screen_chr1=1
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
     end if

     if key=337 then
       rectangle(x,y,x+width-1,y+height-1,WHITE,1)
        if line1<length(text)-text_height then
         line1+=8
         number1+=8
         temp_p-=8
        end if
       chr1=1
       screen_chr1=1
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
     end if

     if key=327 then
       rectangle(x,y,x+width-1,y+height-1,WHITE,1)
       chr1=1
       screen_chr1=1
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
      end if

     if key=328 and line1>1 then
      rectangle(x,y,x+width-1,y+height-1,WHITE,1)
      if number1>1 and line1-number1+1=1 then
         number1-=1
         temp_p+=1
       end if
       line1-=1
       if length(text[line1])>= chr1 then
       else
         chr1=length(text[line1])
          if chr1>text_width then
            screen_chr1=chr1-text_width+1
          else
          screen_chr1=1
          end if
       end if
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+chr1*8,y+19*(line1-number1+1)}})
     end if

     if key=336 and line1<length(text) then
       rectangle(x,y,x+width-1,y+height-1,WHITE,1)
       if line1-number1+1>=text_height then
         number1+=1
         temp_p-=1
       end if
       line1+=1
       if length(text[line1])>= chr1 then
       else
         chr1=length(text[line1])
          if chr1>text_width then
            screen_chr1=chr1-text_width+1
          else
          screen_chr1=1
          end if
       end if
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
     end if

     if key=331 and chr1>0 then
       rectangle(x,y,x+width-1,y+height-1,WHITE,1)
       if length(text[line1])>text_width and chr1-(screen_chr1)+1=0 then
         screen_chr1-=1
       end if
       draw_line(WHITE,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
       chr1-=1
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
     end if

     if key=333 and chr1<length(text[line1]) then
       rectangle(x,y,x+width-1,y+height-1,WHITE,1)
       if chr1-(screen_chr1-1)=text_width and length(text[line1])>text_width then
         screen_chr1+=1
       end if
       draw_line(WHITE,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
       chr1+=1
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
     end if

     if key >2 and key <256 then
       if key!=128 and key!=64 and key!=27 and key!=y and key!=13 and key!=8 and key!=4 then
         rectangle(x,y,x+width-1,y+height-1,WHITE,1)
         if chr1-(screen_chr1-1)=text_width then
           screen_chr1+=1
         end if
         text[line1]=string_insert(chr1,key,text[line1])
         draw_line(WHITE,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
         chr1+=1
         draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
       end if
     end if

     if key=8 then
      if chr1>0 then
        if length(text[line1])>text_width and chr1-(screen_chr1)+1=0 then
          screen_chr1-=2
        elsif length(text[line1])>text_width and screen_chr1>1 then
          screen_chr1-=1
        end if
        text[line1]=remove_string(chr1,text[line1])
        draw_line(WHITE,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
        chr1-=1
        rectangle(x,y,x+width-1,y+height-1,WHITE,1)
        draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
        elsif chr1<0 and line1>1 then
          if line1-number1+1=1 and number1>1 then
            number1-=1
            temp_p+=1
          end if
          if line1-number1+1>2 and line1-number1+1<text_height and number1>1 then
            number1-=1
            temp_p+=1
          end if
          if line1-number1+1>=text_height and number1>1 then
            number1-=1
            temp_p+=1
          end if
         if length(text[line1-1])>0 then
          chr1=length(text[line1-1])
          text[line1-1]&=text[line1]
          if chr1>text_width then
            screen_chr1=chr1-text_width+1
          end if
        else
         chr1=0
        text[line1-1]&=text[line1]
        end if
         text=remove_line(text,line1)
        draw_line(WHITE,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
        line1-=1
        rectangle(x,y,x+width-1,y+height-1,WHITE,1)
        draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
      elsif line1>1 then
          chr1-=1
      end if
     end if

--     if key=339 then
--      if chr1>=0 and chr1!=length(text[line1]) then
--         text[line1]=remove_string(chr1+1,text[line1])
--         draw_line(WHITE,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
--         rectangle(x,y,x+width-1,y+height-1,WHITE,1)
--         draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
--       elsif chr1=length(text[line1]) then
--         if line1<length(text) then
--           text[line1]&=text[line1+1]
--           text=remove_line(text,line1+1)
--           draw_line(WHITE,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
--           rectangle(x,y,x+width-1,y+height-1,WHITE,1)
--           draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
--         end if
--       end if
--     end if

     if key=13 then
       screen_chr1=1
       if line1-number1+1>=text_height then
         number1+=1
         temp_p-=1
       end if
       text=add_line(text,line1)
       if chr1=length(text[line1]) then
         chr1=0
       else
         text[line1+1]=text[line1][chr1+1..length(text[line1])]
         text[line1]=text[line1][1..chr1]
         chr1=0
       end if
       draw_line(WHITE,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
       line1+=1
       rectangle(x,y,x+width-1,y+height-1,WHITE,1)
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
     end if
     end if
     end if
    if draw=1 then
      rectangle(x-1,y-1,x+width,y+height,7,1)
      rectangle(x-1,y-1,x+width,y+height,0,0)
      rectangle(x,y,x+width-1,y+height-1,WHITE,1)
      draw=0
     for i=number1 to length(text)-number2 do
       if length(text[i])>0 and screen_chr1<=length(text[i]) then
         if length(text[i])>text_width then
           temp=text[i][screen_chr1..length(text[i])]
           if length(temp)<text_width then
             temp=temp[1..length(temp)]
           else
             temp=temp[1..text_width]
           end if
           if length(temp)>0 then
             draw_text({x,y+19*(i-number1+1)-18},temp,BLACK,7,0)
           end if
         else
           draw_text({x,y+19*(i-number1+1)-18},text[i][screen_chr1..length(text[i])],BLACK,7,0)
         end if
       end if
     end for
     if sel=1 then
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
     end if
    end if
    end if
  richedit_info[l][5]=text
  richedit_info[l][6]=chr1
  richedit_info[l][7]=line1
  richedit_info[l][8]=draw
  richedit_info[l][9]=mode
  richedit_info[l][10]=number1
  richedit_info[l][11]=number2
--  richedit_info[l][12]=init
  richedit_info[l][13]=can
  richedit_info[l][14]=screen_chr1
  richedit_info[l][15]=temp_p
  richedit_info[l][18]=sel
end for
end procedure

procedure box(atom id)
atom x,y,width,height,window_id,draw,mode,sel,temp
  for i=1 to length(box_info) do
     x=box_info[i][1]
     y=box_info[i][2]
     width=box_info[i][3]
     height=box_info[i][4]
     sel=box_info[i][5]
     draw=box_info[i][6]
     mode=box_info[i][7]
     window_id=box_info[i][8]
     temp=box_info[i][10]
     if window_id=id then
     for j=1 to length(window_info) do
     if window_info[j][WINDOW_ID]=id then
     x+=window_info[j][WINDOW_X]
     y+=window_info[j][WINDOW_Y]+20
     if j=length(window_info) then
     mode=1
     else
     mode=0
     end if
     if x>window_info[j][WINDOW_X]+window_info[j][WINDOW_WIDTH]-width then
     draw=0
     mode=0
     end if
     if x<window_info[j][WINDOW_X] then
     draw=0
     mode=0
     end if
     if y+height>window_info[j][WINDOW_Y]+window_info[j][WINDOW_HEIGHT] then
     draw=0
     mode=0
     end if
     if y<window_info[j][WINDOW_Y] then
     draw=0
     mode=0
     end if
     end if
     end for
     if mode=1 then
       if mouse_x>x and mouse_x<x+width and mouse_y>y and mouse_y<y+height and mouse_button=1 then
         if sel=1 then
           sel=0
           temp=1
           draw=1
         else
           sel=1
           temp=1
           draw=1
         end if
         mouse_button=0
       end if
     end if
     if draw=1 then
       rectangle(x,y,x+width,y+height,-1,1)
       rectangle(x+1,y+1,x+width-1,y+height-1,7,0)
       rectangle(x,y,x+width,y+height,0,0)
       if sel=1 then
         line(x+4,y+9,x+8,y+12,0)
         line(x+8,y+12,x+12,y+4,0)
         line(x+3,y+8,x+7,y+11,0)
         line(x+7,y+11,x+11,y+3,0)
       end if
       draw=0
     end if
     end if
     box_info[i][5]=sel
     box_info[i][6]=draw
     box_info[i][7]=mode
     box_info[i][10]=temp
  end for
end procedure

procedure lable(atom id)
atom x,y,width,height,window_id,draw,mode
sequence text
  for i=1 to length(lable_info)  do
     x=lable_info[i][1]
     y=lable_info[i][2]
     width=lable_info[i][3]
     height=lable_info[i][4]
     text=lable_info[i][5]
     width=length(text)*8
     draw=lable_info[i][6]
     mode=lable_info[i][7]
     window_id=lable_info[i][8]

     if window_id=id then
     for j=1 to length(window_info) do
     if window_info[j][WINDOW_ID]=id then
     x+=window_info[j][WINDOW_X]
     y+=window_info[j][WINDOW_Y]+20
     if j=length(window_info) then
     mode=1
     else
     mode=0
     end if
     if x>window_info[j][WINDOW_X]+window_info[j][WINDOW_WIDTH]-width then
     draw=0
     mode=0
     end if
     if x<window_info[j][WINDOW_X] then
     draw=0
     mode=0
     end if
     if y+height>window_info[j][WINDOW_Y]+window_info[j][WINDOW_HEIGHT] then
     draw=0
     mode=0
     end if
     if y<window_info[j][WINDOW_Y] then
     draw=0
     mode=0
     end if
     end if
     end for
     if mode=1 then

     end if
     if draw=1 then
       draw_text({x,y},text,0,7,0)
       draw=0
     end if
     end if
    lable_info[i][3]=width
    lable_info[i][6]=draw
    lable_info[i][7]=mode
  end for
end procedure

global procedure menu(atom id)
atom width,sel,open,number,sel2,x,y,init,draw,mode,window_id
sequence menu_width,menu_width2,string,can
for l=1 to length(menu_info) do
   x=menu_info[l][1]
   y=menu_info[l][2]
   string=menu_info[l][3]
   width=menu_info[l][4]
   sel=menu_info[l][5]
   sel2=menu_info[l][6]
   number=menu_info[l][7]
   open=menu_info[l][8]
   menu_width=menu_info[l][9]
   menu_width2=menu_info[l][10]
   can=menu_info[l][11]
   init=menu_info[l][12]
   draw=menu_info[l][13]
   mode=menu_info[l][14]
   window_id=menu_info[l][15]

     if window_id=id then
     for j=1 to length(window_info) do
     if window_info[j][WINDOW_ID]=id then
     x+=window_info[j][WINDOW_X]
     y+=window_info[j][WINDOW_Y]+20
     if j=length(window_info) then
     mode=1
     else
     mode=0
     end if
     if x>window_info[j][WINDOW_X]+window_info[j][WINDOW_WIDTH]-width then
     draw=0
     mode=0
     end if
     if x<window_info[j][WINDOW_X] then
     draw=0
     mode=0
     end if
     if y+20>window_info[j][WINDOW_Y]+window_info[j][WINDOW_HEIGHT] then
     draw=0
     mode=0
     end if
     if y<window_info[j][WINDOW_Y] then
     draw=0
     mode=0
     end if
     end if
     end for

   if init=1 then
   for i=1 to length(string) do
      menu_width=append(menu_width,length(string[i][1])+1)
      for j=2 to length(string[i]) do
         if j=2 then
           menu_width2=append(menu_width2,length(string[i][j]))
         end if
         if length(string[i][j])>menu_width2[i+1] then
           menu_width2[i+1]=length(string[i][j])
         end if
      end for
   end for
   init=0
   end if

   if mode=1 then
     for i=1 to length(string) do
        width+=menu_width[i]*8
        if mouse_x>x+width and mouse_x<x+width+menu_width[i+1]*8 and mouse_y>y+2 and mouse_y<y+20 then
          sel=i
        else
          sel=0
        end if
       if mouse_x>x+width and mouse_x<x+width+menu_width[i+1]*8 and mouse_y>y+2 and mouse_y<y+20 and mouse_button=mb_left then
         draw_a_window=id
         open=1
         number=i
         mouse_button=0
       end if

    if i=sel then
     -- rectangle(x+width,y,x+width+menu_width[i+1]*8-4,y+20,9,1)
      draw_text({x+2+width,y+2},string[i][1],BLACK,9,0)
   else
    -- rectangle(x+width,y,x+width+menu_width[i+1]*8,y+20,WHITE,1)
     draw_text({x+2+width,y+2},string[i][1],BLACK,WHITE,0)
   end if
   if open=1 and number=i then
    -- rectangle(x+width,y+20,x+width+(menu_width2[i+1]+1)*8,y+20+(length(string[i])-1)*20,WHITE,1)
     for j=2 to length(string[i]) do
        if mouse_x>x+width and mouse_x<x+width+(menu_width2[i+1]+1)*8 and mouse_y>y+20*j-20 and mouse_y<y+20*j then
          sel2=j
        else
          sel2=0
        end if
        if mouse_x>x+width and mouse_x<x+width+(menu_width2[i+1]+1)*8 and mouse_y>y+20*j-20 and mouse_y<y+20*j and mouse_button=mb_left then
          can=string[i][j]
          draw_a_window=id
        end if
        if j=sel2 then
      --    rectangle(x+width,y+20*j-20,x+width+(menu_width2[i+1]+1)*8,y+20*j,9,1)
          draw_text({x+2+width,y+20*j-20},string[i][j],BLACK,9,0)
        else
          draw_text({x+2+width,y+20*j-20},string[i][j],BLACK,WHITE,0)
        end if
    end for
  end if
 end for
   width=0
   if mouse_button=mb_left then
     draw_a_window=id
     open=0
   end if
   end if
   if draw=1 then
     for i=1 to length(string) do
        width+=menu_width[i]*8
        if i=sel then
        else
        rectangle(x+width,y,x+width+menu_width[i+1]*8,y+20,WHITE,1)
        draw_text({x+2+width,y+2},string[i][1],BLACK,WHITE,0)
        end if
     end for
     draw=0
     width=0
   end if
   end if
   menu_info[l][4]=width
   menu_info[l][5]=sel
   menu_info[l][6]=sel2
   menu_info[l][7]=number
   menu_info[l][8]=open
   menu_info[l][9]=menu_width
   menu_info[l][10]=menu_width2
   menu_info[l][11]=can
   menu_info[l][12]=init
   menu_info[l][13]=draw
   menu_info[l][14]=mode
end for
end procedure

procedure listview(atom id)
atom x,y,width,height,number1,number2,init,color,can,sel,text_height
atom draw,mode,window_id
sequence string,temp
  for i=1 to length(listview_info) do
     x=listview_info[i][1]
     y=listview_info[i][2]
     width=listview_info[i][3]
     height=listview_info[i][4]
     text_height=height/16
     number1=listview_info[i][5]
     number2=listview_info[i][6]
     string=listview_info[i][7]
     init=listview_info[i][8]
     can=listview_info[i][9]
     sel=listview_info[i][10]
     temp=listview_info[i][11]
     draw=listview_info[i][12]
     mode=listview_info[i][13]
     window_id=listview_info[i][14]

     if window_id=id then
     for j=1 to length(window_info) do
     if window_info[j][WINDOW_ID]=id then
     x+=window_info[j][WINDOW_X]
     y+=window_info[j][WINDOW_Y]+20
     if j=length(window_info) then
     mode=1
     else
     mode=0
     end if
     if x>window_info[j][WINDOW_X]+window_info[j][WINDOW_WIDTH]-width then
     draw=0
     mode=0
     end if
     if x<window_info[j][WINDOW_X] then
     draw=0
     mode=0
     end if
     if y+height>window_info[j][WINDOW_Y]+window_info[j][WINDOW_HEIGHT] then
     draw=0
     mode=0
     end if
     if y<window_info[j][WINDOW_Y] then
     draw=0
     mode=0
     end if
     end if
     end for
     if init=1 then
       if length(string)>text_height then
         number2=length(string)-text_height
         can=1
       end if
       init=0
     end if
     if mode=1 then
     if mouse_x>x+width+1 and mouse_x<x+width+10 and mouse_y>y and mouse_y<y+10 and number1>1 and mouse_button=mb_left then
       rectangle(x+1,y+1,x+width-1,y+height-1,7,1)
       number1-=1
       number2+=1
       mouse_button=0
     end if
     if mouse_x>x+width+1 and mouse_x<x+width+10 and mouse_y>y+height-10 and mouse_y<y+height and number2>0 and mouse_button=mb_left then
        rectangle(x+1,y+1,x+width-1,y+height-1,7,1)
        number1+=1
        number2-=1
        mouse_button=0
     end if
     for j=number1 to length(string)-number2 do
        color=7
        if mouse_x>x and mouse_x<x+width and mouse_y>y+(16*(j-number1)) and mouse_y<y+(16*(j-number1))+16 and mouse_button=mb_left then
          sel=j
          temp=string[j]
          mouse_button=0
          draw=1
        end if
        if j=sel then
          --rectangle(x+2,y+2+(16*(j-number1)),x+width-2,y+2+(16*(j-number1))+16,9,1)
          color=9
        end if
        draw_text({x+2,y+2+(16*(j-number1))},string[j],BLACK,color,0)
     end for
     end if
     if draw=1 then
       rectangle(x,y,x+width,y+height,7,1)
       rectangle(x,y,x+width,y+height,0,0)
       if can=1 then
         rectangle(x+width+1,y,x+width+10,y+height,GRAY,1)
         rectangle(x+width+1,y,x+width+10,y+10,0,1)
         rectangle(x+width+1,y+height-10,x+width+10,y+height,0,1)
       end if
     for j=number1 to length(string)-number2 do
        color=7
        if mouse_x>x and mouse_x<x+width and mouse_y>y+(16*(j-number1)) and mouse_y<y+(16*(j-number1))+16 and mouse_button=mb_left then
          sel=j
          temp=string[j]
          mouse_button=0
        end if
        if j=sel then
--          rectangle(x+2,y+2+(16*(j-number1)),x+width-2,y+2+(16*(j-number1))+16,9,1)
          color=9
        end if
        rectangle(x+2,y+2+(16*(j-number1)),x+width-2,y+2+(16*(j-number1))+16,7,1)
        draw_text({x+2,y+2+(16*(j-number1))},string[j],BLACK,color,0)
     end for
       draw=0
     end if
     end if
     listview_info[i][5]=number1
     listview_info[i][6]=number2
     listview_info[i][8]=init
     listview_info[i][9]=can
     listview_info[i][10]=sel
     listview_info[i][11]=temp
     listview_info[i][12]=draw
     listview_info[i][13]=mode
  end for
end procedure


procedure toolbar(atom id)
atom x,y,width,height,sel,window_id,draw,mode,temp_x,sel2
sequence string
temp_x=0
  for i=1 to length(toolbar_info)  do
     x=toolbar_info[i][1]
     y=toolbar_info[i][2]
     width=toolbar_info[i][3]
     height=toolbar_info[i][4]
     sel=toolbar_info[i][5]
     string=toolbar_info[i][6]
     draw=toolbar_info[i][7]
     mode=toolbar_info[i][8]
     sel2=toolbar_info[i][9]
     window_id=toolbar_info[i][10]

     if window_id=id then
     for j=1 to length(window_info) do
     if window_info[j][WINDOW_ID]=id then
     x+=window_info[j][WINDOW_X]
     y+=window_info[j][WINDOW_Y]+20
     width=window_info[j][WINDOW_WIDTH]-1
     height=30
     if j=length(window_info) then
     mode=1
     else
     mode=0
     end if
     if x>window_info[j][WINDOW_X]+window_info[j][WINDOW_WIDTH]-width then
     draw=0
     mode=0
     end if
     if x<window_info[j][WINDOW_X] then
     draw=0
     mode=0
     end if
     if y+height>window_info[j][WINDOW_Y]+window_info[j][WINDOW_HEIGHT] then
     draw=0
     mode=0
     end if
     if y<window_info[j][WINDOW_Y] then
     draw=0
     mode=0
     end if
     end if
     end for
     if mode=1 then
       for j=1 to length(string) do
          if mouse_x>x+2+temp_x+(20*(j-1)) and mouse_x<x+2+temp_x+(20*j) and mouse_y>y+2 and mouse_y<y+27 and mouse_button=mb_left then
            sel2=j
            mouse_button=0
          end if
          if mouse_x>x+2+temp_x+(20*(j-1)) and mouse_x<x+2+temp_x+(20*j) and mouse_y>y+2 and mouse_y<y+27 then
            if sel!=j then
              sel=j
              draw=1
            end if
          else
          if sel>0 and sel=j then
           sel=0
           draw=1
          end if
          end if
          temp_x+=10
       end for
       temp_x=0
     end if
     if draw=1 then
       rectangle(x,y,x+width,y+height,7,1)
       for j=1 to length(string) do
          if j=sel then
            display_image({x+2+temp_x+(20*(j-1)),y+2},string[j][2])
          else
            display_image({x+2+temp_x+(20*(j-1)),y+2},string[j][1])
          end if
         temp_x+=10
       end for
       draw=0
       temp_x=0
     end if
     end if
    toolbar_info[i][5]=sel
    toolbar_info[i][7]=draw
    toolbar_info[i][8]=mode
    toolbar_info[i][9]=sel2
  end for
end procedure

procedure fileview(atom id)
integer x,y,width,height,draw,mode,init,window_id
integer file_width,file_height,number1,number2,sel
integer pressed_left,pressed_right,pos
integer temp_x,temp_y,temp2
atom temp_mx,temp_my,timer1,t0
sequence files,varbs,path,click_on,sel_name,temp
sequence command1,command2,command3
temp2=1
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
     window_id=fileview_info[i][FILEVIEW_WINDOW_ID]

     if init=1 then
       file_width=width/100
       file_height=height/50
       temp_x=0
       temp_y=0
       for j=1 to length(files) do
          for k=1 to length(file_names) do
             for l=1 to length(files[j]) do
                if files[j][l]='.' then
                  if compare(file_names[k],files[j][l+1..length(files[j])])=0 then
                    temp2=k
                    exit
                  end if
                end if
             end for
            if temp2>1 then
              exit
            end if
          end for
          varbs=append(varbs,{4+temp_x,4+temp_y,files[j],temp2})
          temp2=1
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

     if window_id=id then
     for j=1 to length(window_info) do
     if window_info[j][WINDOW_ID]=id then
     x+=window_info[j][WINDOW_X]
     y+=window_info[j][WINDOW_Y]+20
     if j=length(window_info) then
     mode=1
     else
     mode=0
     end if
     if x>window_info[j][WINDOW_X]+window_info[j][WINDOW_WIDTH]-width then
     draw=0
     mode=0
     end if
     if x<window_info[j][WINDOW_X] then
     draw=0
     mode=0
     end if
     if y+20>window_info[j][WINDOW_Y]+window_info[j][WINDOW_HEIGHT] then
     draw=0
     mode=0
     end if
     if y<window_info[j][WINDOW_Y] then
     draw=0
     mode=0
     end if
     end if
     end for

     if mode=1 then
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
        if mouse_x>x+varbs[j][1]+25 and mouse_x<x+varbs[j][1]+50 and mouse_y>y+varbs[j-number1+1][2] and mouse_y<y+varbs[j-number1+1][2]+25 and mouse_button=mb_left then
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
      draw_all=window_id
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
         draw_all=window_id
       end if
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
--        rectangle(varbs[j][1],varbs[j-number1+1][2],varbs[j][1]+100,varbs[j-number1+1][2]+50,RED,1)
          draw_text({x+varbs[j][1],y+varbs[j-number1+1][2]+30},varbs[j][3],0,RED,0)
          display_image({x+varbs[j][1]+25,y+varbs[j-number1+1][2]},file_images[varbs[j][4]])
          elsif sel!=j then
          rectangle(x+varbs[j][1],y+varbs[j-number1+1][2],x+varbs[j][1]+100,y+varbs[j-number1+1][2]+50,-1,1)
          draw_text({x+varbs[j][1],y+varbs[j-number1+1][2]+30},varbs[j][3],0,-1,0)
          display_image({x+varbs[j][1]+25,y+varbs[j-number1+1][2]},file_images[varbs[j][4]])
          end if
       end for
       if pressed_left=2 then
         draw_text({mouse_x,mouse_y+30},varbs[sel][3],0,RED,0)
         display_image({mouse_x+25,mouse_y},file_images[varbs[sel][4]])
       end if
       draw=0
     end if
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


procedure window()
atom x,y,width,height,draw,mode,work,temp,temp_x,temp_y,temp_m_x,temp_m_y
atom background_color,close2,min
sequence window_name
  for i=1 to length(window_info) do
     x=window_info[i][WINDOW_X]
     y=window_info[i][WINDOW_Y]
     width=window_info[i][WINDOW_WIDTH]
     height=window_info[i][WINDOW_HEIGHT]
     window_name=window_info[i][WINDOW_BAR_TEXT]
     draw=window_info[i][WINDOW_DRAW]
     mode=window_info[i][WINDOW_MODE]
     temp=window_info[i][WINDOW_TEMP]
     temp_x=window_info[i][WINDOW_TEMP_X]
     temp_y=window_info[i][WINDOW_TEMP_Y]
     temp_m_x=window_info[i][WINDOW_TEMP_MX]
     temp_m_y=window_info[i][WINDOW_TEMP_MY]
     min=window_info[i][WINDOW_MIN]
     close2=window_info[i][WINDOW_CLOSE]
     work=window_info[i][WINDOW_WORK]
     background_color=window_info[i][WINDOW_BACKGROUND_COLOR]
     if work=1 then
     if i=length(window_info) then
     mode=1
     else
     mode=0
     end if
     if get_button=3 then
     temp=0
     mouse_button=0
     end if
     if mode=0 then
     if mouse_x>x and mouse_x<x+width and mouse_y>y and mouse_y<y+height and mouse_button=mb_left then
     if clear(mouse_x,mouse_y,window_info[i][WINDOW_ID])=1 and on_click_window_bar(mouse_x,mouse_y)=0 then
     draw_all=window_info[i][WINDOW_ID]
     end if
     if mouse_y>y and mouse_y<y+20 then
     if mouse_over_window(mouse_x,mouse_y)=0 then
     draw_all=window_info[i][WINDOW_ID]
     temp=1
     temp_x=mouse_x-x
     temp_y=mouse_y-y
     temp_m_x=mouse_x
     temp_m_y=mouse_y
     end if
     end if
     end if
     else
     if mouse_x>x+width-16 and mouse_x<x+width-2 and mouse_y>y and mouse_y<y+20 and mouse_button=mb_left then
       close2=1
     end if
     if mouse_x>x+width-32 and mouse_x<x+width-18 and mouse_y>y and mouse_y<y+20 and mouse_button=mb_left then
       min=1
     end if
     if mouse_x>x and mouse_x<x+width-34 and mouse_y>y and mouse_y<y+20 and mouse_button=mb_left and temp=0 then
     draw_all=window_info[i][WINDOW_ID]
     temp=1
     temp_x=mouse_x-x
     temp_y=mouse_y-y
     temp_m_x=mouse_x
     temp_m_y=mouse_y
     mouse_button=0
     end if
     if temp=1 then
     if temp_m_x!=mouse_x or temp_m_y!=mouse_y then
     temp_m_x=mouse_x
     temp_m_y=mouse_y
     temp=2
     end if
     end if
     if temp=2 then
     window_info[i][WINDOW_X]=mouse_x-temp_x
     window_info[i][WINDOW_Y]=mouse_y-temp_y
     temp=1
     draw_all=window_info[i][WINDOW_ID]
     end if
     end if
     if draw=1 then
     if mode=1 then
     rectangle(x,y,x+width,y+20,WINDOW_SELETE_COLOR,1)
     rectangle(x,y,x+width,y+20,0,0)
     draw_text({x+2,y+2},window_name,0,WINDOW_SELETE_COLOR,0)
     rectangle(x+width-16,y+2,x+width-2,y+18,WINDOW_DESELETE_COLOR,1)
     rectangle(x+width-16,y+2,x+width-2,y+18,0,0)
     line(x+width-4,y+4,x+width-14,y+16,0)
     line(x+width-14,y+4,x+width-4,y+16,0)
     rectangle(x+width-32,y+2,x+width-18,y+18,WINDOW_DESELETE_COLOR,1)
     rectangle(x+width-32,y+2,x+width-18,y+18,0,0)
     line(x+width-30,y+10,x+width-20,y+10,0)
     else
     rectangle(x,y,x+width,y+20,WINDOW_DESELETE_COLOR,1)
     rectangle(x,y,x+width,y+20,0,0)
     draw_text({x+2,y+2},window_name,0,WINDOW_DESELETE_COLOR,0)
     end if
     if mode=3 then
     rectangle(x+width-16,y+2,x+width-2,y+18,7,1)
     rectangle(x+width-16,y+2,x+width-2,y+18,0,0)
     line(x+width-4,y+4,x+width-14,y+16,0)
     line(x+width-14,y+4,x+width-4,y+16,0)
     end if  
     rectangle(x,y+20,x+width,y+height,background_color,1)
     rectangle(x,y+20,x+width,y+height,0,0)
     draw=0
     end if
     button(window_info[i][WINDOW_ID])
     combox(window_info[i][WINDOW_ID])
     richedit(window_info[i][WINDOW_ID])
     lable(window_info[i][WINDOW_ID])
     textbox(window_info[i][WINDOW_ID])
     listview(window_info[i][WINDOW_ID])
     menu(window_info[i][WINDOW_ID])
     box(window_info[i][WINDOW_ID])
     toolbar(window_info[i][WINDOW_ID])
     fileview(window_info[i][WINDOW_ID])
     end if
     window_info[i][WINDOW_DRAW]=draw
     window_info[i][WINDOW_TEMP]=temp
     window_info[i][WINDOW_TEMP_X]=temp_x
     window_info[i][WINDOW_TEMP_Y]=temp_y
     window_info[i][WINDOW_TEMP_MX]=temp_m_x
     window_info[i][WINDOW_TEMP_MY]=temp_m_y
     window_info[i][WINDOW_MIN]=min
     window_info[i][WINDOW_CLOSE]=close2
     window_info[i][WINDOW_WORK]=work
     window_info[i][WINDOW_BACKGROUND_COLOR]=background_color
  end for
end procedure

atom temp_x,temp_y
sequence s
s={}
temp_x=0
temp_y=0
procedure draw_mouse()
  if temp_x!=mouse_x or temp_y!=mouse_y then
    display_image({temp_x,temp_y},s)
    s=save_image({mouse_x,mouse_y},{mouse_x+5,mouse_y+5})
    rectangle(mouse_x,mouse_y,mouse_x+5,mouse_y+5,0,1)
    temp_x=mouse_x
    temp_y=mouse_y
  end if
end procedure

procedure workbar()
atom x,y,width,draw
sequence string,info
  x=workbar_info[1]
  y=workbar_info[2]
  width=workbar_info[3]
  draw=workbar_info[4]
  string=workbar_info[5]
  info=workbar_info[6]

  for i=1 to length(window_info) do
     if window_info[i][WINDOW_MIN]=1 then
       window_info[i][WINDOW_MIN]=0
       window_info[i][WINDOW_WORK]=0
       for j=1 to length(window_info) do
            if window_info[j][WINDOW_WORK]=1 then
              draw_all=window_info[j][WINDOW_ID]
              exit
          end if
       end for
       string=append(string,window_info[i][WINDOW_BAR_TEXT])
       if length(string)=length(window_info) then
         rectangle(1,1,800,600,-1,1)
       end if
       info=append(info,window_info[i][WINDOW_ID])
       draw=1
       exit
     end if
  end for
  for i=1 to length(string) do
     if mouse_x>4+100*i-100 and mouse_x<4+100*i and mouse_y>y-22 and mouse_y<y-4 and mouse_button=mb_left then
       string=remove_line(string,i)
       for j=1 to length(window_info) do
          if window_info[j][WINDOW_ID]=info[i] then
            window_info[j][WINDOW_WORK]=1
            draw_all=window_info[j][WINDOW_ID]
            exit
          end if
       end for
       info=remove_line(info,i)
       mouse_button=0
       draw=1
     end if
  end for
  draw_text({580,580},date2(),0,9,0)
  if draw=1 then
    rectangle(x,y-25,x+width,y,9,1)
    rectangle(x,y-25,x+width,y,0,0)
    for i=1 to length(string) do
       rectangle(4+100*i-100,y-22,4+100*i,y-4,7,1)
       rectangle(4+100*i-100,y-22,4+100*i,y-4,0,0)
       draw_text({4+100*i-100,y-22},string[i],0,7,0)
    end for
    draw=0
  end if
  workbar_info[4]=draw
  workbar_info[5]=string
  workbar_info[6]=info
end procedure

global procedure show_msg(sequence msg, sequence msg2)
atom button_msg1,lable_msg1,window_msg1,temp
atom width, x, y
temp=close_window
width=100
width+=length(msg)*8
x=400-width/2
y=220
window_msg1=create_ex({"window",x,y,width-50,70,msg2})
button_msg1=create_ex({"button",width/2-50,30,"ok",window_msg1})
lable_msg1=create_ex({"lable",15,10,msg,window_msg1})
close_window=0
while 1 do
key=get_key()
mouse()
get_button=mouse_button
window()
workbar()
if draw_all>0 then
draw_all_windows(draw_all)
draw_all=0
end if
if sel_window>0 then
draw_all_windows(sel_window)
sel_window=0
end if
if draw_a_window>0 then
draw_window(draw_a_window)
draw_a_window=0
end if
draw_mouse()
if on_click({"button",button_msg1})=1 then
  close_window=temp
  delete_window(window_msg1)
  exit
end if
end while
end procedure

global function get_filename(sequence name)
atom test,temp2,x,y,width,window_1,button_1,button_2,listview_1,textbox_1
sequence d,line,temp
test=0
d={}
line={}
temp={}
temp2=close_window
close_window=0
width=200
x=400
y=220
window_1=create_ex({"window",x,y,width,180,"Get Filename"})
button_1=create_ex({"button",110,110,"Ok",window_1})
button_2=create_ex({"button",110,135,"Cancle",window_1})
textbox_1=create_ex({"textbox",2,110,100,window_1})
  d = dir(current_dir())
  for i=1 to length(d) do
  test= compare(d[i][2],"d") 
  if test!=0 then
  line=append(line,d[i][1])
  end if
  end for
  if length(name)>0 then
    for i=1 to length(line) do
       for j=1 to length(line[i]) do
          if line[i][j]='.' then
            if compare(line[i][j..length(line[i])],"."&name)=0 then
              temp=append(temp,line[i])
            end if
          end if
        end for
     end for
     line=temp
   end if
   line=gaz_sort(line)
   temp=""
   listview_1=create_ex({"listview",2,2,170,100,line,window_1})
while 1 do
key=get_key()
mouse()
get_button=mouse_button
window()
workbar()
if draw_all>0 then
draw_all_windows(draw_all)
draw_all=0
end if
if sel_window>0 then
draw_all_windows(sel_window)
sel_window=0
end if
if draw_a_window>0 then
draw_window(draw_a_window)
draw_a_window=0
end if
draw_mouse()
if on_click({"listview",listview_1})=1 then
  set_text({"textbox",textbox_1,get_text({"listview",listview_1})})
end if
if on_click({"button",button_1})=1 then
  temp=get_text({"textbox",textbox_1})
  close_window=temp2
  delete_window(window_1)
  return temp
end if
if on_click({"button",button_2})=1 then
  close_window=temp2
  delete_window(window_1)
  return ""
end if
end while
end function

global function show_menu(atom x,atom y,sequence string)
atom width,height,sel,draw
width=0
draw=1
sel=0
for i=1 to length(string) do
  if length(string[i])>width then
     width=length(string[i])
  end if
end for
width+=1
width=width*8
height=length(string)*18
while 1 do
key=get_key()
mouse()
get_button=mouse_button
window()
workbar()
if draw_all>0 then
draw_all_windows(draw_all)
draw_all=0
end if
if sel_window>0 then
draw_all_windows(sel_window)
sel_window=0
end if
if draw_a_window>0 then
draw_window(draw_a_window)
draw_a_window=0
end if
draw_mouse()
if draw=1 then
rectangle(x,y,x+width,y+height,WHITE,1)
rectangle(x,y,x+width,y+height,0,0)
draw=0
end if
for i=1 to length(string) do
   if mouse_x>x and mouse_x<x+width and mouse_y>y+18*i-18 and mouse_y<y+18*i and mouse_button=mb_left then
     mouse_button=0
     draw_all=1
     return string[i]
   end if
   if mouse_x>x and mouse_x<x+width and mouse_y>y+18*i-18 and mouse_y<y+18*i then
     sel=i
   else
     sel=0
   end if
   if sel=i then
-- rectangle(x,y+18*i-17,x+width,y+18*i,9,1)
   draw_text({x+6,y+18*i-17},string[i],BLACK,9,0)
   else
   draw_text({x+6,y+18*i-17},string[i],BLACK,WHITE,0)
   end if
end for
if mouse_button=mb_left then
  draw_all=1
  return ""
end if
end while
end function

global function show_q(sequence msg, sequence msg2)
atom button_msg1,lable_msg1,window_msg1,button_msg2,temp
atom width, x, y
temp=close_window
width=100
width+=length(msg)*8
x=400-width/2
y=220
window_msg1=create_ex({"window",x,y,width-50,70,msg2})
button_msg1=create_ex({"button",width/2-20,30,"No",window_msg1})
button_msg2=create_ex({"button",width/2-70,30,"Yes",window_msg1})
lable_msg1=create_ex({"lable",15,10,msg,window_msg1})
close_window=0
while 1 do
key=get_key()
mouse()
get_button=mouse_button
window()
workbar()
if draw_all>0 then
draw_all_windows(draw_all)
draw_all=0
end if
if sel_window>0 then
draw_all_windows(sel_window)
sel_window=0
end if
if draw_a_window>0 then
draw_window(draw_a_window)
draw_a_window=0
end if
draw_mouse()
if on_click({"button",button_msg1})=1 then
  close_window=temp
  delete_window(window_msg1)
  return 0
end if
if on_click({"button",button_msg2})=1 then
  close_window=temp
  delete_window(window_msg1)
  return 1
end if
end while
end function
--main
rectangle(1,1,800,600,-1,1)

global procedure run()
mouse()
get_button=mouse_button
window()
workbar()
if draw_all>0 then
draw_all_windows(draw_all)
draw_all=0
end if
if sel_window>0 then
draw_all_windows(sel_window)
sel_window=0
end if
if draw_a_window>0 then
draw_window(draw_a_window)
draw_a_window=0
end if
draw_mouse()
end procedure
