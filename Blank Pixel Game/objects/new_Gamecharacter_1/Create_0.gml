my_speed = 2.5;
shoot_cooldown = global.playerShootCooldown;   // Wie lange er zwischen Schüssen wartet (60 Frames = ca. 1 Sekunde)
reflect_cooldown = global.playerReflectCooldown;
drink_cooldown = global.HealCooldown;
can_shoot = true;
can_heal = true;
can_reflect = true;

walk_sprites = [Gamecharacter_nach_rechts_laufen,Gamecharacter_nach_norden_laufen,Gamecharacter_nach_links_laufen,Gamecharacter_nach_sueden_laufen];
face = 3;

// Kollisionsobjekte für move_and_collide() einmalig cachen statt das
// Array jeden Step neu zu erzeugen (siehe Step-Event).
collision_walls = [Wall, Halfwall, Wall_class];

// Checkpoints für die Respawn-Logik im Step-Event (statt 3x fast
// identischem if-Block einmal als Liste).
checkpoints = [
	{ inst: Checkpoint_3_Startbattleroom, id: 3 },
	{ inst: Checkpoint_4_Battle1,         id: 4 },
	{ inst: Checkpoint_5_Battle2,         id: 5 },
];

// Falls jemand direkt einen Raum testet, ohne vorher über einen
// Schwierigkeits-Button gelaufen zu sein, gäbe es sonst global.staminaMax /
// global.max_player_armor noch gar nicht -> deshalb hier ein Normal-Preset
// als Fallback.
if (!variable_global_exists("staminaMax")) {
	apply_difficulty(1, true);
}

// --- Sprint ---
is_sprinting = false;
stamina = global.staminaMax;
sprint_cooldown = 0;
sprint_cooldown_max = game_get_speed(gamespeed_fps) * 10; // 10 Sekunden nach kompletter Erschöpfung

// --- Perks (je 5 Sekunden Reset/Cooldown) ---
perk_cooldown_max = game_get_speed(gamespeed_fps) * 5;
armor_perk_cooldown = 0;
pierce_perk_cooldown = 0;
pierce_perk_timer = 0;

// Wichtig: hier auf "Pos_x" prüfen, nicht auf "player_hp" - Button_Start
// setzt global.player_hp bereits über apply_difficulty(), aber NICHT
// global.Pos_x/Pos_y/latest_checkpoint. Würde man nur player_hp prüfen,
// würde dieser Block fälschlich übersprungen und global.Pos_x wäre beim
// direkten Auslesen weiter unten noch gar nicht gesetzt -> Crash.
if (!variable_global_exists("Pos_x")) {
	global.player_hp = global.max_player_hp;
	global.Pos_x = 353;
	global.Pos_y = 255;
	global.latest_checkpoint = 3;
}
hp    = global.player_hp;
Pos_x = global.Pos_x;
Pos_y = global.Pos_y;

x = Pos_x;
y = Pos_y;

// --- Echte Raum-Cutscene / Dialog ---
// Für einige Sekunden werden Spielersteuerung und Gegner-KI angehalten.
// SPACE überspringt die Sequenz.
banner_text = "";
banner_subtext = "";
banner_fade_in  = 20;
banner_fade_out = 20;
banner_timer = 0;
banner_total = game_get_speed(gamespeed_fps) * 3; // ca. 3 Sekunden Dialog

switch (room) {
	case Battle1:
		banner_text = "RAUM 1";
		banner_subtext = "Besiege alle Gegner und erreiche den nächsten Raum.";
		break;
	case Battle2:
		banner_text = "RAUM 2";
		banner_subtext = "Bleib in Bewegung. Der Weg zum Boss ist nah.";
		break;
	case bossfight:
		banner_text = "BOSSFIGHT";
		banner_subtext = "Besiege den Boss. Nutze Armor, Heal und deine Perks.";
		break;
}

global.game_cutscene_active = (banner_text != "");
if (global.game_cutscene_active) {
	banner_timer = banner_total;
}
