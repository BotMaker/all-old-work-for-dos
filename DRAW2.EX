-----------------------------------------------------------
-- drawing for children version 0.1 pm 15;23 time 18/12/05 
-----------------------------------------------------------
without type_check
without warning
include graphics.e
include image.e
include font3.e
include get.e
include mouse2.e
include file.e
include sort.e
include wildcard.e

if graphics_mode(259) then
end if

procedure line(atom x,atom y,atom xx,atom yy,atom color)
  if color=-1 then
   color=15
 end if
  draw_line(color, {{x, y}, {xx, yy}})
end procedure

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
 if color=-1 then
   color=15
 end if
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

function file_read(sequence string)
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
 line=line[1..length(line)-1]
 buffer = append(buffer, line)
end while
close(fn)
return buffer
end function

function make_image(sequence data)
sequence image
integer pos1
image={}
pos1=1
   for i=1 to length(data) do
      image=append(image,{})
      pos1=1
      for j=1 to length(data[i]) do
         if data[i][j]!='"' then
           if data[i][j]='A' then
             image[i]&=10
           elsif data[i][j]='B' then
             image[i]&=11
           elsif data[i][j]='C' then
             image[i]&=12
           elsif data[i][j]='D' then
             image[i]&=13
           elsif data[i][j]='E' then
             image[i]&=14
           elsif data[i][j]='F' then
             image[i]&=-1
           else
             if data[i][j]='0' then
               image[i]&=0
             elsif data[i][j]='1' then
               image[i]&=1
             elsif data[i][j]='2' then
               image[i]&=2
             elsif data[i][j]='3' then
               image[i]&=3
             elsif data[i][j]='4' then
               image[i]&=4
             elsif data[i][j]='5' then
               image[i]&=5
             elsif data[i][j]='6' then
               image[i]&=6
             elsif data[i][j]='7' then
               image[i]&=7
             elsif data[i][j]='8' then
               image[i]&=8
             elsif data[i][j]='9' then
               image[i]&=9
             end if
           end if
         end if
      end for
   end for
return image
end function

sequence image
image={}

procedure load_images(sequence string)
  sequence temp,file_data,info
  integer pos
  pos=1
  info={}
  temp=file_read(string)
  file_data={}
  for i=1 to length(temp)-1 do
     if temp[i][1]!='"' then
         for j=1 to length(temp[i]) do
           if temp[i][j]=',' then
             info=append(info,temp[i][1..j-1])
             info=append(info,temp[i][j+1..length(temp[i])])
             exit
           end if
         end for
         for j=i+1 to length(temp)-1 do
           if temp[j][1]!='"' or j=length(temp)-1 then
             if j=length(temp)-1 then
               pos=j+1
               exit
             else
             pos=j-1
             exit
             end if
           end if
         end for
         file_data=append(file_data,{temp[i+1..pos],info})
         info={}
     end if
  end for
  temp={}
  for i=1 to length(file_data) do
    image=append(image,{make_image(file_data[i][1]),file_data[i][2]})
  end for
end procedure

integer t_x,t_y,x1,y1, zoom_x,zoom_y,t_c,grid2
integer width_p,height_p,color,color2,grid
integer draw, mode
atom temp_x,temp_y
sequence s
sequence temp_image
integer click,l_x,l_y,button,soid
sequence temp_line
temp_image={}
for i=1 to 32 do
  temp_image=append(temp_image,repeat(0,32))
end for
zoom_x=10
zoom_y=10
t_x=1
t_y=1
t_c=0
x1=1
y1=1
width_p=32
height_p=32
color=-1
color2=0
grid=3
grid2=1
s={}
temp_x=0
temp_y=0
draw=0
click=0
mode=1
l_x=1
l_y=1
temp_line={}
button=0
soid=1

procedure cls()
  clear_screen()
  draw_all()
end procedure

