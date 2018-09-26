without type_check
include graphics.e
include image.e
include mouse2.e
include get.e
include file.e

global sequence screen, screen2
sequence textbox_info, button_info ,font_index, listview_info, menu_info
sequence richedit_info, combox_info, lable_info, treeview_info
atom textbox_number,button_number, listview_number, menu_number, treeview_number
atom richedit_number, combox_number, lable_number
textbox_number=0
treeview_number=0
button_number=0
menu_number=0
lable_number=0
combox_number=0
richedit_number=0
listview_number=0
integer screen_width, screen_height
screen_width=640
screen_height=480
constant CLEAR=-1
textbox_info={}
button_info={}
listview_info={}
menu_info={}
lable_info={}
combox_info={}
richedit_info={}
treeview_info={}

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

global function create_ex(sequence string)
  if compare(string[1],"lable")=0 then
    lable_number+=1
    lable_info=append(lable_info,{string[2],string[3],0,0,string[4],1,lable_number})
    return lable_number
  end if
  if compare(string[1],"textbox")=0 then
    textbox_number+=1
    textbox_info=append(textbox_info,{string[2],string[3],string[4],"",0,0,1,1,textbox_number})
    return textbox_number
  end if
  if compare(string[1],"listview")=0 then
    listview_number+=1
    listview_info=append(listview_info,{string[2],string[3],string[4],string[5],1,0,string[6],1,0,0,"",listview_number})
    return listview_number
  end if
  if compare(string[1],"combox")=0 then
    combox_number+=1
    combox_info=append(combox_info,{string[2],string[3],0,string[5],string[6],0,0,1,0,0,"","",1,combox_number})
    return combox_number
  end if
  if compare(string[1],"button")=0 then
    button_number+=1
    button_info=append(button_info,{string[2],string[3],string[4],1,0,button_number})
    return button_number
  end if
  if compare(string[1],"menu")=0 then
    menu_number+=1
    menu_info=append(menu_info,{string[2],string[3],string[4],0,0,0,0,0,{0},{0},"",1,menu_number})
    return menu_number
  end if
  if compare(string[1],"richedit")=0 then
    richedit_number+=1
    richedit_info=append(richedit_info,{string[2],string[3],string[4],string[5],{""},0,1,1,richedit_number})
    return richedit_number
  end if
end function

global procedure add_item(sequence string)
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         listview_info[i][7]=append(listview_info[i][7],string[3])
         listview_info[i][8]=1
       end if
    end for
  end if
end procedure

global procedure add_all_item(sequence string)
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         listview_info[i][7]=string[3]
             listview_info[i][5]=1
             listview_info[i][9]=0
             listview_info[i][8]=1
             listview_info[i][10]=0
             listview_info[i][6]=0
       end if
    end for
  end if
end procedure

global procedure delete_item(sequence string)
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         for j=1 to length(listview_info[i][7]) do
           if compare(string[3],listview_info[i][7][j])=0 then
             listview_info[i][7]=remove_line(listview_info[i][7],j)
             listview_info[i][5]=1
             listview_info[i][9]=0
             listview_info[i][8]=1
             listview_info[i][10]=0
             listview_info[i][6]=0
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
       if listview_info[i][12]=string[2] then
             listview_info[i][7]=""
             listview_info[i][5]=1
             listview_info[i][9]=0
             listview_info[i][8]=1
             listview_info[i][10]=0
             listview_info[i][6]=0
       end if
    end for
  end if
end procedure

global function get_all_item(sequence string)
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
           return listview_info[i][7]
       end if
    end for
  end if
end function

global procedure set_sel_item(sequence string)
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         listview_info[i][10]=string[3]
       end if
    end for
  end if
end procedure

global function get_text(sequence string)
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][6]=string[2] then
         return button_info[i][1]
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         if listview_info[i][10]=0 then
           return ""
         else
           return listview_info[i][7][listview_info[i][10]]
         end if
       end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][7]=string[2] then
           return lable_info[i][5]
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][14]=string[2] then
           return combox_info[i][11]
       end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][9]=string[2] then
           return textbox_info[i][4]
       end if
    end for
  end if
  if compare(string[1],"richedit")=0 then
    for i=1 to length(richedit_info) do
       if richedit_info[i][9]=string[2] then
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
       if textbox_info[i][9]=string[2] then
           textbox_info[i][4]=string[3]
           textbox_info[i][6]=0
           textbox_info[i][8]=1
       end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][7]=string[2] then
           lable_info[i][5]=string[3]
           lable_info[i][3]=0
           lable_info[i][6]=1
       end if
    end for
  end if
  if compare(string[1],"richedit")=0 then
    for i=1 to length(richedit_info) do
       if richedit_info[i][9]=string[2] then
           richedit_info[i][5]=string[3]
           richedit_info[i][6]=0
           richedit_info[i][7]=1
       end if
    end for
  end if
