globalvar Pos_x;
globalvar Pos_y;
hp = global.player_hp;
var _right = keyboard_check(ord("D"));
var _down = keyboard_check(ord("S"));
var _left = keyboard_check(ord("A"));
var _up = keyboard_check(ord("W"));


var xinput = _right - _left;
var yinput = _down	- _up;

move_and_collide(xinput * my_speed, yinput * my_speed, [Wall,Halfwall,Wall_class])

if hp <= 0
{
	room_persistent = false;
	room_goto(Death_screen);
}


//Keyboard checks
if keyboard_check_pressed(vk_escape)
{
 global.Pos_x = x;
 global.Pos_y = y;
 global.curentroom = room;
 room_goto(Startscreen);
}

if (keyboard_check(ord("E"))  && can_heal && (hp != global.max_player_hp))
{
	if global.HealitemCount > 0
	{
		global.HealitemCount = global.HealitemCount - 1
		if ((global.player_hp + (global.HealValue * global.HealMultiplier))  <= global.max_player_hp)
		{
			global.player_hp = global.player_hp + (global.HealValue * global.HealMultiplier);
		}
		else
		{
			global.player_hp = global.max_player_hp;
		}
	}
	can_heal = false;
	alarm[1] = drink_cooldown;
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

//Checkpoint System
if keyboard_check(ord("R"))
{
	if  distance_to_object(Checkpoint_3_Startbattleroom) < 5
	{
		global.Pos_x = x;
		global.Pos_y = y;
		if (global.latest_checkpoint != 3) {
		global.latest_checkpoint = 3;
		}
		global.HealitemCount = global.MaxHealitemCount;
		global.player_hp = global.max_player_hp;
		room_persistent = false;
		room_restart();
	}
	if  distance_to_object(Checkpoint_4_Fightroom) <  5
	{
		global.Pos_x = x;
		global.Pos_y = y;
		if (global.latest_checkpoint != 4) {
		global.latest_checkpoint = 4;
		}
		global.HealitemCount = global.MaxHealitemCount;
		global.player_hp = global.max_player_hp;
		room_persistent = false;
		room_restart();
	}
}

