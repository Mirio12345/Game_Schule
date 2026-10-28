/// obj_npc_bazarmen - Step Event
var _p = instance_nearest(x, y, obj_player);   // dein Spieler-Objekt anpassen
var _near = (_p != noone) && (point_distance(x, y, _p.x, _p.y) < interact_range);

if (patrol && !shop_open && !_near) {
    state  = "walk";
    facing = (patrol_dir == 1) ? 0 : 2;
    x += move_speed * patrol_dir;
    if (x > patrol_x2) patrol_dir = -1;
    if (x < patrol_x1) patrol_dir =  1;
} else {
    state = "idle";
    // Zum Spieler drehen, wenn er in der Naehe ist
    if (_near) {
        var _a = point_direction(x, y, _p.x, _p.y);
        facing = ((round(_a / 90)) mod 4);   // 0=rechts 1=oben 2=links 3=unten
    }
}

// Sprite + Frame waehlen (ein Sprite je Animation, Richtung ueber image_index)
var _spr = spr_bazarmen_idle, _n = frames_idle, _spd = 0.15;
if (state == "walk") { _spr = spr_bazarmen_walk; _n = frames_walk; _spd = 0.35; }

if (sprite_index != _spr) { sprite_index = _spr; anim_frame = 0; }
anim_frame  = (anim_frame + _spd) mod _n;
image_speed = 0;
image_index = facing * _n + floor(anim_frame);

// Interaktion (Taste E) -> Shop oeffnen
if (_near && keyboard_check_pressed(ord("E"))) {
    shop_open = !shop_open;
    // TODO: hier dein Shop-/Dialogsystem starten
    // z.B. show_debug_message("Bazarmen: Was darf's sein, Chummer?");
}
