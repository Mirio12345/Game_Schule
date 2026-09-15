enemy_ai_step(obj_bullet, bullet_speed, shoot_move_speed);

// --- Roadboss-spezifisch: periodisch einen enemy_boss_lary spawnen ---
// (Vorher stand hier "if global.bossCount = 0" - durch die Subtraktion in
//  0.05er-Schritten landet der Float aber so gut wie nie exakt auf 0, d.h.
//  der Boss konnte im Zweifel nie/kaum spawnen. Mit "<= 0" ist der Vergleich
//  robust gegen Rundungsfehler.)
image_index = global.bossCount;

if (global.bossCount > 0) {
    global.bossCount -= 0.05;
    if (global.bossCount <= 0) {
        instance_create_depth(x + 30, y + 30, 0, enemy_boss_lary);
        global.bossCount = 10;
    }
}
