include mouse.e

global constant mb_left=1
global constant mb_left_up=3
global constant mb_right=2
global constant mb_right_up=4
global integer mouse_button
global integer mouse_x
global integer mouse_y
atom press
mouse_button=0
press=0
mouse_x=0
mouse_y=0

mouse_events(LEFT_DOWN + LEFT_UP + RIGHT_DOWN + RIGHT_UP + MOVE)

global procedure mouse()
object event
event = get_mouse()
if sequence(event) then
if and_bits(event[1], MOVE) then
  mouse_pointer(0)
  mouse_pointer(1)
  mouse_x=event[2]
  mouse_y=event[3]
end if
if and_bits(event[1], LEFT_DOWN) then
  mouse_button=mb_left
end if
if and_bits(event[1], LEFT_UP) then
  mouse_button=3
end if
if and_bits(event[1], RIGHT_DOWN) then
  mouse_button=mb_right
end if
if and_bits(event[1], RIGHT_UP) then
  mouse_button=mb_right_up
end if
else
mouse_button=0
end if
end procedure
