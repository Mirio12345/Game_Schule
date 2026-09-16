if (keyboard_check(ord("F")) && chest_status == 0)
{
	if  distance_to_object(new_Gamecharacter_1) < 5
	{
		chest_status = 1;
		global.HealitemCount = global.MaxHealitemCount;
		global.player_hp = global.max_player_hp;
		// Mark this chest as opened in save state
		if (!variable_global_exists("chest_states")) { global.chest_states = {}; }
		global.chest_states[$ chest_id] = true;
		image_speed = 1;
		alarm[0] = 40;
	}
}