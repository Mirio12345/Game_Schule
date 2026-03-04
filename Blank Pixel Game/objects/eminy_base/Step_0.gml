if (!instance_exists(obj_player)) exit;

var dist = point_distance(x, y, obj_player.x, obj_player.y);
var has_los = !collision_line(x, y, obj_player.x, obj_player.y, obj_wall, false, true);

// Zustands-Steuerung
if (dist <= sight_range && has_los) state = "shoot";
else if (dist <= hearing_range) state = "chase";
else state = "idle";

switch (state) {
    case "idle":
        speed = 0;
        break;

    case "chase":
        mp_potential_step(obj_player.x, obj_player.y, move_speed, false);
        // WICHTIG: Hier muss ein break hin!
        break;

    case "shoot":
        speed = 0;
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