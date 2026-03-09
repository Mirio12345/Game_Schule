// Reichweiten
sight_range = 500;     // Ab wann er dich sieht (und schießt)
hearing_range = 900;   // Ab wann er dich hört (und auf dich zugeht)

// Bewegung & Kampf
move_speed = global.enimy_roadbossSpeed;
shoot_cooldown = global.enimy_roadbossCooldown;   // Wie lange er zwischen Schüssen wartet (60 Frames = ca. 1 Sekunde)
can_shoot = true;

hp  = global.enimy_roadbossHP;
// Aktueller Zustand
state = "idle";        // "idle", "chase", oder "shoot"

obj_player = new_Gamecharacter_1;
obj_wall = Wall_class;
obj_bullet = obj_enemy_bullet;


walk_sprites = [roboter_nach_rechts_laufen, roboter_nach_norden_laufen, roboter_nach_links_laufen, roboter_nach_s_den_laufen];
// idle_sprites = [spr_enemy_idle_right, spr_enemy_idle_up, spr_enemy_idle_left, spr_enemy_idle_down];
face = 3;