end procedure

global function get_x(sequence string)
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][6]=string[2] then
         return button_info[i][2]
       end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][9]=string[2] then
         return textbox_info[i][1]
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         return listview_info[i][1]
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][14]=string[2] then
         return combox_info[i][1]
       end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][7]=string[2] then
           return lable_info[i][1]
       end if
    end for
  end if
end function

global function get_y(sequence string)
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][6]=string[2] then
         return button_info[i][3]
       end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][9]=string[2] then
         return textbox_info[i][2]
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         return listview_info[i][2]
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][14]=string[2] then
         return combox_info[i][2]
       end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][7]=string[2] then
           return lable_info[i][2]
       end if
    end for
  end if

end function

global function get_width(sequence string)
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][6]=string[2] then
         return (length(button_info[i][1])+2)*8
       end if  
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][9]=string[2] then
         return textbox_info[i][3]
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         return listview_info[i][3]
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][14]=string[2] then
         return combox_info[i][3]
       end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][7]=string[2] then
           return lable_info[i][3]
       end if
    end for
  end if

end function

global function get_height(sequence string)
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][6]=string[2] then
         return 18
       end if  
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][9]=string[2] then
         return 20
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         return listview_info[i][4]
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][14]=string[2] then
         return combox_info[i][4]
       end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][7]=string[2] then
           return lable_info[i][4]
       end if
    end for
  end if
end function

global function over(sequence string)
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][7]=string[2] then
         if mouse_x>get_x({"lable",string[2]}) and mouse_x<(get_x({"lable",string[2]})+get_width({"lable",string[2]}))
         and mouse_y>get_y({"lable",string[2]}) and mouse_y<(get_y({"lable",string[2]})+get_height({"lable",string[2]})) then
         return 1
        end if
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][14]=string[2] then
         if mouse_x>get_x({"combox",string[2]}) and mouse_x<(get_x({"combox",string[2]})+get_width({"combox",string[2]}))
         and mouse_y>get_y({"combox",string[2]}) and mouse_y<(get_y({"combox",string[2]})+20) then
         return 1
         end if
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         if mouse_x>get_x({"listview",string[2]}) and mouse_x<(get_x({"listview",string[2]})+get_width({"listview",string[2]}))
         and mouse_y>get_y({"listview",string[2]}) and mouse_y<(get_y({"listview",string[2]})+get_height({"listview",string[2]})) then
         return 1
         end if
       end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][9]=string[2] then
         if mouse_x>get_x({"textbox",string[2]}) and mouse_x<(get_x({"textbox",string[2]})+get_width({"textbox",string[2]}))
         and mouse_y>get_y({"textbox",string[2]}) and mouse_y<(get_y({"textbox",string[2]})+get_height({"textbox",string[2]})) then
         return 1
         end if
       end if
    end for
  end if
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][6]=string[2] then
         if mouse_x>get_x({"button",string[2]}) and mouse_x<(get_x({"button",string[2]})+get_width({"button",string[2]}))
         and mouse_y>get_y({"button",string[2]}) and mouse_y<(get_y({"button",string[2]})+get_height({"button",string[2]})) then
         return 1
         end if
       end if
    end for
  end if
return 0
end function

global procedure set_width(sequence string)
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][9]=string[2] then
         textbox_info[i][3]=string[3]
         exit
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         listview_info[i][3]=string[3]
         exit
       end if
    end for
  end if
end procedure

global procedure set_height(sequence string)
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         listview_info[i][4]=string[3]
         exit
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][14]=string[2] then
         combox_info[i][4]=string[3]
         exit
       end if
    end for
  end if
end procedure

global procedure set_x(sequence string)
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][6]=string[2] then
         button_info[i][2]=string[3]
         exit
       end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][9]=string[2] then
         textbox_info[i][1]=string[3]
         exit
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         listview_info[i][1]=string[3]
         exit
       end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][7]=string[2] then
         lable_info[i][1]=string[3]
         exit
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][14]=string[2] then
         combox_info[i][1]=string[3]
       end if
    end for
  end if
end procedure

