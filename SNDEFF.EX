without type_check
without warning
include graphics.e
include image.e
include font.e
include get.e
include mouse2.e
include file.e
include sort.e
include wildcard.e

if graphics_mode(18) then
end if

procedure line(atom x,atom y,atom xx,atom yy,atom color)
  draw_line(color, {{x, y}, {xx, yy}})
end procedure

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
 polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

sequence button_info,button_image_info,listview_info,textbox_info
integer button_number,button_image_number,listview_number,textbox_number,key
button_info={}
button_number=0
button_image_info={}
button_image_number=0
listview_info={}
listview_number=0
textbox_number=0
textbox_info={}

constant BUTTON_X=1
constant BUTTON_Y=2
constant BUTTON_WIDTH=3
constant BUTTON_SEL=4
constant BUTTON_NAME=5
constant BUTTON_DRAW=6
constant BUTTON_WORK=7
constant BUTTON_ID=8

constant BUTTON_IMAGE_X=1
constant BUTTON_IMAGE_Y=2
constant BUTTON_IMAGE_SEL=3
constant BUTTON_IMAGE_IMAGES=4
constant BUTTON_IMAGE_DRAW=5
constant BUTTON_IMAGE_WORK=6
constant BUTTON_IMAGE_ID=7

constant LISTVIEW_X=1
constant LISTVIEW_Y=2
constant LISTVIEW_WIDTH=3
constant LISTVIEW_HEIGHT=4
constant LISTVIEW_DRAW=5
constant LISTVIEW_INIT=6
constant LISTVIEW_STRING=7
constant LISTVIEW_WORK=8
constant LISTVIEW_SEL=9
constant LISTVIEW_SELNAME=10
constant LISTVIEW_NUMBER1=11
constant LISTVIEW_NUMBER2=12
constant LISTVIEW_CAN=13
constant LISTVIEW_ID=14

constant TEXTBOX_X=1
constant TEXTBOX_Y=2
constant TEXTBOX_WIDTH=3
constant TEXTBOX_HEIGHT=4
constant TEXTBOX_TEXT=5
constant TEXTBOX_SEL=6
constant TEXTBOX_CHR1=7
constant TEXTBOX_TEMP=8
constant TEXTBOX_SCREEN_CHR1=9
constant TEXTBOX_DRAW=10
constant TEXTBOX_WORK=11
constant TEXTBOX_ID=12

function create(sequence string)
  if equal(string[1],"button")=1 then
    button_number+=1
    button_info=append(button_info,{string[2],string[3],0,0,string[4],1,1,button_number})
    return button_number
  end if
  if equal(string[1],"button_image")=1 then
    button_image_number+=1
    button_image_info=append(button_image_info,{string[2],string[3],0,string[4],1,1,button_image_number})
    return button_image_number
  end if
  if equal(string[1],"listview")=1 then
    listview_number+=1
    listview_info=append(listview_info,{string[2],string[3],0,string[4],1,1,string[5],1,0,"",1,0,0,listview_number})
    return listview_number
  end if
  if equal(string[1],"textbox")=1 then
    textbox_number+=1
    textbox_info=append(textbox_info,{string[2],string[3],string[4],20,"",0,0,"",1,1,1,textbox_number})
    return textbox_number
  end if
end function

procedure draw_all()
  for i=1 to length(button_info) do
     button_info[i][BUTTON_DRAW]=1
  end for
  for i=1 to length(button_image_info) do
     button_image_info[i][BUTTON_IMAGE_DRAW]=1
  end for
  for i=1 to length(listview_info) do
     listview_info[i][LISTVIEW_DRAW]=1
  end for
  for i=1 to length(textbox_info) do
     textbox_info[i][TEXTBOX_DRAW]=1
  end for
end procedure

procedure work_all(integer v)
  for i=1 to length(button_info) do
     button_info[i][BUTTON_WORK]=v
  end for
  for i=1 to length(button_image_info) do
     button_image_info[i][BUTTON_IMAGE_WORK]=v
  end for
  for i=1 to length(listview_info) do
     listview_info[i][LISTVIEW_WORK]=v
  end for
  for i=1 to length(textbox_info) do
     textbox_info[i][TEXTBOX_WORK]=v
  end for
draw_all()
end procedure

