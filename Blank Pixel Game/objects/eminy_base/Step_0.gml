// Wenn der Spieler nicht existiert, brechen wir ab (verhindert Abstürze)
if (!instance_exists(obj_player)) exit;

// 1. Distanz und Sichtlinie berechnen
var dist = point_distance(x, y, obj_player.x, obj_player.y);

// collision_line zieht einen unsichtbaren Strich. Wenn obj_wall im Weg ist, ist has_los = false
var has_los = !collision_line(x, y, obj_player.x, obj_player.y, obj_wall, false, true);

// 2. Zustand (State) bestimmen
if (dist <= sight_range && has_los) {
    // Er sieht dich und du bist in Reichweite
    state = "shoot";
} else if (dist <= hearing_range) {
    // Er sieht dich nicht (z.B. hinter einer Ecke), aber hört dich
    state = "chase";
} else {
    // Du bist zu weit weg
    state = "idle";
}

// Richtung zum Spieler prüfen
if (obj_player.x < x) {
    // Links vom Gegner
    image_xscale = -abs(image_xscale); 
} else {
    // Rechts vom Gegner
    image_xscale = abs(image_xscale);
}
// 3. Aktionen basierend auf dem Zustand ausführen

switch (state) {
    case "idle":
        speed = 0;
        break;

    case "chase":
        mp_potential_step(obj_player.x, obj_player.y, move_speed, false);
        // WICHTIG: Hier muss ein break hin!
        break;

case "shoot":
    speed = 0;

if (can_shoot) {
    // Wir erstellen die Kugel exakt im Zentrum
    var bullet = instance_create_depth(x, y, -1, obj_enimy_bullet);
    
    with (bullet) {
        direction = point_direction(x, y, obj_player.x, obj_player.y);
        image_angle = direction;
        speed = 8;
    }
    
    can_shoot = false;
    alarm[0] = shoot_cooldown;
}
    break;
}
