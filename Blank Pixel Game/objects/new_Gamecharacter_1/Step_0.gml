globalvar Pos_x;
globalvar Pos_y;
hp = global.player_hp;
var _right = keyboard_check(ord("D"));
var _down = keyboard_check(ord("S"));
var _left = keyboard_check(ord("A"));
var _up = keyboard_check(ord("W"));

var xinput = _right - _left;
var yinput = _down	- _up;

move_and_collide(xinput * my_speed, yinput * my_speed, [Wall,Halfwall])

if hp <= 0
{
	room_persistent = false;
	room_goto(Death_screen);
}

if keyboard_check_pressed(vk_escape)
{
 global.Pos_x = x;
 global.Pos_y = y;
 global.curentroom = room;
 room_goto(Startscreen);
}
if (mouse_check_button_pressed(mb_left) && can_shoot) 
{
    // 1. Richtung zur Maus im Room berechnen
    var dir_to_mouse = point_direction(x, y, mouse_x, mouse_y);
    
    // 2. Kugel erstellen
    var bullet = instance_create_depth(x, y, -1, obj_player_bullet);
    
    // 3. Werte an die Kugel übertragen
    with (bullet) {
        direction = dir_to_mouse;
        image_angle = dir_to_mouse;
        speed = 8;
    }
    
    // 4. Cooldown aktivieren
    can_shoot = false;
    alarm[0] = shoot_cooldown;
}