procedure work(sequence string)
  if equal(string[1],"button")=1 then
    for i=1 to length(button_info) do
       if button_info[i][BUTTON_ID]=string[2] then
         button_info[i][BUTTON_WORK]=string[3]
         exit
       end if
    end for
  end if
  if equal(string[1],"button_image")=1 then
    for i=1 to length(button_image_info) do
       if button_image_info[i][BUTTON_IMAGE_ID]=string[2] then
         button_image_info[i][BUTTON_IMAGE_WORK]=string[3]
         exit
       end if
    end for
  end if
  if equal(string[1],"listview")=1 then
    for i=1 to length(listview_info) do
       if listview_info[i][LISTVIEW_ID]=string[2] then
         listview_info[i][LISTVIEW_WORK]=string[3]
         exit
       end if
    end for
  end if
  if equal(string[1],"textbox")=1 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][TEXTBOX_ID]=string[2] then
         textbox_info[i][TEXTBOX_WORK]=string[3]
         exit
       end if
    end for
  end if
draw_all()
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

procedure delete(sequence string)
  if equal(string[1],"button")=1 then
    for i=1 to length(button_info) do
       if button_info[i][BUTTON_ID]=string[2] then
         button_info=remove_line(button_info,i)
         exit
       end if
    end for
  end if
  if equal(string[1],"button_image")=1 then
    for i=1 to length(button_image_info) do
       if button_image_info[i][BUTTON_IMAGE_ID]=string[2] then
         button_image_info=remove_line(button_image_info,i)
         exit
       end if
    end for
  end if
  if equal(string[1],"listview")=1 then
    for i=1 to length(listview_info) do
       if listview_info[i][LISTVIEW_ID]=string[2] then
         listview_info=remove_line(listview_info,i)
         exit
       end if
    end for
  end if
  if equal(string[1],"textbox")=1 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][TEXTBOX_ID]=string[2] then
         textbox_info=remove_line(textbox_info,i)
         exit
       end if
    end for
  end if
draw_all()
end procedure

function item_selete(sequence string)
  if equal(string[1],"listview")=1 then
    for i=1 to length(listview_info) do
       if listview_info[i][LISTVIEW_ID]=string[2] then
         if length(listview_info[i][LISTVIEW_SELNAME])>0 then
           string=listview_info[i][LISTVIEW_SELNAME]
           listview_info[i][LISTVIEW_SELNAME]=""
           return string
         else
           return ""
         end if
       end if
    end for
  end if
end function

procedure delete_all_items(sequence string)
  if equal(string[1],"listview")=1 then
    for i=1 to length(listview_info) do
       if listview_info[i][LISTVIEW_ID]=string[2] then
         listview_info[i][LISTVIEW_STRING]={""}
         listview_info[i][LISTVIEW_SEL]=0
         listview_info[i][LISTVIEW_INIT]=1
         listview_info[i][LISTVIEW_DRAW]=1
         listview_info[i][LISTVIEW_WIDTH]=0
         listview_info[i][LISTVIEW_NUMBER1]=0
         listview_info[i][LISTVIEW_NUMBER2]=0
       end if
    end for
  end if
end procedure

procedure insert_all_items(sequence string)
  if equal(string[1],"listview")=1 then
    for i=1 to length(listview_info) do
       if listview_info[i][LISTVIEW_ID]=string[2] then
         listview_info[i][LISTVIEW_STRING]=string[3]
         listview_info[i][LISTVIEW_SEL]=0
         listview_info[i][LISTVIEW_INIT]=1
         listview_info[i][LISTVIEW_DRAW]=1
         listview_info[i][LISTVIEW_WIDTH]=0
         listview_info[i][LISTVIEW_NUMBER1]=0
         listview_info[i][LISTVIEW_NUMBER2]=0
       end if
    end for
  end if
end procedure

procedure insert_item(sequence string)
  if equal(string[1],"listview")=1 then
    for i=1 to length(listview_info) do
       if listview_info[i][LISTVIEW_ID]=string[2] then
         listview_info[i][LISTVIEW_STRING]=append(listview_info[i][LISTVIEW_STRING],string[3])
         listview_info[i][LISTVIEW_SEL]=0
         listview_info[i][LISTVIEW_INIT]=1
         listview_info[i][LISTVIEW_DRAW]=1
         listview_info[i][LISTVIEW_WIDTH]=0
         listview_info[i][LISTVIEW_NUMBER1]=0
         listview_info[i][LISTVIEW_NUMBER2]=0
         exit
       end if
    end for
  end if
