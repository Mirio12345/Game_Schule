/// obj_gegner1 - Create Event   (Radioaktiver Spinnen-Roboter)
hp              = 60;
move_speed      = 0.7;
aggro_range     = 160;     // ab hier verfolgt er den Spieler
attack_range    = 28;     // ab hier greift er an
attack_damage   = 12;
attack_cooldown = 0;
hit_frame       = 3;      // Frame, in dem der Schaden verteilt wird
hit_done        = false;
state           = "idle";   // idle | chase | attack | dead
facing          = 3;        // 0 = rechts, 1 = oben, 2 = links, 3 = unten

// Strahlungs-Aura: Schaden ueber Zeit, wenn der Spieler nah genug ist
rad_radius = 56;
rad_damage = 0.05;   // pro Step

// Pro Animation nur EIN Sprite. Frame-Index = facing * Frames + Frame
frames_idle   = 6;
frames_walk   = 8;
frames_attack = 6;
anim_frame    = 0;

sprite_index = spr_gegner1_idle;
image_speed  = 0;           // Animation laeuft manuell im Step Event