procedure new()
  width_p= prompt_number("What is width_p of the image enter number between 0 50? ", {0, 50})
  height_p= prompt_number("What is height_p of image enter number between 0 50? ", {0, 50})
  cls()
  temp_image={}
  for i=1 to height_p do
    temp_image=append(temp_image,repeat(0,width_p))
  end for
zoom_x=6
zoom_y=6
t_x=1
t_y=1
t_c=0
x1=1
y1=1
color=-1
color2=0
grid2=1
grid=3
s={}
temp_x=0
temp_y=0
draw=0
click=0
mode=1
l_x=1
l_y=1
temp_line={}
button=0
soid=1
end procedure

procedure draw_pos(integer pos1, integer pos2,integer all)
for y=1 to height_p do
   for x=1 to width_p do
      if x=pos1 and y=pos2 then
        rectangle(zoom_x*t_x,zoom_y*t_y,zoom_x*(t_x+1),zoom_y*(t_y+1),t_c,1)
        if zoom_x>=grid then
          if grid2=1 then
          rectangle(zoom_x*t_x,zoom_y*t_y,zoom_x*(t_x+1),zoom_y*(t_y+1),8,0)
          end if
        end if
        rectangle(zoom_x*x,zoom_y*y,zoom_x*(x+1),zoom_y*(y+1),color,1)
        if zoom_x>=grid then
          if grid2=1 then
          rectangle(zoom_x*x,zoom_y*y,zoom_x*(x+1),zoom_y*(y+1),-1,0)
          end if
        end if
      else
        if all=1 then
          rectangle(zoom_x*x,zoom_y*y,zoom_x*(x+1),zoom_y*(y+1),temp_image[y][x],1)
        if zoom_x>=grid then
          if grid2 =1 then
          rectangle(zoom_x*x,zoom_y*y,zoom_x*(x+1),zoom_y*(y+1),8,0)
          end if
        end if
        end if
      end if
   end for
end for
end procedure

procedure draw_mouse2()
  if temp_x!=mouse_x or temp_y!=mouse_y then
    display_image({temp_x,temp_y},s)
    s=save_image({mouse_x,mouse_y},{mouse_x+5,mouse_y+5})
    rectangle(mouse_x,mouse_y,mouse_x+5,mouse_y+5,RED,1)
    temp_x=mouse_x
    temp_y=mouse_y
  end if
end procedure

procedure fill(integer fill_color)
integer px,py,sel_color,line,count
atom timer
sequence temp,pos
temp=temp_image
pos={}
sel_color=temp_image[y1][x1]
py=y1
px=x1
timer=time()+.30
count=0
pos=append(pos,{py,px})
line=1
temp_image[py][px]=fill_color
  while 1 do
    if line<=length(pos) then
      px=pos[line][2]
      py=pos[line][1]
      if px>0 and px<=width_p and py>0 and py<=height_p then
        -- one line up
        if py-1 >0 then
          if temp_image[py-1][px]=sel_color then
            pos=append(pos,{py-1,px})
            temp_image[py-1][px]=fill_color
          end if
        end if
        -- one line down
        if py+1 <=height_p then
          if temp_image[py+1][px]=sel_color then
            pos=append(pos,{py+1,px})
            temp_image[py+1][px]=fill_color
          end if
        end if
        -- one row left
        if px-1 >0 then
          if temp_image[py][px-1]=sel_color then
            pos=append(pos,{py,px-1})
            temp_image[py][px-1]=fill_color
          end if
        end if
        -- one row right
        if px+1 <=width_p then
          if temp_image[py][px+1]=sel_color then
            pos=append(pos,{py,px+1})
            temp_image[py][px+1]=fill_color
          end if
        end if
      end if
      line+=1
    else
      line=1
      count+=1
    end if
   if count>10 or time()>timer then
      exit
    end if
  end while
end procedure