end procedure

procedure replace_item(sequence string)
  if equal(string[1],"listview")=1 then
    for i=1 to length(listview_info) do
       if listview_info[i][LISTVIEW_ID]=string[2] then
         listview_info[i][LISTVIEW_STRING][listview_info[i][LISTVIEW_SEL]]=string[3]
         listview_info[i][LISTVIEW_SEL]=0
         listview_info[i][LISTVIEW_INIT]=1
         listview_info[i][LISTVIEW_DRAW]=1
         listview_info[i][LISTVIEW_WIDTH]=0
         listview_info[i][LISTVIEW_NUMBER1]=0
         listview_info[i][LISTVIEW_NUMBER2]=0
         exit
       end if
    end for
  end if
end procedure


function get_all_items(sequence string)
  if equal(string[1],"listview")=1 then
    for i=1 to length(listview_info) do
       if listview_info[i][LISTVIEW_ID]=string[2] then
         return listview_info[i][LISTVIEW_STRING]
       end if
    end for
  end if
end function

function get_text(sequence string)
  if equal(string[1],"listview")=1 then
    for i=1 to length(listview_info) do
       if listview_info[i][LISTVIEW_ID]=string[2] then
         return listview_info[i][LISTVIEW_STRING][listview_info[i][LISTVIEW_SEL]]
       end if
    end for
  end if
  if equal(string[1],"textbox")=1 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][TEXTBOX_ID]=string[2] then
         return textbox_info[i][TEXTBOX_TEXT]
       end if
    end for
  end if
end function

procedure set_text(sequence string)
  if equal(string[1],"textbox")=1 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][TEXTBOX_ID]=string[2] then
         textbox_info[i][TEXTBOX_TEXT]=string[3]
         textbox_info[i][TEXTBOX_CHR1]=0
         textbox_info[i][TEXTBOX_SCREEN_CHR1]=1
         textbox_info[i][TEXTBOX_DRAW]=1
       end if
    end for
  end if
end procedure

function on_click(sequence string)
  if equal(string[1],"button")=1 then
    for i=1 to length(button_info) do
       if button_info[i][BUTTON_ID]=string[2] then
         if button_info[i][BUTTON_SEL]=1 then
           button_info[i][BUTTON_SEL]=0
           return 1
         else
           return 0
         end if
       end if
    end for
  end if
  if equal(string[1],"button_image")=1 then
    for i=1 to length(button_image_info) do
       if button_image_info[i][BUTTON_IMAGE_ID]=string[2] then
         if button_image_info[i][BUTTON_IMAGE_SEL]=1 then
           button_image_info[i][BUTTON_IMAGE_SEL]=0
           return 1
         else
           return 0
         end if
       end if
    end for
  end if
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

procedure textbox_dos()
integer x,y,width,sel,height,chr1,screen_chr1,text_width,draw,work
sequence text,temp
  for i=1 to length(textbox_info) do
     x=textbox_info[i][TEXTBOX_X]
     y=textbox_info[i][TEXTBOX_Y]
     width=textbox_info[i][TEXTBOX_WIDTH]
     height=textbox_info[i][TEXTBOX_HEIGHT]
     text_width=floor((width-8)/8)
     text=textbox_info[i][TEXTBOX_TEXT]
     sel=textbox_info[i][TEXTBOX_SEL]
     chr1=textbox_info[i][TEXTBOX_CHR1]
     temp=textbox_info[i][TEXTBOX_TEMP]
     screen_chr1=textbox_info[i][TEXTBOX_SCREEN_CHR1]
     draw=textbox_info[i][TEXTBOX_DRAW]
     work=textbox_info[i][TEXTBOX_WORK]   

  if work=1 then
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
     textbox_info[j][TEXTBOX_SEL]=0
     end for
     sel=1
     draw=1
     mouse_button=0
     end if
     end if
     if draw=1 then
       rectangle(x,y,x+width,y+height,7,1)
       rectangle(x,y,x+width,y+height,-1,0)
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
     textbox_info[i][TEXTBOX_TEXT]=text
     textbox_info[i][TEXTBOX_SEL]=sel
     textbox_info[i][TEXTBOX_CHR1]=chr1
     textbox_info[i][TEXTBOX_TEMP]=temp
     textbox_info[i][TEXTBOX_SCREEN_CHR1]=screen_chr1
     textbox_info[i][TEXTBOX_DRAW]=draw
     textbox_info[i][TEXTBOX_WORK]=work
  end for