global procedure set_y(sequence string)
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][6]=string[2] then
         button_info[i][3]=string[3]
         exit
       end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][9]=string[2] then
         textbox_info[i][2]=string[3]
         exit
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         listview_info[i][2]=string[3]
         exit
       end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][7]=string[2] then
           lable_info[i][2]=string[3]
           exit
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][14]=string[2] then
         combox_info[i][2]=string[3]
       end if
    end for
  end if
end procedure

global function on_click(sequence string)
sequence temp
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][6]=string[2] then
         if button_info[i][5]=1 then
           button_info[i][5]=0
           mouse_button=0
           return 1
         else
           mouse_button=0
           return 0
         end if
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         if length(listview_info[i][11])>0 then
           listview_info[i][11]=""
           mouse_button=0
           return 1
         else
           mouse_button=0
           return 0
         end if
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][14]=string[2] then
         if length(combox_info[i][12])>0 then
           combox_info[i][12]=""
           mouse_button=0
           return 1
         else
           mouse_button=0
           return 0
         end if
       end if
    end for
  end if
  if compare(string[1],"menu")=0 then
    for i=1 to length(menu_info) do
       if menu_info[i][13]=string[2] then
         if compare(menu_info[i][11],string[3])=0 then
           mouse_button=0
           temp=menu_info[i][11]
           menu_info[i][11]=""
           return 1
         else
           mouse_button=0
           return 0
         end if
       end if
    end for
  end if
return 0
end function

global procedure delete(sequence string)
  if compare(string[1],"button")=0 then
    for i=1 to length(button_info) do
       if button_info[i][6]=string[2] then
         button_info=remove_line(button_info,i)
         exit
       end if
    end for
  end if
  if compare(string[1],"textbox")=0 then
    for i=1 to length(textbox_info) do
       if textbox_info[i][9]=string[2] then
         textbox_info=remove_line(textbox_info,i)
         exit
       end if
    end for
  end if
  if compare(string[1],"listview")=0 then
    for i=1 to length(listview_info) do
       if listview_info[i][12]=string[2] then
         listview_info=remove_line(listview_info,i)
         exit
       end if
    end for
  end if
  if compare(string[1],"lable")=0 then
    for i=1 to length(lable_info) do
       if lable_info[i][7]=string[2] then
           lable_info=remove_line(lable_info,i)
           exit
       end if
    end for
  end if
  if compare(string[1],"combox")=0 then
    for i=1 to length(combox_info) do
       if combox_info[i][14]=string[2] then
         combox_info=remove_line(combox_info,i)
         exit
       end if
    end for
  end if

end procedure

global function string_insert(atom pos, atom insert, sequence string2)
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

global function add_line(sequence string, atom line)
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

global function remove_string(atom pos, sequence string2)
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

global procedure new_screen(atom color)
screen={}
   for i=1 to screen_height do
      screen=append(screen,repeat(color, screen_width)) 
   end for
screen2=screen
end procedure

global function transparent(sequence image, atom color)
 for i=1 to length(image) do
    for j=1 to length(image[i]) do
       if image[i][j]= color then
         image[i][j]=-1
       end if
    end for
 end for
return image
end function

global procedure write_screen(sequence image, sequence xy, atom can)
  atom x, y, line, width, height
  width=length(image[1])
  height=length(image)
  x=xy[1]
  y=xy[2]
  line=1
if can=1 then
 if x>=1 and x+width<=640 and y>=1 and y+height<=480 then
 for i=1 to length(image) do
    for j=1 to length(image[i]) do
       if image[i][j]!= -1 then
         screen[y+(i-1)][x+(j-1)]=image[i][j]
       end if
    end for
 end for
 end if
else
 if x>=1 and x+width<=640 and y>=1 and y+height<=480 then
 for i=y to length(screen) do
    if line<=length(image) then
      screen[i][x..(x+length(image[line])-1)]=image[line]
    else
      exit
    end if
  line+=1
  end for
  end if
end if
end procedure

function rtrim(sequence s)
integer i
i=length(s)
while i do
if s[i] then exit end if
i=i-1
end while
return s[1..i]
end function

