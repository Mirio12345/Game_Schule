	if (instance_exists(other)) {
		var _dmg = global.enemy_boss_lary_DMG;
		_dmg = _dmg * (1 - global.armor_level / 100);
		global.player_hp -= _dmg; 
	}
// 2. Destroy the bullet so it doesn't pass through
instance_destroy();