end procedure

procedure button_dos()
integer x,y,width,sel,draw,work
sequence name
  for i=1 to length(button_info) do
     x=button_info[i][BUTTON_X]
     y=button_info[i][BUTTON_Y]
     width=button_info[i][BUTTON_WIDTH]
     sel=button_info[i][BUTTON_SEL]
     name=button_info[i][BUTTON_NAME]
     draw=button_info[i][BUTTON_DRAW]
     work=button_info[i][BUTTON_WORK]
     width=length(name)
     width+=2
     width=width*8
 if work=1 then
     if mouse_x>x and mouse_x< x+width and mouse_y>y and mouse_y<y+18 then
       line(x,y,x+width,y,-1)
       line(x,y,x,y+18,-1)
       line(x,y+18,x+width,y+18,7)
       line(x+width,y,x+width,y+18,7)
     else
       line(x,y,x+width,y,7)
       line(x,y,x,y+18,7)
       line(x,y+18,x+width,y+18,-1)
       line(x+width,y,x+width,y+18,-1)
     end if
     if mouse_x>x and mouse_x< x+width and mouse_y>y and mouse_y<y+18 and mouse_button=mb_left then
       sel=1
       mouse_button=0
     end if
     if draw=1 then
      line(x,y,x+width,y,7)
      line(x,y+18,x+width,y+18,-1)
      line(x,y,x,y+18,7)
      line(x+width,y,x+width,y+18,-1)
      rectangle(x+1,y+1,x+width-1,y+17,7,1)
      draw_text({x+8,y+1},name,0,7,0)
      draw=0
     end if
 end if
     button_info[i][BUTTON_WIDTH]=width
     button_info[i][BUTTON_SEL]=sel
     button_info[i][BUTTON_DRAW]=draw
  end for
end procedure

procedure listview_dos()
integer x,y,width,height,draw,init,work,sel,number1,number2,can,item_height
sequence string,sel_name
  for i=1 to length(listview_info) do
     x=listview_info[i][LISTVIEW_X]
     y=listview_info[i][LISTVIEW_Y]
     width=listview_info[i][LISTVIEW_WIDTH]
     height=listview_info[i][LISTVIEW_HEIGHT]
     item_height=floor(height/18)
     draw=listview_info[i][LISTVIEW_DRAW]
     init=listview_info[i][LISTVIEW_INIT]
     string=listview_info[i][LISTVIEW_STRING]
     work=listview_info[i][LISTVIEW_WORK]
     sel=listview_info[i][LISTVIEW_SEL]
     sel_name=listview_info[i][LISTVIEW_SELNAME]
     number1=listview_info[i][LISTVIEW_NUMBER1]
     number2=listview_info[i][LISTVIEW_NUMBER2]
     can=listview_info[i][LISTVIEW_CAN]
     
 if work=1 then
     if init=1 then
       for j=1 to length(string) do
          if width<length(string[j]) then
            width=length(string[j])
          end if
       end for
       can=0
       draw=1
       number1=1
       number2=0
       if length(string)>item_height then
         number2=length(string)-item_height
         can=1
       end if
       if width>0 then
       width=width*8
       width+=8
       else
       width=80
       end if
       init=0
     end if
     if width<80 then
       width=80
     end if
     if can=1 then
        if mouse_x>x+width and mouse_x<x+width+14 and mouse_y>y and mouse_y<y+14 and mouse_button=mb_left then
          mouse_button=0
          if number1>1 then
            number1-=1
            number2+=1
            draw=1
          end if
        end if
        if mouse_x>x+width and mouse_x<x+width+14 and mouse_y>y+height-14 and mouse_y<y+height and mouse_button=mb_left then
          mouse_button=0
          if number2>0 then
            number1+=1
            number2-=1
            draw=1
          end if
        end if
     end if

     for j=number1 to length(string)-number2 do
        if mouse_x>x and mouse_x<x+width and mouse_y>y+2+18*(j-(number1-1)-1) and mouse_y<y+2+18*(j-(number1-1)) and mouse_button=mb_left then
          mouse_button=0
          sel_name=string[j]
          sel=j
          draw=1
          exit
        end if
     end for

     if draw=1 then
       rectangle(x,y,x+width,y+height,7,1)
       rectangle(x,y,x+width,y+height,0,0)
       rectangle(x+width,y,x+width+14,y+height,7,1)
       rectangle(x+width,y,x+width+14,y+height,0,0)
       if can=1 then
         rectangle(x+width,y,x+width+14,y+14,8,1)
         rectangle(x+width,y+height-14,x+width+14,y+height,8,1)
         rectangle(x+width,y,x+width+14,y+14,7,0)
         rectangle(x+width,y+height-14,x+width+14,y+height,7,0)
       end if
       for j=number1 to length(string)-number2 do
         if sel=j then
           rectangle(x+2,y+2+18*(j-(number1-1)-1),x+width-2,y+2+18*(j-(number1-1)),-1,1)
           draw_text({x+2,y+2+18*(j-(number1-1)-1)},string[j],0,-1,0)
         else
           rectangle(x+2,y+2+18*(j-(number1-1)-1),x+width-2,y+2+18*(j-(number1-1)),7,1)
           draw_text({x+2,y+2+18*(j-(number1-1)-1)},string[j],0,7,0)
         end if
       end for
       draw=0
     end if
