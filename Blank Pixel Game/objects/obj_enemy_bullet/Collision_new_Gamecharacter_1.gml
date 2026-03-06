
if (instance_exists(other)) {
    global.player_hp -= global.enemyDMG; 

}

// 2. Destroy the bullet so it doesn't pass through
instance_destroy();