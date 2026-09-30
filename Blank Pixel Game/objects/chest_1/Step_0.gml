if (keyboard_check(ord("F")) && chest_status == 0)
{
	if  distance_to_object(new_Gamecharacter_1) < 5
	{
		chest_status = 1;
		global.HealitemCount = global.MaxHealitemCount;
		global.player_hp = global.max_player_hp;

		// Give a small amount of ammo to the equipped weapon, loading the magazine first.
		var _weapon_index = clamp(global.current_weapon, 0, array_length(global.weapon_names) - 1);
		var _ammo_reward = irandom_range(4, 8);
		var _magazine_space = max(0, global.weapon_magazine_sizes[_weapon_index] - global.weapon_ammo[_weapon_index]);
		var _loaded_ammo = min(_ammo_reward, _magazine_space);
		global.weapon_ammo[_weapon_index] += _loaded_ammo;
		global.weapon_reserve_ammo[_weapon_index] += _ammo_reward - _loaded_ammo;
		global.chest_ammo_reward_amount = _ammo_reward;
		global.chest_ammo_reward_timer = 120;

		// Mark this chest as opened in save state
		if (!variable_global_exists("chest_states")) { global.chest_states = {}; }
		global.chest_states[$ chest_id] = true;
		image_speed = 1;
		alarm[0] = 40;
		if (global.active_slot > 0) scr_save_game(global.active_slot);
	}
}
