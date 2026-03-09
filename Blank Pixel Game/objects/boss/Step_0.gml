if (!instance_exists(obj_player)) exit;

if ( hp <= 0) {
	instance_destroy(self)	
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

// Divide 360 degrees by 90 to get 4 directions
// Adding 45 ensures the "Right" slice sits centered at 0 degrees
var _face = round(_dir / 90) % 4;

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
            var bullet = instance_create_depth(x, y, -1, obj_bullet);
            bullet.direction = dir_to_player;
            bullet.image_angle = dir_to_player;
            bullet.speed = 10;

            can_shoot = false;

            alarm[0] = shoot_cooldown;
        }
        break;
}