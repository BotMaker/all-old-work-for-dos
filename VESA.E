---------VESA Screen routines v0.4br                  1998 Nicholas Metcalfe
include graphics.e
include machine.e
include get.e
----------------------------------------------------------------------------
---------Screen and Graphics initialization
---------shared variables
integer vesa_mode                             --VESA mode number   
sequence pages                                --VGA memory page list
integer granularity                           --SVGA bank granularity
integer bpp                                   --Bytes per pixel
integer x_max, y_max                          --Dimensions of mode
constant vga = #A0000                         --VGA memory start address

--------set Euphoria graphics
procedure setmode(integer mode)               --set Euphoria graphics
  atom error                                  --  (called by refresh())
  error = graphics_mode(19)                   --corrects mouse somehow??
  if error then 
    puts(1,"VGA adapter not found\n")
    abort(1)
  end if
  if mode = 1 then
    vesa_mode = graphics_mode(261)
    vesa_mode = #105
  elsif mode = 2 then
    vesa_mode = graphics_mode(257)
    vesa_mode = #101
  else vesa_mode = 0
  end if
end procedure
---------initialize graphic screen
--input : mode (currently) = 1 ; 1024 x 768 x 256  (VESA)
--                         = 2 ; 640 x 480 x 256   (VESA)
--                         = 3 ; 320 x 200 x 256   (VGA)
global function refresh(integer mode)         --Initialize graphic screen
  integer bpl, data, ydim                     --  and set up VESA interface
  object vid, regs, avail
  if mode > 3 or mode < 1 then                --bad numbers
    vid = graphics_mode(-1)
    puts(1,"Unsupported mode!\n") abort(1)
  end if  
  use_vesa(1)
  setmode(mode)                               --init Euphoria graphics
  vid = video_config()
  x_max = vid[5] y_max = vid[6]
  pages = {}
  if vesa_mode then                           --init VESA interface
    data = allocate_low(512)
    regs=repeat(0,10)
    regs[REG_AX] = #4F01                      --Get VESA info on
    regs[REG_CX] = vesa_mode                  --  the listed mode
    regs[REG_ES] = floor(data / 16)           --  and put into 
    regs[REG_DI] = and_bits(data, 15)         --  variable 'data'
    regs = dos_interrupt(#10, regs)           
    avail = int_to_bits(peek(data)+peek(data+1)*256, 16)
    if avail[1] = 0 then
      vid = graphics_mode(-1)
      puts(1,"Unsupported mode!\n") abort(1)
    end if
    ydim = peek(data+20)+peek(data+21)*256    --Y dimensions
    bpl = peek(data+16)+peek(data+17)*256     --bytes per line
    bpp = bpl / x_max
    granularity = 64 / (peek(data+4)+peek(data+5)*256) --bank granularity
    free_low(data)
    regs=repeat(0,10)
    regs[REG_AX] = #4F02                      --Initialize controller
    regs[REG_BX] = vesa_mode                  --  by setting VESA to 
    regs = dos_interrupt(#10, regs)           --  the listed screen mode
    for x = 1 to floor((bpl * ydim)/65536) do --'pages' is a sequence
      pages = pages & {65536}                 --  of block sizes (windows)
    end for                                   --  for the listed mode
    pages = pages & {(((bpl*ydim)/65536)-floor((bpl*ydim)/65536))*65536}
  else
    bpp = 1                                   --1 byte per pixel
    pages = pages & {64000}                   --mode #13 has only one window
  end if
  return video_config()
end function
---------Checks for the prescence of VESA compatible BIOS
global function check_vesa()
  object data, regs, sig
  data = allocate_low(512)                  --allocate a structure 
  regs=repeat(0,10)
  regs[REG_AX] = #4F00                      --Get VESA general info
  regs[REG_ES] = floor(data / 16)           --  and put into 
  regs[REG_DI] = and_bits(data, 15)         --  'data' structure
  regs = dos_interrupt(#10, regs)           --call the interrupt
  sig = peek({data, 4})                     --VESA signature
  free_low(data)                            --free the structure
  if compare(sig, "VESA") = 0 then
    return 1 else return 0                  --there (1) or not (0)
  end if  
end function

-----------------------------------------------------------------------------
--------- Screen save/load fast routines using VESA
---------sets the active VGA page using VESA
global procedure set_page(integer page)       --VESA interrupt interface
  sequence regs
  regs=repeat(0,10)
  if vesa_mode then                           --dont do this to non-VESA!
    regs[REG_AX] = #4F05                      --VESA interrupt to set bank
    regs[REG_BX] = #0000                      --affect window 0
    regs[REG_DX] = page * granularity         --set page
    regs = dos_interrupt(#10, regs)           --call the interrupt
    regs[REG_AX] = #4F05                      --VESA interrupt to set bank
    regs[REG_BX] = #0001                      --affect window 1
    regs[REG_DX] = page * granularity         --set page
    regs = dos_interrupt(#10, regs)           --call the interrupt
  end if
end procedure
---------saves the whole graphic screen into memory using VESA
--warning : address must point to a memory buffer allocated at least
--          as much memory as the screen (i.e: x_max * y_max * bpp)
global procedure grab_screen(atom address) --grab the whole screen
  for x = 1 to length(pages) do               --count out the pages
    mem_copy(address+((x-1)*65536), vga, pages[x]) --grab those windows!
    set_page(x)                               --next page   
  end for    
  set_page(0)                                 --restore to start
end procedure
---------puts memory back on to the whole screen using VESA
global procedure splat_screen(atom address)--puts the screen back
  for x = 1 to length(pages) do               --count out the pages
    mem_copy(vga, address+((x-1)*65536), pages[x]) --splat each back
    set_page(x)                               --next page
  end for    
  set_page(0)                                 --restore to start
end procedure

