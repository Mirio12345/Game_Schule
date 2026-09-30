scr_poison_enemy_step(id);
if (hp <= 0) {
	instance_destroy();
	exit;
}
if (!instance_exists(obj_player)) exit;

// Move through the three waves as the boss loses health.
var _hp_ratio = hp / boss_max_hp;
var _next_phase = 1;
if (_hp_ratio <= 1 / 3) _next_phase = 3;
else if (_hp_ratio <= 2 / 3) _next_phase = 2;

if (_next_phase != boss_phase) {
	boss_phase = _next_phase;

	if (boss_phase == 2) {
		shoot_cooldown = max(1, floor(base_shoot_cooldown * 0.67));
		boss_shots_per_volley = 2;
		boss_shot_spread = 8;
	} else if (boss_phase == 3) {
		// 75% faster than the first wave means 1.75 volleys per first-wave volley.
		shoot_cooldown = max(1, floor(base_shoot_cooldown / 1.75));
		boss_shots_per_volley = 2;
		boss_shot_spread = 12;
	}

	// Apply the new fire rate to an attack that is already cooling down.
	if (!can_shoot) alarm[0] = min(alarm[0], shoot_cooldown);
}

// The workers keep arriving, with a shorter delay in each later wave.
worker_spawn_timer -= 1;
if (worker_spawn_timer <= 0) {
	instance_create_depth(x + 30, y + 30, 0, enemy_boss_lary);
	if (boss_phase == 3) worker_spawn_timer = game_get_speed(gamespeed_fps) * 2.5;
	else if (boss_phase == 2) worker_spawn_timer = game_get_speed(gamespeed_fps) * 3;
	else worker_spawn_timer = game_get_speed(gamespeed_fps) * 3.5;
}

var dist = point_distance(x, y, obj_player.x, obj_player.y);
var has_los = !collision_line(x, y, obj_player.x, obj_player.y,[obj_wall,self], false, true);

// Zustands-Steuerung
if (dist <= sight_range && has_los) state = "shoot";
else if (dist <= hearing_range) state = "chase";
else state = "idle";

// Get the direction to the player in degrees (0-360)
var _dir = point_direction(x, y, obj_player.x, obj_player.y);

if (speed > 0 || state == "chase") {
    var _move_dir = direction; 
    
    // 2. Convert 0-360 into 0, 1, 2, or 3 (Right, Up, Left, Down)
    // We add 45 to "offset" the zones so 0 degrees (Right) is a 90-degree slice
    face = round(_move_dir / 90) % 4; 
}

switch (state) {
    case "idle":
        speed = 0;
        sprite_index = roboter_standart; // Set your idle sprite
        break;

    case "chase":
       mp_potential_step(obj_player.x, obj_player.y, move_speed, false);
        sprite_index = walk_sprites[face];
        image_speed = 1; // Full walking speed
        break;

    case "shoot":
        speed = 2;
        sprite_index = roboter_standart; // Set your attacking sprite
        var dir_to_player = point_direction(x, y, obj_player.x, obj_player.y); 
         if (can_shoot) {
            for (var _shot = 0; _shot < boss_shots_per_volley; _shot++) {
                var _shot_dir = dir_to_player;
                if (boss_shots_per_volley > 1) {
                    _shot_dir += (_shot == 0) ? -boss_shot_spread : boss_shot_spread;
                }

                var bullet = instance_create_depth(x, y, -1, obj_bullet);
                bullet.direction = _shot_dir;
                bullet.image_angle = _shot_dir;
                bullet.speed = 10;
            }

            can_shoot = false;

            alarm[0] = shoot_cooldown;
        }
        break;
}
