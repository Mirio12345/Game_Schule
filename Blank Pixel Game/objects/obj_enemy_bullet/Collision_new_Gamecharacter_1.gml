if (instance_exists(other)) {
	damage_player(global.enemyDMG);
}
// 2. Destroy the bullet so it doesn't pass through
instance_destroy();