end if
     listview_info[i][LISTVIEW_WIDTH]=width
     listview_info[i][LISTVIEW_DRAW]=draw
     listview_info[i][LISTVIEW_INIT]=init
     listview_info[i][LISTVIEW_SEL]=sel
     listview_info[i][LISTVIEW_SELNAME]=sel_name
     listview_info[i][LISTVIEW_NUMBER1]=number1
     listview_info[i][LISTVIEW_NUMBER2]=number2
     listview_info[i][LISTVIEW_CAN]=can
  end for
end procedure

procedure button_image_dos()
integer x,y,sel,draw,width,height,work
atom timer
sequence images
timer=0
  for i=1 to length(button_image_info) do
     x=button_image_info[i][BUTTON_IMAGE_X]
     y=button_image_info[i][BUTTON_IMAGE_Y]
     sel=button_image_info[i][BUTTON_IMAGE_SEL]
     images=button_image_info[i][BUTTON_IMAGE_IMAGES]
     draw=button_image_info[i][BUTTON_IMAGE_DRAW]
     work=button_image_info[i][BUTTON_IMAGE_WORK]
     width=length(images[1][1])
     height=length(images[1])
if work=1 then
     if mouse_x>x and mouse_x< x+width and mouse_y>y and mouse_y<y+height then
     else
     end if
     if mouse_x>x and mouse_x< x+width and mouse_y>y and mouse_y<y+height and mouse_button=mb_left then
       display_image({x,y},images[2])
       timer=time()+.05
       while 1 do
         if time()>timer then
           exit
         end if
       end while
       display_image({x,y},images[1])
       sel=1
       mouse_button=0
     end if
     if draw=1 then
      display_image({x,y},images[1])
      draw=0
     end if
end if
     button_image_info[i][BUTTON_IMAGE_SEL]=sel
     button_image_info[i][BUTTON_IMAGE_DRAW]=draw
  end for
end procedure

function file_exsist(sequence string)
atom fn
fn = open(string, "r")
if fn = -1 then
  return 0
else
  return 1
close(fn)
end if
end function

function show_q(sequence msg)
integer button1,button2,x,y,width,v
width=100
width+=length(msg)*8
x=320-width/2
y=180
work_all(0)
rectangle(x,y,x+width-50,y+50,8,1)
rectangle(x,y,x+width-50,y+50,-1,0)
draw_text({x+15,y+2},msg,-1,8,0)
button1=create({"button",x+width/2-20,y+25,"no"})
button2=create({"button",x+width/2-70,y+25,"yes"})
 while 1 do
    mouse()
    mouse_pointer(1)
    if on_click({"button",button1})=1 then
      v=0
      exit
    end if
    if on_click({"button",button2})=1 then
      v=1
      exit
    end if
 button_dos()
 button_image_dos()
 listview_dos()
 textbox_dos()
 end while
 delete({"button",button1})
 delete({"button",button2})
 clear_screen()
 work_all(1)
 draw_all()
 button_dos()
 button_image_dos()
 listview_dos()
 textbox_dos()
 return v
end function

sequence d,line1,line2
integer test, drive
test=0
drive=0
d={}
line1={}
line2={}