procedure load_font() 
sequence cb,regs
integer a
regs = repeat(0,10)
regs[REG_AX]=#1130
regs[REG_BX]=#600
regs=dos_interrupt(#10,regs)
a=#10*regs[REG_ES]+regs[REG_BP]
font_index={}
for i=1 to 256 do
cb=rtrim(peek({a,16}))
for j=1 to length(cb) do
cb[j]=rtrim(and_bits(cb[j],{128,64,32,16,8,4,2,1}) and 1)
end for
a += 16
font_index = append(font_index,cb)
end for
end procedure

global procedure draw_text(sequence loc,sequence text,atom fc,atom bc,atom dir,sequence info)
sequence c,cj,s
integer col,len,row,u,x,y
atom size, can
size=info[2]
can=info[1]
len = length(text)
if can=1 then
if len>=size then
text=text[1..size]
end if
len = length(text)
end if
x = loc[1]
y = loc[2]
if dir = 'd' or dir = 'D' then
if bc = CLEAR then
s = save_image({x,y},{x+7,y+16*len-1})
else
s = repeat(repeat(bc, 8), 16*len)
end if
row = 1
for i=1 to len do
c = font_index[1+text[i]]
u = row
for j=1 to length(c) do
cj = c[j]
for k=1 to length(cj) do
if cj[k] then
s[u][k] = fc
end if
end for
u += 1
end for
row += 16
end for
else
if bc = CLEAR then
s = save_image({x,y},{x+8*len-1,y+15})
else
s = repeat(repeat(bc, 8*len), 16)
end if
col = 1
for i=1 to len do
c = font_index[1+text[i]]
for j=1 to length(c) do
cj = c[j]
u = col
for k=1 to length(cj) do
if cj[k] then
s[j][u] = fc
end if
u += 1
end for
end for
col += 8
end for
end if
write_screen(s,{x,y},1)
end procedure
load_font()

global procedure draw_lines(atom x, atom y, atom xx,  atom color)
sequence image
image={}
image=append(image,repeat(color, xx))
write_screen(image,{x,y},0)
end procedure

global procedure rectangle(atom x, atom y, atom xx, atom yy, atom color, atom fill)
sequence image
atom width, height, x_pos, y_pos
if xx>x then
width=xx-x
x_pos=x
else
width=x-xx
x_pos=xx
end if
if yy>y then
height=yy-y
y_pos=y
else
height=y-yy
y_pos=yy
end if
image={}
if fill=1 then
for i=1 to height do
   image=append(image,repeat(color, width))
end for
write_screen(image,{x_pos,y_pos},0)
else
for i=1 to height do
   image=append(image,repeat(-1, width))
end for
for i=1 to length(image) do
   for j=1 to length(image[i]) do
      if j=1 or j = length(image[i]) then
        image[i][j]=color
      end if
      if i=1 or i=length(image) then
        image[i][j]=color
      end if
   end for
end for
write_screen(image,{x_pos,y_pos},1)
end if
end procedure

procedure textbox()
atom x,y,width,init,sel,height,chr1,screen_chr1,gaz
sequence text
  for i=1 to length(textbox_info) do
     x=textbox_info[i][1]
     y=textbox_info[i][2]
     width=textbox_info[i][3]
     gaz=floor((width-8)/8)
     height=20
     text=textbox_info[i][4]
     sel=textbox_info[i][5]
     chr1=textbox_info[i][6]
     init=textbox_info[i][7]
     screen_chr1=textbox_info[i][8]
     rectangle(x,y,x+width,y+height,7,1)
     rectangle(x,y,x+width,y+height,0,0)
     rectangle(x+1,y+1,x+width-1,y+height-1,WHITE,1)
     draw_text({x+2,y+2},text[screen_chr1..length(text)],0,7,0,{1,gaz})
     if sel=1 then
     draw_lines(x+2+(chr1-screen_chr1+1)*8,y+18,8,0)
     if key !=-1 then
       if key >2 and key <256 then
         if key!=128 and key!=64 and key!=27 and key!=16 and key!=13 and key!=8 and key!=4 then
           if chr1-(screen_chr1-1)=gaz then
             screen_chr1+=1
           end if
           text=string_insert(chr1,key,text)
           chr1+=1
          end if
       end if
      if key=331 and chr1>0 then
         if length(text)>gaz and chr1-(screen_chr1)+1=0 then
           screen_chr1-=1
         end if
         chr1-=1
       end if
       if key=333 and chr1<length(text) then
          if chr1-(screen_chr1-1)=gaz and length(text)>gaz then
            screen_chr1+=1
          end if
         chr1+=1
       end if
       if key=8 and chr1>=1 then
         if length(text)>gaz and chr1-(screen_chr1)+1=0 then
           screen_chr1-=2
         elsif length(text)>gaz and screen_chr1>1 then
          screen_chr1-=1
         end if
         text=remove_string(chr1,text)
         chr1-=1
       end if
       if key=339 and chr1>=0 and chr1!=length(text) then
         text=remove_string(chr1+1,text)
       end if
       if key=13 then
         sel=0
       end if
     end if
     else
     if mouse_x>x and mouse_x<x+width and mouse_y>y and mouse_y<y+height and mouse_button=mb_left then
       for j=1 to length(textbox_info) do
          textbox_info[j][5]=0
       end for
       sel=1
       mouse_button=0
     end if
     end if
     textbox_info[i][4]=text
     textbox_info[i][5]=sel
     textbox_info[i][6]=chr1
     textbox_info[i][7]=init
     textbox_info[i][8]=screen_chr1
  end for
end procedure

procedure button()
atom x,y,width,init,sel
sequence name
  for i=1 to length(button_info) do
     name=button_info[i][1]
     x=button_info[i][2]
     y=button_info[i][3]
     width=length(name)
     init=button_info[i][4]
     sel=button_info[i][5]
     width+=2
     width=width*8
     rectangle(x,y,x+width,y+18,0,0)
     rectangle(x+1,y+1,x+width-1,y+17,WHITE,1)
     draw_text({x+8,y+1},name,BLACK,WHITE,1,{0,0})
     if mouse_x>x and mouse_x< x+width and mouse_y>y and mouse_y<y+18 then
       rectangle(x+6,y+1,x+width-6,y+17,0,0)
     else
       rectangle(x+6,y+1,x+width-6,y+17,WHITE,0)
     end if
     if mouse_x>x and mouse_x< x+width and mouse_y>y and mouse_y<y+18 and mouse_button=mb_left then
       sel=1
       mouse_button=0
     end if
      button_info[i][4]=init
      button_info[i][5]=sel
  end for
end procedure

procedure listview()
atom x, y , width, height, number1, number2, init, color, can, sel,gaz
sequence string,temp
  for i=1 to length(listview_info) do
     x=listview_info[i][1]
     y=listview_info[i][2]
     width=listview_info[i][3]
     height=listview_info[i][4]
     gaz=height/16
     number1=listview_info[i][5]
     number2=listview_info[i][6]
     string=listview_info[i][7]
     init=listview_info[i][8]
     can=listview_info[i][9]
     sel=listview_info[i][10]
     temp=listview_info[i][11]
     if init=1 then
       if length(string)>gaz then
         number2=length(string)-gaz
         can=1
       end if
       init=0
     end if
     rectangle(x,y,x+width,y+height,7,1)
     rectangle(x,y,x+width,y+height,0,0)
       if can=1 then
         rectangle(x+width+1,y,x+width+10,y+height,GRAY,1)
         rectangle(x+width+1,y,x+width+10,y+10,0,1)
         rectangle(x+width+1,y+height-10,x+width+10,y+height,0,1)
       end if
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
        end if
        if j=sel then
          rectangle(x+2,y+2+(16*(j-number1)),x+width-2,y+2+(16*(j-number1))+16,9,1)
          color=9
        end if
        draw_text({x+2,y+2+(16*(j-number1))},string[j],BLACK,color,0,{0,0})
     end for
     listview_info[i][5]=number1
     listview_info[i][6]=number2
     listview_info[i][8]=init
     listview_info[i][9]=can
     listview_info[i][10]=sel
     listview_info[i][11]=temp
  end for
end procedure

procedure richedit()
atom line1,chr1,x,y,width,height,init
sequence text
for l=1 to length(richedit_info) do
  x=richedit_info[l][1]
  y=richedit_info[l][2]
  width=richedit_info[l][3]
  height=richedit_info[l][4]
  text=richedit_info[l][5]
  chr1=richedit_info[l][6]
  line1=richedit_info[l][7]
  init=richedit_info[l][8]
  if init=1 then
    init=0
  end if
  if key=328 and line1>1 then
  line1-=1
  if length(text[line1])>= chr1 then
  else
  chr1=length(text[line1])
  end if
  end if
  if key=336 and line1<length(text) then
  line1+=1
  if length(text[line1])>= chr1 then
  else
  chr1=length(text[line1])
  end if
  end if
  if key=331 and chr1>0 then
  chr1-=1
  end if
  if key=333 and chr1<length(text[line1]) then
  chr1+=1
  end if
  if key >2 and key <256 then
  if key!=128 and key!=64 and key!=27 and key!=16 and key!=13 and key!=8 and key!=4 then
  text[line1] =string_insert(chr1,key,text[line1]) 
  chr1+=1
  end if
  end if
  if key=8 then
  if chr1>=1 then
  text[line1]=remove_string(chr1,text[line1])
  chr1-=1
  elsif chr1<0 and line1>1 then
  if length(text[line1-1])>0 then
  text[line1-1]&=text[line1][1..length(text[line1])]
  chr1=length(text[line1-1])
  else
  chr1=0
  end if
  text=remove_line(text,line1)
  line1-=1
  elsif line1>1 then
  chr1-=1
  end if
  end if
  if key=339 then
  if  chr1>=0 and chr1!=length(text[line1]) then
  text[line1]=remove_string(chr1+1,text[line1])
  elsif chr1=length(text[line1]) then
  if line1<length(text) then
  text[line1]&=text[line1+1]
  text=remove_line(text,line1+1)
  end if
  end if
  end if
  if key=13 then
  text=add_line(text,line1)
  if chr1=length(text[line1]) then
  chr1=0
  else
  text[line1+1]=text[line1][chr1+1..length(text[line1])]
  text[line1]=text[line1][1..chr1]
  chr1=0
  end if
  line1+=1
  end if
  for i=1 to length(text) do
  draw_text({x+2,y+16*i-16},text[i],BLACK,WHITE,0,{0,0})
  end for
  draw_lines(x+chr1*8,y+16*line1+2,8,0)
  richedit_info[l][5]=text
  richedit_info[l][6]=chr1
  richedit_info[l][7]=line1
  richedit_info[l][8]=init
end for
end procedure

global procedure menu()
atom width,sel,open,number,sel2,x,y,init
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
rectangle(x,y,639,y+20,7,1)
for i=1 to length(string) do
   width+=menu_width[i]*8
   if mouse_x>x+width and mouse_x<x+width+menu_width[i+1]*8 and mouse_y>y+2 and mouse_y<y+20 then
     sel=i
   else
     sel=0
   end if
   if mouse_x>x+width and mouse_x<x+width+menu_width[i+1]*8 and mouse_y>y+2 and mouse_y<y+20 and mouse_button=mb_left then
     open=1
     number=i
     mouse_button=0
   end if
   if i=sel then
   rectangle(x+width,y,x+width+menu_width[i+1]*8,y+20,9,1)
   draw_text({x+2+width,y+2},string[i][1],BLACK,9,0,{0,0})
   else
   rectangle(x+width,y,x+width+menu_width[i+1]*8,y+20,WHITE,1)
   draw_text({x+2+width,y+2},string[i][1],BLACK,WHITE,0,{0,0})
   end if
   if open=1 and number=i then
     rectangle(x+width,y+20,x+width+(menu_width2[i+1]+1)*8,y+20+(length(string[i])-1)*20,WHITE,1)
     for j=2 to length(string[i]) do
        if mouse_x>x+width and mouse_x<x+width+(menu_width2[i+1]+1)*8 and mouse_y>y+20*j-20 and mouse_y<y+20*j then
          sel2=j
        else
          sel2=0
        end if
        if mouse_x>x+width and mouse_x<x+width+(menu_width2[i+1]+1)*8 and mouse_y>y+20*j-20 and mouse_y<y+20*j and mouse_button=mb_left then
          can=string[i][j]
        end if
        if j=sel2 then
          rectangle(x+width,y+20*j-20,x+width+(menu_width2[i+1]+1)*8,y+20*j,9,1)
          draw_text({x+2+width,y+20*j-20},string[i][j],BLACK,9,0,{0,0})
        else
          draw_text({x+2+width,y+20*j-20},string[i][j],BLACK,WHITE,0,{0,0})
        end if
     end for
   end if
end for
width=0
if mouse_button=mb_left then
  open=0
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
end for
end procedure

global procedure combox()
atom x,y,width,height,open,sel,init,text_number,number1,number2,can
sequence string,sel2,temp
  for i=1 to length(combox_info) do
     x=combox_info[i][1]
     y=combox_info[i][2]
     width=combox_info[i][3]
     height=combox_info[i][4]
     height-=20
     text_number=height/16
     text_number-=1
     string=combox_info[i][5]
     open=combox_info[i][6]
     sel=combox_info[i][7]
     number1=combox_info[i][8]
     number2=combox_info[i][9]
     can=combox_info[i][10]
     sel2=combox_info[i][11]
     temp=combox_info[i][12]
     init=combox_info[i][13]
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
     rectangle(x,y,x+width,y+20,7,1)
     rectangle(x,y,x+width,y+20,0,0)
     rectangle(x+width,y,x+width+16,y+20,7,1)
     rectangle(x+width,y,x+width+16,y+20,0,0)
     draw_lines(x+width+2,y+6,12,0)
     draw_lines(x+width+3,y+7,10,0)
     draw_lines(x+width+4,y+8,8,0)
     draw_lines(x+width+5,y+9,6,0)
     draw_lines(x+width+6,y+10,4,0)
     draw_lines(x+width+7,y+11,2,0)
     if open=0 then
     draw_text({x+2,y+2},sel2,BLACK,WHITE,0,{0,0})
     end if
     if mouse_x>x+width and mouse_x<x+width+16 and mouse_y>y and mouse_y<y+20 and mouse_button=mb_left then
       open=1
       mouse_button=0
     end if
     if can=1 and open=1 then
       rectangle(x+width,y+20,x+width+16,y+height,7,1)
       rectangle(x+width,y+20,x+width+16,y+height,0,0)
       rectangle(x+width+1,y+20,x+width+16,y+36,GRAY,1)
       rectangle(x+width+1,y+height-16,x+width+16,y+height,GRAY,1)
     if mouse_x>x+width+1 and mouse_x<x+width+16 and mouse_y>y+20 and mouse_y<y+36 and mouse_button=mb_left then
       if number1>1 then
       number1-=1
       number2+=1
       end if
       mouse_button=0
     end if
     if mouse_x>x+width+1 and mouse_x<x+width+16 and mouse_y>y+height-16 and mouse_y<y+height and mouse_button=mb_left then
        if number2>0 then
        number1+=1
        number2-=1
        end if
        mouse_button=0
     end if
     end if
     if open=1 then
       rectangle(x,y+20,x+width,y+height,7,1)
       rectangle(x,y+20,x+width,y+height,0,0)
       for j=number1 to length(string)-number2 do
          if mouse_x>x and mouse_x<x+width and mouse_y>y+22+16*(j-number1+1)-16 and mouse_y<y+22+16*(j-number1+1) then
            sel=j
          else
            sel=0
          end if
          if mouse_x>x and mouse_x<x+width and mouse_y>y+22+16*(j-number1+1)-16 and mouse_y<y+22+16*(j-number1+1) and mouse_button=mb_left then
            sel2=string[j]
            temp=string[j]
          end if
          if sel=j then
            rectangle(x,y+22+16*(j-number1+1)-16,x+width,y+22+16*(j-number1+1),9,1)
            draw_text({x+2,y+22+16*(j-number1+1)-16},string[j],BLACK,9,0,{0,0})
          else
            draw_text({x+2,y+22+16*(j-number1+1)-16},string[j],BLACK,WHITE,0,{0,0})
          end if
       end for
     end if
     if mouse_button=mb_left then
       open=0
     end if
     combox_info[i][3]=width
     combox_info[i][6]=open
     combox_info[i][7]=sel
     combox_info[i][8]=number1
     combox_info[i][9]=number2
     combox_info[i][10]=can
     combox_info[i][11]=sel2
     combox_info[i][12]=temp
     combox_info[i][13]=init
  end for
end procedure

procedure lable()
atom x,y,init,width,height
sequence string
for i=1 to length(lable_info) do
   x=lable_info[i][1]
   y=lable_info[i][2]
   width=lable_info[i][3]
   height=lable_info[i][4]
   height=20
   string=lable_info[i][5]
   init=lable_info[i][6]
   if init=1 then
     width=length(string)
     width=width*8
     init=0
   end if
   draw_text({x,y},string,BLACK,WHITE,0,{0,0})
   lable_info[i][3]=width
   lable_info[i][4]=height
   lable_info[i][6]=init
end for
end procedure

procedure treeview()
atom x,y,width,height,init,sel
sequence string
  for i=1 to length(treeview_info) do
     x=treeview_info[i][1]
     y=treeview_info[i][2]
     string=treeview_info[i][3]
     width=treeview_info[i][4]
     height=treeview_info[i][5]
     sel=treeview_info[i][6]
     init=treeview_info[i][7]

  end for
end procedure

global procedure draw_screen()
mouse()
display_image({0,0},screen)
screen=screen2
textbox()
button()
listview()
richedit()
lable()
combox()
menu()
end procedure

global function get_filename(sequence name)
atom listview1,button1,button2,textbox1,test
sequence d,line,temp
d={}
line={}
temp={}
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
button1=create_ex({"button","Ok",305,230})
button2=create_ex({"button","Cancle",305,255})
listview1=create_ex({"listview",190,145,100,100,line})
textbox1=create_ex({"textbox",190,252,100})
while 1 do
key=get_key()
if key != -1 then
  if key=27 then
    abort(0)  
  end if
end if
if on_click({"listview",listview1})=1 then
  set_text({"textbox",textbox1,get_text({"listview",listview1})})
end if
if on_click({"button",button1})=1 then
  temp=get_text({"textbox",textbox1})
  delete({"button",button1})
  delete({"button",button2})
  delete({"listview",listview1})
  delete({"textbox",textbox1})
  return temp
end if
if on_click({"button",button2})=1 then
  delete({"button",button1})
  delete({"button",button2})
  delete({"listview",listview1})
  delete({"textbox",textbox1})
  return ""
end if
mouse()
display_image({0,0},screen)
screen=screen2
lable()
combox()
menu()
rectangle(185,120,380,278,7,1)
rectangle(185,120,380,278,0,0)
rectangle(185,120,380,140,0,0)
draw_text({190,122},"Get File Name",BLACK,7,0,{0,0})
button()
textbox()
listview()
end while
return ""
end function

global function show_menu(atom x, atom y, sequence string)
atom width,height,sel
width=0
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
mouse()
display_image({0,0},screen)
screen=screen2
textbox()
lable()
button()
listview()
richedit()
combox()
menu()
rectangle(x,y,x+width,y+height,WHITE,1)
rectangle(x,y,x+width,y+height,0,0)
for i=1 to length(string) do
   if mouse_x>x and mouse_x<x+width and mouse_y>y+18*i-18 and mouse_y<y+18*i and mouse_button=mb_left then
     mouse_button=0
     return string[i]
   end if
   if mouse_x>x and mouse_x<x+width and mouse_y>y+18*i-18 and mouse_y<y+18*i then
     sel=i
   else
     sel=0
   end if
   if sel=i then
   rectangle(x,y+18*i-17,x+width,y+18*i,9,1)
   draw_text({x+6,y+18*i-17},string[i],BLACK,9,0,{0,0})
   else
   draw_text({x+6,y+18*i-17},string[i],BLACK,WHITE,0,{0,0})
   end if
end for
if mouse_button=mb_left then
  return ""
end if
end while
end function

global procedure show_msg(sequence msg,sequence info)
atom button1, width, x, y
width=100
width+=length(msg)*8
x=320-width/2
y=220
button1=create_ex({"button","ok",305,y+42})
while 1 do
key=get_key()
if key != -1 then
  if key=27 then
    abort(0)  
  end if
end if
  if on_click({"button",button1})=1 then
    delete({"button",button1})
    exit
  end if
mouse()
display_image({0,0},screen)
screen=screen2
textbox()
listview()
lable()
richedit()
combox()
menu()
rectangle(x,y,x+width,y+60,WHITE,1)
rectangle(x,y,x+width,y+60,0,0)
rectangle(x,y,x+width,y+20,WHITE,1)
rectangle(x,y,x+width,y+20,0,0)
draw_text({x+42,y+22},msg,BLACK,WHITE,0,{0,0})
draw_text({x+2,y+2},info,BLACK,WHITE,0,{0,0})
button()
end while
end procedure

global function show_q(sequence msg,sequence info)
atom button1, button2 ,width, x, y
width=100
width+=length(msg)*8
x=320-width/2
y=220
button1=create_ex({"button","No",275,y+42})
button2=create_ex({"button","Yes",320,y+42})
while 1 do
key=get_key()
if key != -1 then
  if key=27 then
      abort(0)
  end if
end if
  if on_click({"button",button1})=1 then
    delete({"button",button1})
    delete({"button",button2})
    return 0
  end if
  if on_click({"button",button2})=1 then
    delete({"button",button1})
    delete({"button",button2})
    return 1
  end if
mouse()
display_image({0,0},screen)
screen=screen2
textbox()
listview()
lable()
richedit()
combox()
menu()
rectangle(x,y,x+width,y+60,WHITE,1)
rectangle(x,y,x+width,y+60,0,0)
rectangle(x,y,x+width,y+20,WHITE,1)
rectangle(x,y,x+width,y+20,0,0)
draw_text({x+42,y+22},msg,BLACK,WHITE,0,{0,0})
draw_text({x+2,y+2},info,BLACK,WHITE,0,{0,0})
button()
end while
end function
