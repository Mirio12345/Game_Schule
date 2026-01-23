globalvar Pos_x;
globalvar Pos_y;

var _right = keyboard_check(ord("D"));
var _down = keyboard_check(ord("S"));
var _left = keyboard_check(ord("A"));
var _up = keyboard_check(ord("W"));

var xinput = _right - _left;
var yinput = _down	- _up;

move_and_collide(xinput * my_speed, yinput * my_speed, [Wall,Halfwall])

if keyboard_check_pressed(ord("A"))
{
 sprite_index = Flip_samurei;
 image_index = 0;
}
if keyboard_check_pressed(ord("D"))
{
 sprite_index = Samurei;
 image_index = 0;
}
if keyboard_check_pressed(vk_escape)
{
 global.Pos_x = x;
 global.Pos_y = y;
 room_goto(Startscreen);
}


/*if (place_meeting(x,y, go_to_room_lausgang))
{	
  global.Pos_x = 1300;
  global.Pos_y = 320; 
  room_goto(lausgang);
}

if (place_meeting(x, y, Object9_1))
{
 global.Pos_x = 20;
 global.Pos_y = 320;
 room_goto(TestRoom);
}*/
