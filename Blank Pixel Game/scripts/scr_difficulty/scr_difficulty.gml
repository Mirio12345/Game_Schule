/// @function apply_difficulty(_difficulty, _full_reset)
/// @description Setzt alle Balance-Globals für den gewählten Schwierigkeitsgrad.
///              Vorher stand dieser ~25-zeilige Block praktisch identisch in
///              SECHS verschiedenen Objekten (Button_Start, Button_Settings,
///              Button_easy, Button_normal, Button_Hard, Button_Dominic) -
///              jede Balance-Änderung musste an sechs Stellen gepflegt werden.
///
/// @param {Real} _difficulty    0 = Easy, 1 = Normal, 2 = Hard, 3 = Dominic
/// @param {Bool} _full_reset    true  = neues Spiel: HP/HealMultiplier komplett
///                                     zurücksetzen (wie beim ersten Spielstart)
///                              false = nur Balance-Werte ändern, aktuelle
///                                     HP nur auf das neue Maximum begrenzen
function apply_difficulty(_difficulty, _full_reset) {

	// Ein Preset pro Schwierigkeitsgrad statt Copy&Paste. Werte 1:1 aus dem
	// Originalcode übernommen, plus neue Werte für Sprint & Rüstung.
	static presets = [
		// 0 = Easy: viel Ausdauer, großzügige Rüstung
		{
			playerDMG: 25, max_player_hp: 100, playerSpeed: 2.25,
			playerShootCooldown: 30, playerReflectCooldown: 30,
			heal_divisor: 1, HealitemCount: 3, MaxHealitemCount: 3, HealCooldown: 300,
			enemyDMG: 10, enemyHP: 60, enemySpeed: 2.8, enemyCooldown: 60,
			enimy_roadbossDMG: 15, enimy_roadbossHP: 295, enimy_roadbossSpeed: 1, enimy_roadbossCooldown: 40,
			enemy_boss_lary_DMG: 5, enemy_boss_lary_HP: 30, enemy_boss_lary_Speed: 1.0, enemy_boss_lary_Cooldown: 80,
			sprintMultiplier: 1.8, staminaMax: 150, staminaDrain: 1.0, staminaRegen: 1.5,
			armorPerKit: 50, maxArmor: 100,
		},
		// 1 = Normal
		{
			playerDMG: 20, max_player_hp: 100, playerSpeed: 2.25,
			playerShootCooldown: 30, playerReflectCooldown: 30,
			heal_divisor: 2, HealitemCount: 2, MaxHealitemCount: 2, HealCooldown: 300,
			enemyDMG: 15, enemyHP: 70, enemySpeed: 2.8, enemyCooldown: 45,
			enimy_roadbossDMG: 18, enimy_roadbossHP: 360, enimy_roadbossSpeed: 1, enimy_roadbossCooldown: 20,
			enemy_boss_lary_DMG: 8, enemy_boss_lary_HP: 50, enemy_boss_lary_Speed: 1.8, enemy_boss_lary_Cooldown: 60,
			sprintMultiplier: 1.6, staminaMax: 100, staminaDrain: 1.2, staminaRegen: 1.0,
			armorPerKit: 40, maxArmor: 80,
		},
		// 2 = Hard: weniger Ausdauer, weniger Rüstung
		{
			playerDMG: 15, max_player_hp: 100, playerSpeed: 2.25,
			playerShootCooldown: 40, playerReflectCooldown: 40,
			heal_divisor: 2, HealitemCount: 2, MaxHealitemCount: 2, HealCooldown: 300,
			enemyDMG: 20, enemyHP: 100, enemySpeed: 2.8, enemyCooldown: 40,
			enimy_roadbossDMG: 25, enimy_roadbossHP: 430, enimy_roadbossSpeed: 1, enimy_roadbossCooldown: 10,
			enemy_boss_lary_DMG: 10, enemy_boss_lary_HP: 70, enemy_boss_lary_Speed: 1.8, enemy_boss_lary_Cooldown: 60,
			sprintMultiplier: 1.5, staminaMax: 80, staminaDrain: 1.5, staminaRegen: 0.8,
			armorPerKit: 30, maxArmor: 60,
		},
		// 3 = Dominic: kaum Ausdauer, kaum Rüstung - hart wie der Rest des Presets
		{
			playerDMG: 10, max_player_hp: 100, playerSpeed: 2.25,
			playerShootCooldown: 60, playerReflectCooldown: 60,
			heal_divisor: 2, HealitemCount: 1, MaxHealitemCount: 1, HealCooldown: 300,
			enemyDMG: 34, enemyHP: 150, enemySpeed: 2.8, enemyCooldown: 20,
			enimy_roadbossDMG: 100, enimy_roadbossHP: 600, enimy_roadbossSpeed: 5, enimy_roadbossCooldown: 5,
			enemy_boss_lary_DMG: 15, enemy_boss_lary_HP: 100, enemy_boss_lary_Speed: 1.8, enemy_boss_lary_Cooldown: 60,
			sprintMultiplier: 1.4, staminaMax: 60, staminaDrain: 2.0, staminaRegen: 0.5,
			armorPerKit: 20, maxArmor: 40,
		},
	];

	global.difficulity = _difficulty;
	var _p = presets[_difficulty];

	global.playerDMG             = _p.playerDMG;
	global.max_player_hp         = _p.max_player_hp;
	global.playerSpeed           = _p.playerSpeed;
	global.playerShootCooldown   = _p.playerShootCooldown;
	global.playerReflectCooldown = _p.playerReflectCooldown;
	global.HealValue             = _p.max_player_hp / _p.heal_divisor;
	global.HealitemCount         = _p.HealitemCount;
	global.MaxHealitemCount      = _p.MaxHealitemCount;
	global.HealCooldown          = game_get_speed(gamespeed_fps) * 5; // exakt 5 Sekunden

	global.enemyDMG      = _p.enemyDMG;
	global.enemyHP       = _p.enemyHP;
	global.enemySpeed    = _p.enemySpeed;
	global.enemyCooldown = _p.enemyCooldown;

	global.enimy_roadbossDMG      = _p.enimy_roadbossDMG;
	global.enimy_roadbossHP       = _p.enimy_roadbossHP;
	global.enimy_roadbossSpeed    = _p.enimy_roadbossSpeed;
	global.enimy_roadbossCooldown = _p.enimy_roadbossCooldown;

	global.enemy_boss_lary_DMG      = _p.enemy_boss_lary_DMG;
	global.enemy_boss_lary_HP       = _p.enemy_boss_lary_HP;
	global.enemy_boss_lary_Speed    = _p.enemy_boss_lary_Speed;
	global.enemy_boss_lary_Cooldown = _p.enemy_boss_lary_Cooldown;

	global.bulletSpeed = 10; // war in jedem Preset identisch 10 -> einmal statt sechsmal

	// --- Sprint ---
	global.sprintMultiplier = _p.sprintMultiplier;
	global.staminaMax       = _p.staminaMax;
	global.staminaDrain     = _p.staminaDrain;
	global.staminaRegen     = _p.staminaRegen;

	// --- Rüstung ---
	global.armorPerKit = _p.armorPerKit;
	global.max_player_armor = _p.maxArmor;
	if (!variable_global_exists("player_armor") || _full_reset) {
		global.player_armor = 0; // Rüstung muss man sich im Level erst holen
	} else {
		global.player_armor = min(global.player_armor, global.max_player_armor);
	}

	if (_full_reset) {
		global.HealMultiplier = 1;
		global.player_hp = _p.max_player_hp;
	} else if (variable_global_exists("player_hp")) {
		// HP nicht über das (evtl. neue) Maximum stehen lassen
		global.player_hp = min(global.player_hp, _p.max_player_hp);
	} else {
		global.player_hp = _p.max_player_hp;
	}
}
