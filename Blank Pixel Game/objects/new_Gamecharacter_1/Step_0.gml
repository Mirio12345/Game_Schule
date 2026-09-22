globalvar Pos_x;
globalvar Pos_y;
hp = global.player_hp;

// Update weapon damage multiplier for this frame
weapon_dmg_mult = global.weapon_dmg_mults[global.current_weapon];

// --- Death check (always runs, even during cutscenes) ---
if hp <= 0
{
	room_persistent = false;
	room_goto(Death_screen);
}

// --- Movement & Input: only when global.can_move is true ---
if (variable_global_exists("can_move") && global.can_move == false) {
	// During cutscenes: keep idle sprite, skip all input
	sprite_index = Gamecharacter_standart;
} else {

var _right = keyboard_check(ord("D"));
var _down = keyboard_check(ord("S"));
var _left = keyboard_check(ord("A"));
var _up = keyboard_check(ord("W"));


var xinput = _right - _left;
var yinput = _down	- _up;

// Apply speed boost from smoked green cigarette
var _eff_speed = my_speed;
if (global.speed_boost_timer > 0) {
	_eff_speed *= 1.2;
	global.speed_boost_timer--;
}

move_and_collide(xinput * _eff_speed, yinput * _eff_speed, [Wall,Halfwall,Wall_class])


if xinput < 0
{
	sprite_index = walk_sprites[2];
}
if xinput > 0
{
	sprite_index = walk_sprites[0];
}
if yinput < 0
{
	sprite_index = walk_sprites[1];
}
if yinput > 0
{
	sprite_index = walk_sprites[3];
}
if xinput == 0 && yinput == 0
{
	sprite_index = Gamecharacter_standart;
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

// Smoke cigarette: E when HP is full and you have cigarettes
if (keyboard_check_pressed(ord("E")) && hp >= global.max_player_hp && can_smoke) {
	// Find first cigarette in inventory (check green first for speed boost)
	var _smoked = -1;
	if (global.item_counts[1] > 0) { _smoked = 1; }
	else if (global.item_counts[0] > 0) { _smoked = 0; }
	
	if (_smoked >= 0) {
		global.item_counts[_smoked]--;
		can_smoke = false;
		alarm[3] = smoke_cooldown;
		
		// Green cigarette: 10 second speed boost
		if (_smoked == 1) {
			global.speed_boost_timer = 600; // 10 seconds at 60fps
		}
	}
}

// Tick down item cooldown
if (global.item_cooldown > 0) {
	global.item_cooldown--;
}



if (mouse_check_button(mb_left) && can_shoot)
{
	// 1. Richtung zur Maus im Room berechnen
    var dir_to_mouse = point_direction(x, y, mouse_x, mouse_y);
    
    // 2. Kugel erstellen
    var bullet = instance_create_depth(x, y, -1, obj_player_bullet);
    
    // 3. Werte an die Kugel übertragen
    with (bullet) {
        direction = dir_to_mouse;
        image_angle = dir_to_mouse;
        speed = global.bulletSpeed;
        weapon_dmg_mult = other.weapon_dmg_mult;
    }
    
    // 4. Cooldown aktivieren
    can_shoot = false;
    alarm[0] = shoot_cooldown * global.weapon_spd_mults[global.current_weapon];
}
if (mouse_check_button(mb_right) && can_reflect)
{
	var _parry_radius = 100; // How close the bullet needs to be
    
    // Find all bullets within the radius
    with (obj_enemy_bullet) {
        if (point_distance(x, y, other.x, other.y) < _parry_radius) {
            
            instance_destroy(self);
        }
    }
	can_reflect = false;
	alarm[2] = reflect_cooldown;
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
		global.curent_room = room;
		// Auto-save at checkpoint
		if (global.active_slot > 0) { scr_save_game(global.active_slot); }
		room_persistent = false;
		room_restart();
	}
	if  distance_to_object(Checkpoint_4_Battle1) <  5
	{
		global.Pos_x = x;
		global.Pos_y = y;
		if (global.latest_checkpoint != 4) {
		global.latest_checkpoint = 4;
		}
		global.HealitemCount = global.MaxHealitemCount;
		global.player_hp = global.max_player_hp;
		global.curent_room = room;
		// Auto-save at checkpoint
		if (global.active_slot > 0) { scr_save_game(global.active_slot); }
		room_persistent = false;
		room_restart();
	}
	if  distance_to_object(Checkpoint_5_Battle2) <  5
	{
		global.Pos_x = x;
		global.Pos_y = y;
		if (global.latest_checkpoint != 5) {
		global.latest_checkpoint = 5;
		}
		global.HealitemCount = global.MaxHealitemCount;
		global.player_hp = global.max_player_hp;
		global.curent_room = room;
		// Auto-save at checkpoint
		if (global.active_slot > 0) { scr_save_game(global.active_slot); }
		room_persistent = false;
		room_restart();
	}
}

} // end can_move check