procedure draw_mouse()
  x1=floor(mouse_x/zoom_x)
  y1=floor(mouse_y/zoom_y)
  if x1>=1 and x1<=width_p and y1>=1 and y1<=height_p then
    if mouse_button=mb_right and mode>=3 then
      if click=0 then
        button=2
        draw=1
        mouse_button=0
        l_x=x1
        l_y=y1
        temp_line=temp_image
        click+=1
      elsif click=1 then
        if button=1 then
          temp_image=temp_line
          draw_pos(x1,y1,1)
        end if
        mouse_button=0
        click=0
      end if
    end if
    if mouse_button=mb_left and mode>=3 then
      if click=0 then
        button=1
        draw=1
        mouse_button=0
        l_x=x1
        l_y=y1
        temp_line=temp_image
        click+=1
      elsif click=1 then
        if button=2 then
          temp_image=temp_line
          draw_pos(x1,y1,1)
        end if
        mouse_button=0
        click=0
      end if
    end if
    if mouse_button=mb_left and mode=1 then
      temp_image[y1][x1]=color
      draw=1
      mouse_button=0
    end if
    if mouse_button=mb_right and mode=1 then
      temp_image[y1][x1]=color2
      draw=2
      mouse_button=0
    end if
    if mouse_button=mb_left and mode=2 then
      fill(color)
      draw_pos(x1,y1,1)
      mouse_button=0
    end if
    if mouse_button=mb_right and mode=2 then
      fill(color2)
      draw_pos(x1,y1,1)
      mouse_button=0
    end if
    if t_x!=x1 or t_y!=y1 then
      draw_text({300,580},"x "&sprint(x1)&"   ",-1,0,0)
      draw_text({360,580},"y "&sprint(y1)&"   ",-1,0,0)
      if draw=0 then
        t_c=temp_image[t_y][t_x]
      elsif draw=1 then
        t_c=color
        draw=0
      elsif draw=2 then
        t_c=color2
        draw=0
      end if
      draw_pos(x1,y1,0)
      if mode=1 then
      elsif mode=3 and click=1 then
        temp_image=temp_line
        display_image({30,30},temp_image)
        if button=1 then
        line(29+l_x,29+l_y,29+x1,29+y1,color)
        elsif button=2 then
        line(29+l_x,29+l_y,29+x1,29+y1,color2)
        end if
        for i=1 to height_p do
          for j=1 to width_p do
            temp_image[i][j]=get_pixel({29+j,29+i})
          end for
        end for
        draw_pos(x1,y1,1)
      elsif mode=4 and click=1 then
        temp_image=temp_line
        display_image({30,30},temp_image)
        if button=1 then
          rectangle(29+l_x,29+l_y,29+x1,29+y1,color,soid)
        elsif button=2 then
          rectangle(29+l_x,29+l_y,29+x1,29+y1,color2,soid)
        end if
        for i=1 to height_p do
          for j=1 to width_p do
            temp_image[i][j]=get_pixel({29+j,29+i})
          end for
        end for
        draw_pos(x1,y1,1)
      elsif mode=5 and click=1 then
        temp_image=temp_line
        display_image({30,30},temp_image)
        if button=1 then
          ellipse(color,soid,{29+l_x,29+l_y} ,{29+x1,29+y1})
        elsif button=2 then
          ellipse(color2,soid,{29+l_x,29+l_y} ,{29+x1,29+y1})
        end if
        for i=1 to height_p do
          for j=1 to width_p do
            temp_image[i][j]=get_pixel({29+j,29+i})
          end for
        end for
        draw_pos(x1,y1,1)
      end if
      t_x=x1
      t_y=y1
    end if
  else
    draw_mouse2()
  end if
end procedure

