include window.e
file_names={"EX","TXT","BMP","F","EXE","E","BAT","DOC"}

object bitmap
bitmap=read_bitmap("ex.bmp")
file_images=append(file_images,bitmap[2])
bitmap=read_bitmap("text.bmp")
file_images=append(file_images,bitmap[2])
bitmap=read_bitmap("bmp.bmp")
file_images=append(file_images,bitmap[2])
bitmap=read_bitmap("dir.bmp")
file_images=append(file_images,bitmap[2])
bitmap=read_bitmap("exe.bmp")
file_images=append(file_images,bitmap[2])
bitmap=read_bitmap("e.bmp")
file_images=append(file_images,bitmap[2])
bitmap=read_bitmap("bat.bmp")
file_images=append(file_images,bitmap[2])
bitmap=read_bitmap("text.bmp")
file_images=append(file_images,bitmap[2])
bitmap=read_bitmap("exe2.bmp")
image_1=bitmap[2]

atom test
sequence d,line1
procedure init(sequence path)
test=0
d={}
line1={}
  d = dir(path)
  for i=1 to length(d) do
  test= compare(d[i][2],"d") 
  if test!=0 then
  line1=append(line1,d[i][1])
  end if
  end for
  test=0
  d={}
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
   line1=gaz_sort(line1)
end procedure

init("c:\\")
atom toolbar1,window1,fileview1
atom toolbar2,window2,fileview2
object bitmap2
sequence image
image={}
bitmap=read_bitmap("back.bmp")
bitmap2=read_bitmap("back1.bmp")
image=append(image,{bitmap[2],bitmap2[2]})

window1=create_ex({"window",1,1,320,270,"window1"})
toolbar1=create_ex({"toolbar",image,window1})
fileview1=create_ex({"fileview",2,40,300,200,line1,"c:\\",window1})

window2=create_ex({"window",340,1,320,270,"window2"})
toolbar2=create_ex({"toolbar",image,window2})
fileview2=create_ex({"fileview",2,40,300,200,line1,"c:\\",window2})

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
run()
on_click_dir(get_fileview_command(fileview1,4),fileview1)
on_click_dir(get_fileview_command(fileview2,4),fileview2)
end while
