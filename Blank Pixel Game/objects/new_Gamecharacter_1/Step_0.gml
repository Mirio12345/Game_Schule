globalvar Pos_x;
globalvar Pos_y;

var _right = keyboard_check(ord("D"));
var _down = keyboard_check(ord("S"));
var _left = keyboard_check(ord("A"));
var _up = keyboard_check(ord("W"));

var xinput = _right - _left;
var yinput = _down	- _up;

move_and_collide(xinput * my_speed, yinput * my_speed, [Object5,Object6])

if keyboard_check_pressed(vk_escape)
{
 global.Pos_x = x;
 global.Pos_y = y;
 room_goto(Startscreen);
}
