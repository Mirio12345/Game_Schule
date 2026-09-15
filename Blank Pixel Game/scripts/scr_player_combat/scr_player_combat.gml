/// @function damage_player(_amount)
/// @description Fügt dem Spieler Schaden zu. global.player_armor wirkt wie ein
///              Schild: Rüstung wird zuerst abgezogen, erst danach sinkt die
///              eigentliche HP. Ersetzt die vorher 3x fast identisch
///              kopierten "global.player_hp -= ..."-Zeilen in den drei
///              Projektil-Objekten (obj_enemy_bullet, obj_roadboss_bullet,
///              obj_enemy_boss_bullet).
///
/// @param {Real} _amount    Roh-Schaden, bevor die Rüstung ihn abschwächt
function damage_player(_amount) {

	if (_amount <= 0) return;

	if (global.player_armor > 0) {
		var _absorbed = min(global.player_armor, _amount);
		global.player_armor -= _absorbed;
		_amount -= _absorbed;
	}

	if (_amount > 0) {
		global.player_hp -= _amount;
	}
}