procedure get_dir_info(sequence path, sequence file_types)
test=0
d={}
line1={}
line2={}
  d=dir(path)
  for i=1 to length(d) do
  test= compare(d[i][2],"d") 
  if test!=0 then
    if length(file_types)>0 then
    for j=1 to length(d[i][1]) do
       if d[i][1][j]='.' then
         for k=1 to length(file_types) do
           if equal(upper(file_types[k]),d[i][1][j..length(d[i][1])])=1 then
             line1=append(line1,d[i][1])
             exit
           end if
         end for
         exit
       end if
    end for
    else
      line1=append(line1,d[i][1])
    end if
  end if
  end for
  d=dir(path)
  for i=1 to length(d) do
  test= compare(d[i][2],"d") 
  if test=0 and equal(d[i][1],"..")=0 then
    line2=append(line2,d[i][1])
  end if
  end for
line1=sort(line1)
line2=sort(line2)
end procedure

function back_dir(sequence path)
sequence temp, info, name
atom pos
info={}
name=""
temp=path&{92}
pos=1
for i=1 to length(temp) do
   if temp[i]=92 then
     info=append(info,temp[pos..i])
     pos=i+1
   end if
end for
if length(info)=2 then
  drive=1
  return info[1]
end if
for i=1 to length(info)-1 do
   name&=info[i]
end for
drive=0
return name[1..length(name)-1]
end function

function next_dir(sequence path)
sequence temp, info
atom pos
info={}
temp=path&{92}
pos=1
for i=1 to length(temp) do
   if temp[i]=92 then
     info=append(info,temp[pos..i])
     pos=i+1
   end if
end for
for i=1 to length(info) do
   if info[i][1]=92 then
     info=remove_line(info,i)
   end if
end for
if length(info)=1 then
  drive=0
  return path
end if
drive=0
return path&"\\"
end function

function get_open_filename(sequence file_types)
integer button1,button2,x,y,width,listview1,listview2,v
sequence path,temp1,temp2,temp_path
temp1={}
v=0
temp2={}
drive=0
temp_path=""
path=current_dir()
get_dir_info(path,file_types)
width=300
work_all(0)
x=180
y=120
rectangle(x,y,x+width,y+130,8,1)
rectangle(x,y,x+width,y+130,-1,0)
draw_text({x+5,y+2},path,-1,8,0)
button1=create({"button",x+width-64,y+80,"open"})
button2=create({"button",x+width-70,y+105,"cancle"})
listview1=create({"listview",x+2,y+25,100,line2})
listview2=create({"listview",x+100,y+25,100,line1})
 while 1 do
    mouse()
    mouse_pointer(1)
    temp1=item_selete({"listview",listview1})
    if length(temp1)>0 then
      if equal(temp1,".")=1 then
        rectangle(x,y,x+width,y+130,8,1)
        rectangle(x,y,x+width,y+130,-1,0)
        path=back_dir(path)
        get_dir_info(path,file_types)
        draw_text({x+5,y+2},"                                   ",-1,8,0)
        draw_text({x+5,y+2},path,-1,8,0)
        delete_all_items({"listview",listview1})
        insert_all_items({"listview",listview1,line2})
        delete_all_items({"listview",listview2})
        insert_all_items({"listview",listview2,line1})
        draw_all()
      else
        rectangle(x,y,x+width,y+130,8,1)
        rectangle(x,y,x+width,y+130,-1,0)
        path=next_dir(path)
        path&=get_text({"listview",listview1})
        get_dir_info(path,file_types)
        draw_text({x+5,y+2},"                                   ",-1,8,0)
        draw_text({x+5,y+2},path,-1,8,0)
        delete_all_items({"listview",listview1})
        insert_all_items({"listview",listview1,line2})
        delete_all_items({"listview",listview2})
        insert_all_items({"listview",listview2,line1})
        draw_all()
      end if
      temp1=""
    end if
    --file
    temp2=item_selete({"listview",listview2})
    if length(temp2)>0 then
      if drive=0 then
        draw_text({x+5,y+2},"                                   ",-1,8,0)
        temp_path=path
        temp_path&="\\"&get_text({"listview",listview2})
        draw_text({x+5,y+2},temp_path,-1,8,0)
      else
        draw_text({x+5,y+2},"                                   ",-1,8,0)
        temp_path=path
        temp_path&=get_text({"listview",listview2})
        draw_text({x+5,y+2},temp_path,-1,8,0)
       end if
      temp2=""
    end if
    if on_click({"button",button1})=1 then
      v=1
      exit
    end if
    if on_click({"button",button2})=1 then
      exit
    end if
 button_dos()
 button_image_dos()
 listview_dos()
 textbox_dos()
 end while
 delete({"button",button1})
 delete({"button",button2})
 delete({"listview",listview1})
 delete({"listview",listview2})
 clear_screen()
 work_all(1)
 draw_all()
 button_dos()
 button_image_dos()
 listview_dos()
 textbox_dos()
 if v=1 then
   return temp_path
 else
   return ""
 end if
