without type_check
include graphics.e
include mouse2.e
include font.e

atom key, get_button,richedit_number,selete,draw_all
draw_all=0
get_button=0
sequence richedit_info
selete=1
richedit_number=1
richedit_info={}

if graphics_mode(258) then
end if

procedure line(atom x, atom y, atom xx, atom yy, atom color)
draw_line(color,{{x,y},{xx,yy}})
end procedure

procedure rectangle(atom x,atom y,atom xx,atom yy,atom color,atom sel)
polygon(color, sel, {{x, y}, {xx, y}, {xx, yy},{x,yy}})
end procedure

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

procedure richedit()
atom line1,chr1,x,y,width,height,draw,mode,window_id
atom number1,number2,init,text_height,can,screen_chr1,text_width,temp_p,sel
atom timer1,t,can2,temp1
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
    sel=richedit_info[l][16]
    timer1=richedit_info[l][17]
    can2=richedit_info[l][18]
    window_id=richedit_info[l][19]

     if init=1 then
       if length(text)>text_height then
         number2=length(text)-text_height
         number2+=temp_p-1
         if can=0 then
         can=1
         draw=1
         end if
       init=0
     else
      if can=1 then
      can=0
      draw=1
      end if
     end if
         for i=number1 to length(text)-number2 do
           if length(text[i])>text_width then
             temp1=1
             exit
           else
           temp1=0
           end if
         end for
         if temp1=1 and can2=1 then
         elsif can2=0 and temp1=1 then
           can2=1
           draw=1
         elsif can2=1 and temp1=0 then
           can2=0
           draw=1
         end if
     end if

     if mouse_x>x and mouse_x<x+width and mouse_y>y and mouse_y<y+height and mouse_button=mb_left and sel=0 then
       for j=1 to length(richedit_info) do
          richedit_info[j][16]=0
       end for
         sel=1
         draw=1
       timer1=time()+2
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
             draw_text({x,y+19*(i-number1+1)-18},temp,BLACK,-1,0)
           end if
         else
           draw_text({x,y+19*(i-number1+1)-18},text[i][screen_chr1..length(text[i])],BLACK,-1,0)
         end if
       end if
     end for

     t=time()
     if t>timer1-2 and t<timer1-1 then
        draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
     end if
     if t>timer1-1 then
        draw_line(-1,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
     end if
     if t>timer1-.30 then
       timer1=time()+2
     end if

     if key=335 then
       rectangle(x,y,x+width-1,y+height-1,-1,1)
       chr1=length(text[line1])
        if chr1>text_width then
          screen_chr1=chr1-text_width+1
        end if
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
     end if

     if key=329 then
       rectangle(x,y,x+width-1,y+height-1,-1,1)
        if line1>1+text_height then
         line1-=8
         number1-=8
         temp_p+=8
        end if
       chr1=0
       screen_chr1=1
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
     end if

     if key=337 then
       rectangle(x,y,x+width-1,y+height-1,-1,1)
        if line1<length(text)-text_height then
         line1+=8
         number1+=8
         temp_p-=8
        end if
       chr1=0
       screen_chr1=1
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
     end if

     if key=327 then
       rectangle(x,y,x+width-1,y+height-1,-1,1)
       chr1=0
       screen_chr1=1
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
      end if

     if key=328 and line1>1 then
      rectangle(x,y,x+width-1,y+height-1,-1,1)
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
       timer1=time()+2
     end if

     if key=336 and line1<length(text) then
       rectangle(x,y,x+width-1,y+height-1,-1,1)
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
       timer1=time()+2
     end if

     if key=331 and chr1>0 then
       rectangle(x,y,x+width-1,y+height-1,-1,1)
       if length(text[line1])>text_width and chr1-(screen_chr1)+1=0 then
         screen_chr1-=1
       end if
       draw_line(-1,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
       chr1-=1
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
       timer1=time()+2
     end if

     if key=333 and chr1<length(text[line1]) then
       rectangle(x,y,x+width-1,y+height-1,-1,1)
       if chr1-(screen_chr1-1)=text_width and length(text[line1])>text_width then
         screen_chr1+=1
       end if
       draw_line(-1,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
       chr1+=1
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
       timer1=time()+2
     end if

     if key >2 and key <256 then
       if key!=128 and key!=64 and key!=27 and key!=y and key!=13 and key!=8 and key!=4 then
         rectangle(x,y,x+width-1,y+height-1,-1,1)
         if chr1-(screen_chr1-1)=text_width then
           screen_chr1+=1
         end if
         text[line1]=string_insert(chr1,key,text[line1])
         draw_line(-1,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
         chr1+=1
         draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
         timer1=time()+2
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
        draw_line(-1,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
        chr1-=1
        rectangle(x,y,x+width-1,y+height-1,-1,1)
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
        draw_line(-1,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
        line1-=1
        rectangle(x,y,x+width-1,y+height-1,-1,1)
        draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
      elsif line1>1 then
          chr1-=1
      end if
      timer1=time()+2
      end if

     if key=13 then
       timer1=time()+2
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
       draw_line(-1,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
       line1+=1
       rectangle(x,y,x+width-1,y+height-1,-1,1)
       draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
     end if
     end if

    if draw=1 then
     rectangle(x-2,y-2,x+width+3,y+height+2,-1,1)
     rectangle(x-2,y-2,x+width+3,y+height+2,0,0)
     rectangle(x,y,x+width-1,y+height-1,-1,1)
     line(x-1,y-1,x+width+1,y-1,8)
     line(x-1,y+height+1,x+width+1,y+height+1,7)
     line(x-1,y-1,x-1,y+height+1,8)
     line(x+width+2,y-1,x+width+2,y+height+1,7)
     rectangle(x-2,y+height+2,x+width+3,y+height+2+12,-1,1)
     rectangle(x-2,y+height+2,x+width+3,y+height+2+12,0,0)
     rectangle(x+width+3,y-2,x+width+3+12,y+height+2,-1,1)
     rectangle(x+width+3,y-2,x+width+3+12,y+height+2,0,0)

   if can2=1 then
     -- left
     rectangle(x-2,y+height+2,x+14,y+height+2+12,7,1)
     rectangle(x-2,y+height+2,x+14,y+height+2+12,0,0)

     line(x+6,y+height+2+2,x+6,y+height+2+10,0)
     line(x+5,y+height+2+3,x+5,y+height+2+9,0)
     line(x+4,y+height+2+4,x+4,y+height+2+8,0)
     line(x+3,y+height+2+5,x+3,y+height+2+7,0)

     -- right
     rectangle(x+width-14,y+height+2,x+width+3,y+height+2+12,7,1)
     rectangle(x+width-14,y+height+2,x+width+3,y+height+2+12,0,0)

     line(x+width-1,y+height+2+5,x+width-1,y+height+2+7,0)
     line(x+width-2,y+height+2+4,x+width-2,y+height+2+8,0)
     line(x+width-3,y+height+2+3,x+width-3,y+height+2+9,0)
     line(x+width-4,y+height+2+2,x+width-4,y+height+2+10,0)


   end if
   if can=1 then
     --up
     rectangle(x+width+4,y-1,x+width+4+10,y+12,7,1)
     rectangle(x+width+3,y-2,x+width+4+11,y+13,0,0)
     line(x+width+4+5,y+1,x+width+4+5,y+1,0)
     line(x+width+4+4,y+2,x+width+4+6,y+2,0)
     line(x+width+4+3,y+3,x+width+4+7,y+3,0)
     line(x+width+4+2,y+4,x+width+4+8,y+4,0)
     --down
     rectangle(x+width+4,y+height+1,x+width+4+10,y+height-12,7,1)
     rectangle(x+width+3,y+height+2,x+width+4+11,y+height-13,0,0)
     line(x+width+4+2,y+height-5,x+width+4+8,y+height-5,0)
     line(x+width+4+3,y+height-4,x+width+4+7,y+height-4,0)
     line(x+width+4+4,y+height-3,x+width+4+6,y+height-3,0)
     line(x+width+4+5,y+height-2,x+width+4+5,y+height-2,0)
   end if
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
     draw_text({x,y+19*(i-number1+1)-18},temp,BLACK,-1,0)
     end if
     else
     draw_text({x,y+19*(i-number1+1)-18},text[i][screen_chr1..length(text[i])],BLACK,-1,0)
     end if
     end if
     end for
     if sel=1 then
     draw_line(BLACK,{{x+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)},{x+8+(chr1-screen_chr1+1)*8,y+19*(line1-number1+1)}})
     end if
     end if
  richedit_info[l][5]=text
  richedit_info[l][6]=chr1
  richedit_info[l][7]=line1
  richedit_info[l][8]=draw
  richedit_info[l][9]=mode
  richedit_info[l][10]=number1
  richedit_info[l][11]=number2
  richedit_info[l][13]=can
  richedit_info[l][14]=screen_chr1
  richedit_info[l][15]=temp_p
  richedit_info[l][16]=sel
  richedit_info[l][17]=timer1
  richedit_info[l][18]=can2
end for
end procedure

richedit_number+=1
richedit_info=append(richedit_info,{10,10,300,200,{""},0,1,1,1,1,0,1,0,1,0,0,0,0,1,richedit_number})

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

rectangle(1,1,800,600,-1,1)

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
richedit()
end while