procedure draw_colors(integer xx, integer yy)
  for i=-1 to 14 do
     rectangle(xx+15*(i+2),yy,xx+15*(i+3),yy+15,i,1)
  end for
   if mode=1 then
     draw_text({300,560},"Pen      ",-1,0,0)
   elsif mode=2 then
     draw_text({300,560},"fill     ",-1,0,0)
   elsif mode=3 then
     draw_text({300,560},"line     ",-1,0,0)
   elsif mode=4 then
     draw_text({300,560},"rectangle",-1,0,0)
   elsif mode=5 then
     draw_text({300,560},"cir      ",-1,0,0)
   end if
   draw_text({420,560},"zoom "&sprint(zoom_x),-1,0,0)
   draw_text({520,560},"width "&sprint(width_p)&" height "&sprint(height_p),-1,0,0)
   draw_text({420,580},"soid "&sprint(soid),-1,0,0)
   draw_text({520,580},"grid "&sprint(grid2),-1,0,0)
   draw_text({300,580},"x "&sprint(x1)&"   ",-1,0,0)
   draw_text({360,580},"y "&sprint(y1)&"   ",-1,0,0)
end procedure

procedure sel_color(integer xx, integer yy)
  for i=-1 to 14 do
    if mouse_x>=xx+15*(i+2) and mouse_x<=xx+15*(i+3) and mouse_y>=yy and mouse_y<=yy+15 and mouse_button=mb_left then
      color=i
      mouse_button=0
      rectangle(xx+15,yy-25,xx+30,yy-10,color,1)
      rectangle(xx+30,yy-25,xx+45,yy-10,color2,1)
      rectangle(xx+15,yy-25,xx+30,yy-10,-1,0)
      rectangle(xx+30,yy-25,xx+45,yy-10,-1,0)
      exit
    end if
    if mouse_x>=xx+15*(i+2) and mouse_x<=xx+15*(i+3) and mouse_y>=yy and mouse_y<=yy+15 and mouse_button=mb_right then
      color2=i
      mouse_button=0
      rectangle(xx+15,yy-25,xx+30,yy-10,color,1)
      rectangle(xx+30,yy-25,xx+45,yy-10,color2,1)
      rectangle(xx+15,yy-25,xx+30,yy-10,-1,0)
      rectangle(xx+30,yy-25,xx+45,yy-10,-1,0)
      exit
    end if
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
x=400-width/2
y=220
work_all(0)
rectangle(x,y,x+width-50,y+50,8,1)
rectangle(x,y,x+width-50,y+50,-1,0)
draw_text({x+15,y+2},msg,-1,8,0)
button1=create({"button",x+width/2-20,y+25,"no"})
button2=create({"button",x+width/2-70,y+25,"yes"})
 while 1 do
    mouse()
    if on_click({"button",button1})=1 then
      v=0
      exit
    end if
    if on_click({"button",button2})=1 then
      v=1
      exit
    end if
  draw_mouse2()
 button_dos()
 button_image_dos()
 listview_dos()
 textbox_dos()
 end while
 delete({"button",button1})
 delete({"button",button2})
 cls()
 work_all(1)
 draw_all()
 button_dos()
 button_image_dos()
 listview_dos()
 textbox_dos()
 draw_colors(0,560)
 draw_pos(x1,y1,1)
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
x=230
y=180
rectangle(x,y,x+width,y+130,8,1)
rectangle(x,y,x+width,y+130,-1,0)
draw_text({x+5,y+2},path,-1,8,0)
button1=create({"button",x+width-64,y+80,"open"})
button2=create({"button",x+width-70,y+105,"cancle"})
listview1=create({"listview",x+2,y+25,100,line2})
listview2=create({"listview",x+100,y+25,100,line1})
 while 1 do
    mouse()
    --dic
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
  draw_mouse2()
 button_dos()
 button_image_dos()
 listview_dos()
 textbox_dos()
 end while
 delete({"button",button1})
 delete({"button",button2})
 delete({"listview",listview1})
 delete({"listview",listview2})
 cls()
 work_all(1)
 draw_all()
 button_dos()
 button_image_dos()
 listview_dos()
 textbox_dos()
 draw_colors(0,560)
 draw_pos(x1,y1,1)
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
x=230
y=180
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
  draw_mouse2()
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
 cls()
 work_all(1)
 draw_all()
 button_dos()
 button_image_dos()
 listview_dos()
 textbox_dos()
 draw_colors(0,560)
 draw_pos(x1,y1,1)
 if v=1 then
   if drive=0 then
   return upper(path&"\\"&temp_path)
   else
   end if
 else
   return ""
 end if
