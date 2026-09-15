if (instance_exists(other)) {
	damage_player(global.enimy_roadbossDMG);
}
// 2. Destroy the bullet so it doesn't pass through
instance_destroy();
