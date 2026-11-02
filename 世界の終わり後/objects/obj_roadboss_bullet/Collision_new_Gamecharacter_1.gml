	if (instance_exists(other)) {
		global.player_hp -= scr_armor_mitigate(global.enimy_roadbossDMG); 
	}
// 2. Destroy the bullet so it doesn't pass through
instance_destroy();