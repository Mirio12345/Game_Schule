/// obj_gegner2 - Create Event   (Neon-Mensch (Kicker))
hp              = 40;
move_speed      = 1.1;
aggro_range     = 180;     // ab hier verfolgt er den Spieler
attack_range    = 34;     // ab hier greift er an
attack_damage   = 8;
attack_cooldown = 0;
hit_frame       = 3;      // Frame, in dem der Schaden verteilt wird
hit_done        = false;
state           = "idle";   // idle | chase | attack | dead
facing          = 3;        // 0 = rechts, 1 = oben, 2 = links, 3 = unten

// Pro Animation nur EIN Sprite. Frame-Index = facing * Frames + Frame
frames_idle   = 6;
frames_walk   = 8;
frames_attack = 6;
anim_frame    = 0;

sprite_index = spr_gegner2_idle;
image_speed  = 0;           // Animation laeuft manuell im Step Event
