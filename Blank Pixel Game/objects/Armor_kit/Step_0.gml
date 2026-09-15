bob_timer += 0.1;

// Aufsammeln: läuft der Spieler nah genug ran, wird die Rüstung sofort
// aufgefüllt (bis zum Maximum) und das Kit verschwindet. Ist die Rüstung
// schon voll, bleibt das Kit liegen, damit man es später noch nutzen kann.
if (distance_to_object(new_Gamecharacter_1) < 20)
{
	if (global.player_armor < global.max_player_armor)
	{
		global.player_armor = min(global.player_armor + armor_amount, global.max_player_armor);
		instance_destroy();
	}
}