end function

procedure open_pic()
integer format
sequence file, ima
format=0
  if show_q("Do You Want To Open A Image ") =1 then
  file = get_open_filename({".bmp",".pic"})
    if file_exsist(file)=1 then
      for i=1 to length(file) do
         if file[i]='.' then
           if equal(file[i+1..length(file)],upper("bmp"))=1 then
             format=1
           elsif equal(file[i+1..length(file)],upper("pic"))=1 then
             format=2
           end if
           exit
         end if
      end for
       if format=1 then
         ima=read_bitmap(file)
         temp_image=ima[2]
       elsif format=2 then
         image={}
         load_images(file)
         temp_image=image[1][1]
       else
         puts(1,"\n image format not sorported")
         sleep(2)
       end if
         height_p=length(temp_image)
       zoom_x=6
       zoom_y=6
       width_p=length(temp_image[1])
       t_x=1
       t_y=1
       t_c=0
       x1=1
       y1=1
       color=-1
    else
      puts(1,"\n image not found")
      sleep(2)
    end if
  end if
end procedure

procedure write_pic(sequence file_name, sequence pic)
integer fn,width,height
sequence bmp_image
bmp_image={}
width=length(pic[1])
height=length(pic)
  for i=1 to height do
    bmp_image=append(bmp_image,repeat(0,width))
  end for
  for i=1 to length(pic) do
    for j=1 to length(pic[i]) do
       if pic[i][j]=10 then
         bmp_image[i][j]='A'
       elsif pic[i][j]=11 then
         bmp_image[i][j]='B'
       elsif pic[i][j]=12 then
         bmp_image[i][j]='C'
       elsif pic[i][j]=13 then
         bmp_image[i][j]='D'
       elsif pic[i][j]=14 then
         bmp_image[i][j]='E'
       elsif pic[i][j]=-1 then
         bmp_image[i][j]='F'
       elsif pic[i][j]=15 then
         bmp_image[i][j]='F'
       else
        bmp_image[i][j]=pic[i][j]
       end if
    end for
  end for
fn = open(file_name, "w")
if fn = -1 then
end if
print(fn,width)
puts(fn,",")
print(fn,height)
puts(fn,"\n")
 for i=1 to height do
    puts(fn,'"')
    for j=1 to width do
       if bmp_image[i][j]>=0 and bmp_image[i][j]<=9 then
         print(fn,bmp_image[i][j])
       else
         puts(fn,bmp_image[i][j])
       end if
       if j=width and i!=height then
         puts(fn,'"'&"\n")
       end if
       if j=width and i=height then
         puts(fn,'"')
       end if
    end for
 end for
close(fn)
end procedure

procedure save()
integer err,format
sequence file
format=0
  if show_q("Do You Want To Save Image")=1 then
    file = get_save_filename({".bmp",".pic"})
  if file_exsist(file)=0 then
    for i=1 to length(file) do
       if file[i]='.' then
         if equal(file[i+1..length(file)],upper("bmp"))=1 then
           format=1
         elsif equal(file[i+1..length(file)],upper("pic"))=1 then
           format=2
         end if
         exit
       end if
    end for
    if format=1 then
      cls()
      display_image({1,1},temp_image)
      err=save_screen({{1,1},{width_p, height_p}},file)
    elsif format=2 then
     write_pic(file,temp_image)
    else
      puts(1,"\n could not save")
      sleep(2)
    end if
  else
    if show_q(file&" file allready exsist do you want to replace this file")=1 then
    for i=1 to length(file) do
       if file[i]='.' then
         if equal(file[i+1..length(file)],upper("bmp"))=1 then
           format=1
         elsif equal(file[i+1..length(file)],upper("pic"))=1 then
           format=2
         end if
         exit
       end if
    end for
    if format=1 then
      cls()
      display_image({1,1},temp_image)
      err=save_screen({{1,1},{width_p, height_p}},file)
    elsif format=2 then
     write_pic(file,temp_image)
    else
      puts(1,"\n could not save")
      sleep(2)
    end if
    end if
  end if
  end if
