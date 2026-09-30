// Reichweiten
sight_range = 500;     // Ab wann er dich sieht (und schießt)
hearing_range = 900;   // Ab wann er dich hört (und auf dich zugeht)

// Bewegung & Kampf
move_speed = global.enimy_roadbossSpeed;
base_shoot_cooldown = max(1, global.enimy_roadbossCooldown);
shoot_cooldown = base_shoot_cooldown;
can_shoot = true;

// A small health increase makes the three-phase fight last long enough to read.
boss_max_hp = max(1, round(global.enimy_roadbossHP * 1.1));
hp = boss_max_hp;
boss_phase = 1;
boss_shots_per_volley = 1;
boss_shot_spread = 0;
worker_spawn_timer = game_get_speed(gamespeed_fps) * 3.5;

// Aktueller Zustand
state = "idle";        // "idle", "chase", oder "shoot"

obj_player = new_Gamecharacter_1;
obj_wall = Wall_class;
obj_bullet = obj_roadboss_bullet;



walk_sprites = [roboter_nach_rechts_laufen, roboter_nach_norden_laufen, roboter_nach_links_laufen, roboter_nach_sueden_den_laufen];
// idle_sprites = [spr_enemy_idle_right, spr_enemy_idle_up, spr_enemy_idle_left, spr_enemy_idle_down];
face = 3;