end function

function get_save_filename(sequence file_types)
integer button1,button2,x,y,width,listview1,listview2,v,textbox1
sequence path,temp1,temp2,temp_path
temp1={}
v=0
temp2={}
temp_path=""
drive=0
path=current_dir()
get_dir_info(path,file_types)
width=300
work_all(0)
x=180
y=120
rectangle(x,y,x+width,y+160,8,1)
rectangle(x,y,x+width,y+160,-1,0)
draw_text({x+5,y+2},path,-1,8,0)
button1=create({"button",x+width-64,y+80,"save"})
button2=create({"button",x+width-70,y+105,"cancle"})
listview1=create({"listview",x+2,y+25,100,line2})
listview2=create({"listview",x+100,y+25,100,line1})
textbox1=create({"textbox",x+width-104,y+130,100})
 while 1 do
    mouse()
    mouse_pointer(1)
    key=get_key()
    temp1=item_selete({"listview",listview1})
    if length(temp1)>0 then
      if equal(temp1,".")=1 then
        rectangle(x,y,x+width,y+160,8,1)
        rectangle(x,y,x+width,y+160,-1,0)
        path=back_dir(path)
        get_dir_info(path,file_types)
        draw_text({x+5,y+2},"                                   ",-1,8,0)
        draw_text({x+5,y+2},path,-1,8,0)
        delete_all_items({"listview",listview1})
        insert_all_items({"listview",listview1,line2})
        delete_all_items({"listview",listview2})
        insert_all_items({"listview",listview2,line1})
        draw_all()
      else
        rectangle(x,y,x+width,y+160,8,1)
        rectangle(x,y,x+width,y+160,-1,0)
        path=next_dir(path)
        path&=get_text({"listview",listview1})
        get_dir_info(path,file_types)
        draw_text({x+5,y+2},"                                   ",-1,8,0)
        draw_text({x+5,y+2},path,-1,8,0)
        delete_all_items({"listview",listview1})
        insert_all_items({"listview",listview1,line2})
        delete_all_items({"listview",listview2})
        insert_all_items({"listview",listview2,line1})
        draw_all()
      end if
      temp1=""
    end if
    --file
    temp2=item_selete({"listview",listview2})
    if length(temp2)>0 then
      if drive=0 then
        draw_text({x+5,y+2},"                                   ",-1,8,0)
        temp_path=path
        temp_path&="\\"&get_text({"listview",listview2})
        set_text({"textbox",textbox1,get_text({"listview",listview2})})
        draw_text({x+5,y+2},temp_path,-1,8,0)
      else
        draw_text({x+5,y+2},"                                   ",-1,8,0)
        temp_path=path
        temp_path&=get_text({"listview",listview2})
        set_text({"textbox",textbox1,get_text({"listview",listview2})})
        draw_text({x+5,y+2},temp_path,-1,8,0)
      end if
      temp2=""
    end if
    if on_click({"button",button1})=1 then
      temp_path=get_text({"textbox",textbox1})
      v=1
      exit
    end if
    if on_click({"button",button2})=1 then
      exit
    end if
  button_dos()
  button_image_dos()
  listview_dos()
  textbox_dos()
 end while
 delete({"button",button1})
 delete({"button",button2})
 delete({"listview",listview1})
 delete({"listview",listview2})
 delete({"textbox",textbox1})
 clear_screen()
 work_all(1)
 draw_all()
 button_dos()
 button_image_dos()
 listview_dos()
 textbox_dos()
 if v=1 then
   if drive=0 then
   return upper(path&"\\"&temp_path)
   else
   end if
 else
   return ""
 end if
end function
-- sound sytem --

procedure delay(atom t1)
atom timer
  timer=time()+t1
  while timer>time() do
  end while
end procedure

