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
spr_idle   = [spr_gegner1_idle_right,   spr_gegner1_idle_up,   spr_gegner1_idle_left,   spr_gegner1_idle_down];
spr_walk   = [spr_gegner1_walk_right,   spr_gegner1_walk_up,   spr_gegner1_walk_left,   spr_gegner1_walk_down];
spr_attack = [spr_gegner1_attack_right, spr_gegner1_attack_up, spr_gegner1_attack_left, spr_gegner1_attack_down];
spr_death  = spr_gegner1_death;

sprite_index = spr_idle[facing];
image_speed  = 0.15;
