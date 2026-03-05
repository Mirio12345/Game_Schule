// Reichweiten
sight_range = 300;     // Ab wann er dich sieht (und schießt)
hearing_range = 450;   // Ab wann er dich hört (und auf dich zugeht)

// Bewegung & Kampf
move_speed = 2;
shoot_cooldown = 60;   // Wie lange er zwischen Schüssen wartet (60 Frames = ca. 1 Sekunde)
can_shoot = true;

hp  = 70;
// Aktueller Zustand
state = "idle";        // "idle", "chase", oder "shoot"

obj_player = new_Gamecharacter_1;
obj_wall = Wall_class;
obj_bullet = obj_enimy_bullet;


walk_sprites = [roboter_nach_rechts_laufen, roboter_nach_norden_laufen, roboter_nach_links_laufen, roboter_nach_s_den_laufen];
// idle_sprites = [spr_enemy_idle_right, spr_enemy_idle_up, spr_enemy_idle_left, spr_enemy_idle_down];
face = 3;