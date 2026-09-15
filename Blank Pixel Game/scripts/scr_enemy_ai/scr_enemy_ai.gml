/// @function enemy_ai_step(_bullet_obj, _bullet_speed, _shoot_move_speed)
/// @description Gemeinsame Roboter-KI (idle / chase / shoot) für enemy_lary,
///              enemy_boss_lary und enemy_roadboss. Vorher war dieser Code
///              1:1 dreifach in jedem Objekt kopiert - jede Änderung musste
///              man an drei Stellen machen. Jetzt gibt es ihn nur einmal.
///
/// @param {Asset.GMObject} _bullet_obj      Projektil-Objekt, das geschossen wird
/// @param {Real} _bullet_speed              Geschwindigkeit des Projektils
/// @param {Real} _shoot_move_speed          Bewegungsgeschwindigkeit während "shoot"
///
/// Erwartet folgende Instanzvariablen (werden im Create-Event gesetzt):
/// obj_player, obj_wall, sight_range, hearing_range, move_speed,
/// shoot_cooldown, can_shoot, hp, state, walk_sprites, face, roboter_standart
function enemy_ai_step(_bullet_obj, _bullet_speed, _shoot_move_speed) {

    if (variable_global_exists("game_cutscene_active") && global.game_cutscene_active) {
        speed = 0;
        return;
    }

    if (!instance_exists(obj_player)) return;

    if (hp <= 0) {
        instance_destroy(self);
        return;
    }

    var _dist    = point_distance(x, y, obj_player.x, obj_player.y);
    var _has_los = !collision_line(x, y, obj_player.x, obj_player.y, [obj_wall, self], false, true);

    // Zustands-Steuerung
    if (_dist <= sight_range && _has_los) state = "shoot";
    else if (_dist <= hearing_range) state = "chase";
    else state = "idle";

    // Blickrichtung (0=rechts, 1=oben, 2=links, 3=unten) nur aktualisieren,
    // während sich der Gegner tatsächlich bewegt.
    // (Der alte Code berechnete zusätzlich eine "_face"-Variable aus der
    //  Richtung zum Spieler, die aber nirgendwo benutzt wurde - toter Code,
    //  hier entfernt.)
    if (speed > 0 || state == "chase") {
        face = round(direction / 90) % 4;
    }

    switch (state) {
        case "idle":
            speed = 0;
            sprite_index = roboter_standart;
            break;

        case "chase":
            mp_potential_step(obj_player.x, obj_player.y, move_speed, false);
            sprite_index = walk_sprites[face];
            image_speed = 1;
            break;

        case "shoot":
            speed = _shoot_move_speed;
            sprite_index = roboter_standart;

            if (can_shoot) {
                var _dir_to_player = point_direction(x, y, obj_player.x, obj_player.y);
                var _bullet = instance_create_depth(x, y, -1, _bullet_obj);
                _bullet.direction   = _dir_to_player;
                _bullet.image_angle = _dir_to_player;
                _bullet.speed       = _bullet_speed;

                can_shoot = false;
                alarm[0]  = shoot_cooldown;
            }
            break;
    }
}
