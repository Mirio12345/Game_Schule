/// obj_gegner1 - Step Event
if (hp <= 0 && state != "dead") {
    state = "dead";
    sprite_index = spr_death;
    image_index  = 0;
    image_speed  = 0.2;
}

if (state == "dead") {
    if (image_index >= image_number - 1) {
        image_speed = 0;
        image_index = image_number - 1;
        image_alpha -= 0.01;                   // langsam ausblenden
        if (image_alpha <= 0) instance_destroy();
    }
    exit;
}

if (attack_cooldown > 0) attack_cooldown--;
var _p = instance_nearest(x, y, obj_player);   // Spielerobjekt anpassen
if (_p == noone) exit;

var _dist = point_distance(x, y, _p.x, _p.y);
var _dir  = point_direction(x, y, _p.x, _p.y);

switch (state) {
    case "idle":
        sprite_index = spr_idle[facing]; image_speed = 0.15;
        if (_dist < aggro_range) state = "chase";
        break;

    case "chase":
        facing = (round(_dir / 90)) mod 4;     // 0=rechts 1=oben 2=links 3=unten
        sprite_index = spr_walk[facing]; image_speed = 0.3;
        if (_dist > attack_range) {
            x += lengthdir_x(move_speed, _dir);
            y += lengthdir_y(move_speed, _dir);
        } else if (attack_cooldown <= 0) {
            state = "attack"; hit_done = false;
            sprite_index = spr_attack[facing]; image_index = 0; image_speed = 0.25;
        }
        if (_dist > aggro_range * 1.5) state = "idle";
        break;

    case "attack":
        if (!hit_done && floor(image_index) >= hit_frame) {
            hit_done = true;
            if (point_distance(x, y, _p.x, _p.y) <= attack_range + 8) {
                // TODO: Schaden am Spieler ausloesen, z.B. _p.hp -= attack_damage;
            }
        }
        if (image_index >= image_number - 1) {
            state = "chase"; attack_cooldown = 90;
        }
        break;
}

// Radioaktive Aura
if (instance_exists(obj_player) && point_distance(x, y, obj_player.x, obj_player.y) < rad_radius) {
    // TODO: obj_player.hp -= rad_damage;  (oder Strahlungs-Debuff setzen)
}