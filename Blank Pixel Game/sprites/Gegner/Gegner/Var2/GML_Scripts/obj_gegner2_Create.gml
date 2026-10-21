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

spr_idle   = [spr_gegner2_idle_right,   spr_gegner2_idle_up,   spr_gegner2_idle_left,   spr_gegner2_idle_down];
spr_walk   = [spr_gegner2_walk_right,   spr_gegner2_walk_up,   spr_gegner2_walk_left,   spr_gegner2_walk_down];
spr_attack = [spr_gegner2_attack_right, spr_gegner2_attack_up, spr_gegner2_attack_left, spr_gegner2_attack_down];
spr_death  = spr_gegner2_death;

sprite_index = spr_idle[facing];
image_speed  = 0.15;