end procedure

draw_pos(1,1,1)
draw_colors(0,560)
integer button1,button2,button3,button4,button5,button6,button7,button8,button9
button1=create({"button",550,20,"zoom -"})
button2=create({"button",550,50,"zoom +"})
button3=create({"button",550,80,"mode"})
button4=create({"button",550,110,"new "})
button5=create({"button",550,140,"open"})
button6=create({"button",550,170,"save"})
button7=create({"button",550,260,"exit"})
button8=create({"button",550,200,"soid"})
button9=create({"button",550,230,"grid"})
integer button10,button11,button12
button10=create({"button",650,20,"rotate"})
button11=create({"button",650,50,"filp v"})
button12=create({"button",650,80,"filp h"})
integer bm1,bm2,bm3,bm4,button13
button13=create({"button",650,110,"colors"})
image={}
load_images("a_u.pic")
bm1=create({"button_image",680,150,{image[1][1],image[2][1]}})
image={}
load_images("a_l.pic")
bm2=create({"button_image",657,173,{image[1][1],image[2][1]}})
image={}
load_images("a_d.pic")
bm3=create({"button_image",680,173,{image[1][1],image[2][1]}})
image={}
load_images("a_r.pic")
bm4=create({"button_image",703,173,{image[1][1],image[2][1]}})

procedure colors()
  for i=1 to height_p do
     for j=1 to width_p do
        if temp_image[i][j]=-1 then
          temp_image[i][j]=0
        elsif temp_image[i][j]=0 then
          temp_image[i][j]=-1
        elsif temp_image[i][j]=1 then
          temp_image[i][j]=14
        elsif temp_image[i][j]=2 then
          temp_image[i][j]=13
        elsif temp_image[i][j]=3 then
          temp_image[i][j]=12
        elsif temp_image[i][j]=4 then
          temp_image[i][j]=11
        elsif temp_image[i][j]=5 then
          temp_image[i][j]=10
        elsif temp_image[i][j]=6 then
          temp_image[i][j]=9
        elsif temp_image[i][j]=7 then
          temp_image[i][j]=8
        elsif temp_image[i][j]=8 then
          temp_image[i][j]=7
        elsif temp_image[i][j]=9 then
          temp_image[i][j]=6
        elsif temp_image[i][j]=10 then
          temp_image[i][j]=5
        elsif temp_image[i][j]=11 then
          temp_image[i][j]=4
        elsif temp_image[i][j]=12 then
          temp_image[i][j]=3
        elsif temp_image[i][j]=13 then
          temp_image[i][j]=2
        elsif temp_image[i][j]=14 then
          temp_image[i][j]=1
        elsif temp_image[i][j]=15 then
          temp_image[i][j]=0
        elsif temp_image[i][j]=16 then
          temp_image[i][j]=-1
        end if
     end for
  end for
end procedure

procedure row()
sequence temp
integer l
l=0
  temp=temp_image
  l=height_p
  for i=1 to height_p do
     for j=1 to width_p do
        temp_image[l][j]=temp[j][i]
     end for
    l-=1
  end for
end procedure

procedure flip_h()
for i=1 to length(temp_image) do
  temp_image[i]=reverse(temp_image[i])
end for
end procedure

procedure flip_v()
  temp_image=reverse(temp_image)
end procedure

