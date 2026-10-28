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

// Pro Animation nur EIN Sprite. Frame-Index = facing * Frames + Frame
frames_idle = 6;
frames_walk = 8;
anim_frame  = 0;

sprite_index = spr_bazarmen_idle;
image_speed  = 0;            // Animation laeuft manuell im Step Event
