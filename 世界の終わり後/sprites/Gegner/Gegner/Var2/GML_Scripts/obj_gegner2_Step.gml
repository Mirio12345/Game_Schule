/// obj_gegner2 - Step Event
if (hp <= 0 && state != "dead") {
    state = "dead";
    sprite_index = spr_gegner2_death;   // Death hat keine Richtungen -> normale Animation
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
image_speed = 0;

switch (state) {
    case "idle":
        if (sprite_index != spr_gegner2_idle) { sprite_index = spr_gegner2_idle; anim_frame = 0; }
        anim_frame  = (anim_frame + 0.15) mod frames_idle;
        image_index = facing * frames_idle + floor(anim_frame);
        if (_dist < aggro_range) state = "chase";
        break;

    case "chase":
        facing = (round(_dir / 90)) mod 4;     // 0=rechts 1=oben 2=links 3=unten
        if (sprite_index != spr_gegner2_walk) { sprite_index = spr_gegner2_walk; anim_frame = 0; }
        anim_frame  = (anim_frame + 0.3) mod frames_walk;
        image_index = facing * frames_walk + floor(anim_frame);
        if (_dist > attack_range) {
            x += lengthdir_x(move_speed, _dir);
            y += lengthdir_y(move_speed, _dir);
        } else if (attack_cooldown <= 0) {
            state = "attack"; hit_done = false;
            sprite_index = spr_gegner2_attack; anim_frame = 0;
        }
        if (_dist > aggro_range * 1.5) state = "idle";
        break;

    case "attack":
        anim_frame += 0.25;
        image_index = facing * frames_attack + min(floor(anim_frame), frames_attack - 1);
        if (!hit_done && floor(anim_frame) >= hit_frame) {
            hit_done = true;
            if (point_distance(x, y, _p.x, _p.y) <= attack_range + 8) {
                // TODO: Schaden am Spieler ausloesen, z.B. _p.hp -= attack_damage;
            }
        }
        if (anim_frame >= frames_attack) {
            state = "chase"; attack_cooldown = 60;
            anim_frame = 0;
        }
        break;
}
