event_inherited();

// Falls das Settings-Menü aufgerufen wird, bevor je ein Spiel gestartet
// wurde, trotzdem sinnvolle Default-Werte (Normal) bereitstellen.
// (Hinweis: der alte Code hatte hier abweichend enimy_roadbossHP = 300 statt
// 360 wie überall sonst bei "Normal" - das war ein Tippfehler und wurde
// vereinheitlicht.)
if (!variable_global_exists("difficulity")) {
	apply_difficulty(1, true);
}

room_goto(Settingsscreen);
