// Reichweiten
sight_range = 300;     // Ab wann er dich sieht (und schießt)
hearing_range = 450;   // Ab wann er dich hört (und auf dich zugeht)

// Bewegung & Kampf
move_speed = 2;
shoot_cooldown = 60;   // Wie lange er zwischen Schüssen wartet (60 Frames = ca. 1 Sekunde)
can_shoot = true;

// Aktueller Zustand
state = "idle";        // "idle", "chase", oder "shoot"

obj_player = new_Gamecharacter_1;
obj_wall = Wall;