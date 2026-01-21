if (instance_exists(new_Gamecharacter_1)) {
    
    // Calculate distance to player
    var dist = point_distance(x, y, new_Gamecharacter_1.x, new_Gamecharacter_1.y);
    
    // Check Line of Sight
    // collision_line checks from enemy(x,y) to player(x,y). 
    // It returns 'noone' if the line is clear of obj_wall.
    var has_line_of_sight = collision_line(x, y, new_Gamecharacter_1.x, new_Gamecharacter_1.y, [Wall,Halfwall], false, false) == noone;

    // BEHAVIOR LOGIC
    // If the player is close enough to be seen AND there are no walls in the way
    if (dist <= sight_range && has_line_of_sight) {
        
        // Always look at the player if spotted
        image_angle = point_direction(x, y, new_Gamecharacter_1.x, new_Gamecharacter_1.y);
        
        // If we are too far away, move closer
        if (dist > attack_range) {
            // mp_potential_step tries to move towards target while avoiding solid objects
            mp_potential_step(new_Gamecharacter_1.x, new_Gamecharacter_1.y, move_speed, false);
        } 
        else {
            // We are within attack range, so STOP moving
            speed = 0;
            
            // SHOOTING LOGIC
            if (can_shoot) {

				var _bullet = instance_create_depth(x, y, depth - 1, obj_enemy_bullet);
                
                // Give the bullet speed and direction
                _bullet.speed = bullet_speed;
                _bullet.direction = image_angle; // Shoot where enemy is facing
                _bullet.image_angle = image_angle;
                
                // Reset cooldown
                can_shoot = false;
                alarm[0] = fire_rate;
            }
        }
    } 
    else {
        // OPTIONAL: If player is lost/out of sight, stop moving
        speed = 0;
    }
}