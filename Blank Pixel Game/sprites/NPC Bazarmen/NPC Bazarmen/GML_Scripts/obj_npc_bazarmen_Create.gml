/// obj_npc_bazarmen - Create Event
npc_name       = "Bazarmen";
role           = "Waffen- & Ausruestungshaendler";
facing         = 3;          // 0 = rechts, 1 = oben, 2 = links, 3 = unten
state          = "idle";     // "idle" oder "walk"
move_speed     = 0.6;
interact_range = 40;
shop_open      = false;

// Optional: Patrouille zwischen zwei Punkten (false = steht nur da)
patrol         = false;
patrol_x1      = x - 48;
patrol_x2      = x + 48;
patrol_dir     = 1;

// Sprite-Lookup  [Richtung] -> Sprite
spr_idle = [spr_bazarmen_idle_right, spr_bazarmen_idle_up, spr_bazarmen_idle_left, spr_bazarmen_idle_down];
spr_walk = [spr_bazarmen_walk_right, spr_bazarmen_walk_up, spr_bazarmen_walk_left, spr_bazarmen_walk_down];

sprite_index = spr_idle[facing];
image_speed  = 0.15;   // Idle ~ langsames Atmen / Neon-Pulsieren
