if (instance_exists(other)) {
	damage_player(global.enemy_boss_lary_DMG);
}
// 2. Destroy the bullet so it doesn't pass through
instance_destroy();
