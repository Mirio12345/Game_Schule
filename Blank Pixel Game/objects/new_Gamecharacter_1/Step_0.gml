globalvar Pos_x;
globalvar Pos_y;
hp = global.player_hp;

// --- Death check (always runs, even during cutscenes) ---
if hp <= 0
{
	room_persistent = false;
	room_goto(Death_screen);
}

// Finish a reload after 1.3 seconds, even while a room-entry cutscene is active.
if (weapon_reload_time > 0) {
	if (global.current_weapon != weapon_reload_slot) {
		weapon_reload_time = 0;
		weapon_reload_slot = -1;
	} else {
		weapon_reload_time = max(0, weapon_reload_time - delta_time / 1000000);
		if (weapon_reload_time <= 0) {
			var _needed = global.weapon_magazine_sizes[weapon_reload_slot] - global.weapon_ammo[weapon_reload_slot];
			var _loaded = min(_needed, global.weapon_reserve_ammo[weapon_reload_slot]);
			global.weapon_ammo[weapon_reload_slot] += _loaded;
			global.weapon_reserve_ammo[weapon_reload_slot] -= _loaded;
			weapon_reload_slot = -1;
		}
	}
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
if (variable_global_exists("armor_speed_bonus") && global.armor_speed_bonus > 0) {
	_eff_speed *= 1 + global.armor_speed_bonus;
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



if (mouse_check_button(mb_left) && can_shoot && weapon_reload_time <= 0)
{
	var _weapon_slot = clamp(global.current_weapon, 0, array_length(global.weapon_names) - 1);
	if (global.weapon_ammo[_weapon_slot] <= 0) {
		// Automatically reload when the magazine runs dry.
		if (global.weapon_reserve_ammo[_weapon_slot] > 0) {
			weapon_reload_slot = _weapon_slot;
			weapon_reload_time = weapon_reload_duration;
		}
	} else {
		var dir_to_mouse = point_direction(x, y, mouse_x, mouse_y);
		var _bullet_x = x;
		var _bullet_y = y;
		var _weapon_skin = clamp(_weapon_slot, 0, array_length(global.weapon_sprites) - 1);
		var _aiming_left = (dir_to_mouse > 90 && dir_to_mouse < 270);
		var _hand_offset_x = _aiming_left ? -global.weapon_hand_offset_x : global.weapon_hand_offset_x;
		var _muzzle_local_x = global.weapon_muzzle_offsets_x[_weapon_skin];
		if (_aiming_left) _muzzle_local_x = -_muzzle_local_x;
		var _muzzle_local_y = global.weapon_muzzle_offsets_y[_weapon_skin];
		var _muzzle_local_direction = point_direction(0, 0, _muzzle_local_x, _muzzle_local_y);
		var _muzzle_distance = point_distance(0, 0, _muzzle_local_x, _muzzle_local_y) * global.weapon_sprite_scales[_weapon_skin] * global.zoom_level_character;
		var _weapon_angle = _aiming_left ? dir_to_mouse + 180 : dir_to_mouse;
		var _muzzle_direction = _weapon_angle + _muzzle_local_direction;
		_bullet_x = x + _hand_offset_x + lengthdir_x(_muzzle_distance, _muzzle_direction);
		_bullet_y = y + global.weapon_hand_offset_y + lengthdir_y(_muzzle_distance, _muzzle_direction);
		var bullet = instance_create_depth(_bullet_x, _bullet_y, -1, obj_player_bullet);
		var _upgrade_stats = scr_weapon_upgrade_stats(global.weapon_upgrade_levels[_weapon_slot]);
		bullet.weapon_upgrade_damage_mult = _upgrade_stats.damage_mult;
		bullet.weapon_headshot_chance = _upgrade_stats.headshot_chance;
		bullet.weapon_poison_chance = _upgrade_stats.poison_chance;
		with (bullet) {
			direction = dir_to_mouse;
			image_angle = dir_to_mouse;
			speed = global.bulletSpeed;
			weapon_dmg_mult = other.weapon_dmg_mult;
		}
		global.weapon_ammo[_weapon_slot]--;
		if (global.weapon_ammo[_weapon_slot] <= 0 && global.weapon_reserve_ammo[_weapon_slot] > 0) {
			weapon_reload_slot = _weapon_slot;
			weapon_reload_time = weapon_reload_duration;
		}
		can_shoot = false;
		alarm[0] = shoot_cooldown * global.weapon_spd_mults[_weapon_slot];
	}
}

// R is contextual: at a checkpoint it activates the checkpoint; elsewhere it reloads.
var _r_pressed = keyboard_check_pressed(ord("R"));
var _at_checkpoint = scr_player_near_checkpoint(id);

// A reload is cancelled if another weapon is equipped.
if (_r_pressed && !_at_checkpoint) {
	var _reload_slot = clamp(global.current_weapon, 0, array_length(global.weapon_names) - 1);
	if (weapon_reload_time <= 0
	&& global.weapon_ammo[_reload_slot] < global.weapon_magazine_sizes[_reload_slot]
	&& global.weapon_reserve_ammo[_reload_slot] > 0) {
		weapon_reload_slot = _reload_slot;
		weapon_reload_time = weapon_reload_duration;
	}
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
if (_r_pressed && _at_checkpoint)
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
