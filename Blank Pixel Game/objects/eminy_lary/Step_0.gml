if (!instance_exists(obj_player)) exit;

if ( hp <= 0) {
	instance_destroy(self)	
}
var dist = point_distance(x, y, obj_player.x, obj_player.y);
var has_los = !collision_line(x, y, obj_player.x, obj_player.y, obj_wall, false, true);

// Zustands-Steuerung
if (dist <= sight_range && has_los) state = "shoot";
else if (dist <= hearing_range) state = "chase";
else state = "idle";

switch (state) {
    case "idle":
        speed = 0;
        sprite_index = roboter_standart; // Set your idle sprite
        break;

    case "chase":
        mp_potential_step(obj_player.x, obj_player.y, move_speed, false);
        // Flip the sprite based on player position
		sprite_index = roboter_nach_rechts_laufen;
		if (obj_player.x < x) {
			image_xscale = -1.3; // Face Left
		} else {
			image_xscale = 1.3;  // Face Right
		}
        // Match animation speed to movement (optional)
        image_speed = 0.7; 
        break;

    case "shoot":
        speed = 0;
        sprite_index = roboter_standart; // Set your attacking sprite
        
        var dir_to_player = point_direction(x, y, obj_player.x, obj_player.y);
        
         if (can_shoot) {

            var bullet = instance_create_depth(x, y, -1, obj_bullet);

            bullet.direction = dir_to_player;

            bullet.image_angle = dir_to_player;

            bullet.speed = 8;

            

            can_shoot = false;

            alarm[0] = shoot_cooldown;

        }

        break;
}