without type_check
include graphics.e
include mouse2.e
include font.e

atom key, get_button,window_number,selete,draw_all
atom WINDOW_ID
WINDOW_ID=14
draw_all=0
get_button=0
sequence window_info
selete=1
window_number=1
window_info={}

if graphics_mode(258) then
end if

procedure line(atom x, atom y, atom xx, atom yy, atom color)
draw_line(color,{{x,y},{xx,yy}})
end procedure

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

procedure selete_window(atom id)
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
end procedure

global procedure draw_all_windows(atom id)
selete_window(id)
rectangle(1,1,800,600,-1,1)
for i=1 to length(window_info) do
   window_info[i][6]=1
end for
end procedure

function on_click_window_bar(atom xx, atom yy)
atom x,y,width,mode
mode=0
  for i=1 to length(window_info) do
     x=window_info[i][1]
     y=window_info[i][2]
     width=window_info[i][3]
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
     x=window_info[i][1]
     y=window_info[i][2]
     width=window_info[i][3]
     height=window_info[i][4]
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
     x=window_info[i][1]
     y=window_info[i][2]+20
     width=window_info[i][3]
     height=window_info[i][4]
     if id!=window_info[i][WINDOW_ID] then
       --left
       if xx<x then
         info=append(info,1)
       -- right
       elsif xx>x+width then
         info=append(info,1)
        -- top
        elsif yy<y then
         info=append(info,1)
        -- bottom
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

procedure window()
atom x,y,width,height,draw,mode,work,temp,temp_x,temp_y,temp_m_x,temp_m_y
sequence window_name
  for i=1 to length(window_info) do
     x=window_info[i][1]
     y=window_info[i][2]
     width=window_info[i][3]
     height=window_info[i][4]
     window_name=window_info[i][5]
     draw=window_info[i][6]
     mode=window_info[i][7]
     temp=window_info[i][8]
     temp_x=window_info[i][9]
     temp_y=window_info[i][10]
     temp_m_x=window_info[i][11]
     temp_m_y=window_info[i][12]
     work=window_info[i][13]

--if work=1 then
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
      end if
    end if
  end if
else
     if mouse_x>x and mouse_x<x+width-16 and mouse_y>y and mouse_y<y+20 and mouse_button=mb_left and temp=0 then
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
       window_info[i][1]=mouse_x-temp_x
       window_info[i][2]=mouse_y-temp_y
       temp=1
       draw_all=window_info[i][WINDOW_ID]
     end if
end if
     if draw=1 then
       rectangle(x,y,x+width,y+20,9,1)
       rectangle(x,y,x+width,y+20,0,0)
       draw_text({x+2,y+2},window_name,0,9,0)
       if mode=1 then
       rectangle(x+width-16,y+2,x+width-2,y+18,7,1)
       rectangle(x+width-16,y+2,x+width-2,y+18,0,0)
       line(x+width-4,y+4,x+width-14,y+16,0)
       line(x+width-14,y+4,x+width-4,y+16,0)
       end if  
       rectangle(x,y+20,x+width,y+height,-1,1)
       rectangle(x,y+20,x+width,y+height,0,0)
       draw=0
     end if
--end if
     window_info[i][6]=draw
     window_info[i][8]=temp
     window_info[i][9]=temp_x
     window_info[i][10]=temp_y
     window_info[i][11]=temp_m_x
     window_info[i][12]=temp_m_y
     window_info[i][13]=work
  end for
end procedure

window_info=append(window_info,{10,10,300,300,"window1",1,1,0,0,0,0,0,1,window_number})
window_number+=1
window_info=append(window_info,{310,10,300,300,"window2",1,1,0,0,0,0,0,1,window_number})
window_number+=1
window_info=append(window_info,{10,310,300,300,"window3",1,1,0,0,0,0,0,1,window_number})

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
if draw_all>0 then
draw_all_windows(draw_all)
draw_all=0
end if

window()
end while