procedure soundf(atom d ,integer f)
  sound(f)
  delay(d)
  sound(f)
  delay(.001)
  sound(0)
end procedure

function get_sound()
sequence d,f
integer button1,button2,textbox1,textbox2,v,x,y,width
d=""
v=0
f=""
width=320
x=120
y=100
rectangle(x,y,x+width,y+60,8,1)
rectangle(x,y,x+width,y+60,-1,0)
work_all(0)
button1=create({"button",x+width-100,y,"ok"})
button2=create({"button",x+width-100,y+30,"cancle"})
textbox1=create({"textbox",x+130,y+2,50})
textbox2=create({"textbox",x+130,y+32,50})
 while 1 do
    mouse()
    mouse_pointer(1)
    key=get_key()
    if on_click({"button",button1})=1 then
      v=1
      d=get_text({"textbox",textbox1})
      f=get_text({"textbox",textbox2})
      exit
    end if
    if on_click({"button",button2})=1 then
      v=0
      exit
    end if
  button_dos()
  button_image_dos()
  listview_dos()
  textbox_dos()
 end while
   delete({"button",button1})
   delete({"button",button2})
   delete({"textbox",textbox1})
   delete({"textbox",textbox2})
  clear_screen()
  work_all(1)
  draw_all()
  if v=1 then
    return {d,f}
  elsif v=0 then
    return ""
  end if
end function

function edit_sound(sequence string)
sequence d,f
integer button1,button2,textbox1,textbox2,v,x,y,width
d=""
v=0
f=""
width=320
x=120
y=100
rectangle(x,y,x+width,y+60,8,1)
rectangle(x,y,x+width,y+60,-1,0)
work_all(0)
button1=create({"button",x+width-100,y,"ok"})
button2=create({"button",x+width-100,y+30,"cancle"})
textbox1=create({"textbox",x+130,y+2,50})
textbox2=create({"textbox",x+130,y+32,50})
set_text({"textbox",textbox1,string[1]})
set_text({"textbox",textbox2,string[2]})
 while 1 do
    mouse()
    mouse_pointer(1)
    key=get_key()
    if on_click({"button",button1})=1 then
      v=1
      d=get_text({"textbox",textbox1})
      f=get_text({"textbox",textbox2})
      exit
    end if
    if on_click({"button",button2})=1 then
      v=0
      exit
    end if
  button_dos()
  button_image_dos()
  listview_dos()
  textbox_dos()
 end while
   delete({"button",button1})
   delete({"button",button2})
   delete({"textbox",textbox1})
   delete({"textbox",textbox2})
  clear_screen()
  work_all(1)
  draw_all()
  if v=1 then
    return {d,f}
  elsif v=0 then
    return ""
  end if
end function

integer listview1,button1,button2,button3
listview1=create({"listview",1,1,300,{}})
button1=create({"button",10,310,"add sound "})
button2=create({"button",10,340,"play sound"})
button3=create({"button",10,370,"edit sound"})

function real(object a)
sequence temp
temp=value(a)
return temp[2]
end function

function get_sound1(sequence string)
  for i=1 to length(string) do
     if string[i]=',' then
       return {string[1..i-1],string[i+1..length(string)]}
     end if
  end for
end function

procedure play(sequence string)
sequence song
song={}
  for i=1 to length(string) do
     for j=1 to length(string[i]) do
        if string[i][j]=',' then
          song=append(song,{string[i][1..j-1],string[i][j+1..length(string[i])]})
          exit
        end if
     end for
  end for
  for i=1 to length(song) do
     soundf(real(song[i][1]),real(song[i][2]))
  end for
end procedure

procedure commands()
sequence temp
temp={}
  if on_click({"button",button1})=1 then
    temp=get_sound()
    if length(temp[1])>0 then
      insert_item({"listview",listview1,temp[1]&","&temp[2]})
    end if
  end if
  if on_click({"button",button2})=1 then
    play(get_all_items({"listview",listview1}))
  end if
  if on_click({"button",button3})=1 then
    temp=edit_sound(get_sound1(get_text({"listview",listview1})))
    if length(temp)>0 then
      replace_item({"listview",listview1,temp[1]&","&temp[2]})
    end if
  end if
end procedure

while 1 do
mouse()
mouse_pointer(1)
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
end if
button_dos()
button_image_dos()
listview_dos()
textbox_dos()
commands()
end while