procedure move_picture(integer move)
sequence temp1,temp2
temp1=temp_image
temp2=temp_image
  if move=1 then
    for i=2 to height_p do
       temp1[i-1]=temp_image[i]
    end for
    temp1[height_p]=temp_image[1]
    temp_image=temp1
  elsif move=2 then
    for i=2 to height_p do
       for j=1 to width_p do
          temp1[j][i-1]=temp_image[j][i]
       end for
    end for
    for j=1 to width_p do
       temp1[j][height_p]=temp_image[j][1]
    end for
    temp_image=temp1
  elsif move=3 then
    for i=2 to height_p do
       temp1[i]=temp_image[i-1]
    end for
    temp1[1]=temp_image[height_p]
    temp_image=temp1
  elsif move=4 then
    for i=2 to height_p do
       for j=1 to width_p do
          temp1[j][i]=temp_image[j][i-1]
       end for
    end for
    for j=1 to width_p do
       temp1[j][1]=temp_image[j][height_p]
    end for
    temp_image=temp1
  end if
end procedure

procedure commands()
  if on_click({"button",button1})=1 then
    if zoom_x>1 then
    zoom_x-=1
    zoom_y-=1
    cls()
    draw_colors(0,560)
    draw_pos(x1,y1,1)
    end if
  end if
  if on_click({"button",button2})=1 then
    if zoom_x*height_p<500 then
    zoom_x+=1
    zoom_y+=1
    cls()
    draw_colors(0,560)
    draw_pos(x1,y1,1)
    end if
  end if
  if on_click({"button",button3})=1 then
    mode+=1
    if mode=6 then
      mode=1
    end if
    draw_colors(0,560)
  end if
  if on_click({"button",button4})=1 then
    if show_q("Start New Image")=1 then
      new()
    end if
    cls()
    draw_colors(0,560)
    draw_pos(x1,y1,1)
  end if
  if on_click({"button",button5})=1 then
    open_pic()
    colors()
    colors()
    cls()
    draw_colors(0,560)
    draw_pos(x1,y1,1)
  end if
  if on_click({"button",button6})=1 then
    save()
    cls()
    draw_colors(0,560)
    draw_pos(x1,y1,1)
  end if
  if on_click({"button",button7})=1 then
    if show_q("Do You Want To Exit")=1 then
      clear_screen()
      if graphics_mode(18) then
      end if
      abort(0)
    end if
    cls()
    draw_colors(0,560)
    draw_pos(x1,y1,1)
  end if
  if on_click({"button",button8})=1 then
    if soid=0 then
      soid=1
    else
      soid=0
    end if
    draw_colors(0,560)
  end if
  if on_click({"button",button9})=1 then
    if grid2=0 then
      grid2=1
    else
      grid2=0
    end if
    draw_colors(0,560)
    draw_pos(x1,y1,1)
  end if
  if on_click({"button",button10})=1 then
    row()
    draw_colors(0,560)
    draw_pos(x1,y1,1)
  end if
  if on_click({"button",button11})=1 then
    flip_v()
    draw_colors(0,560)
    draw_pos(x1,y1,1)
  end if
  if on_click({"button",button12})=1 then
    flip_h()
    draw_colors(0,560)
    draw_pos(x1,y1,1)
  end if
  if on_click({"button",button13})=1 then
    colors()
    draw_colors(0,560)
    draw_pos(x1,y1,1)
  end if
  if on_click({"button_image",bm1})=1 then
    move_picture(1)
    draw_colors(0,560)
    draw_pos(x1,y1,1)
  end if
  if on_click({"button_image",bm2})=1 then
    move_picture(2)
    draw_colors(0,560)
    draw_pos(x1,y1,1)
  end if
  if on_click({"button_image",bm3})=1 then
    move_picture(3)
    draw_colors(0,560)
    draw_pos(x1,y1,1)
  end if
  if on_click({"button_image",bm4})=1 then
    move_picture(4)
    draw_colors(0,560)
    draw_pos(x1,y1,1)
  end if
end procedure

draw_pos(1,1,1)
draw_colors(0,560)

while 1 do
key=get_key()
if key != -1 then
 if key=27 then
  exit
 end if
end if
mouse()
draw_mouse()
commands()
sel_color(0,560)
button_dos()
button_image_dos()
listview_dos()
textbox_dos()
end while
