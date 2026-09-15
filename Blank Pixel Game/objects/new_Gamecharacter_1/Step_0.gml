hp = global.player_hp;

// --- Cutscene: Gameplay wirklich kurz anhalten ---
if (banner_timer > 0)
{
    if (keyboard_check_pressed(vk_space)) banner_timer = 1;
    banner_timer -= 1;
    global.game_cutscene_active = true;

    // Während des Dialogs weder bewegen, schießen, heilen noch Perks aktivieren.
    if (banner_timer <= 0) global.game_cutscene_active = false;
    exit;
}
else
{
    global.game_cutscene_active = false;
}

// --- Cooldowns / Perk-Timer ---
if (armor_perk_cooldown > 0) armor_perk_cooldown -= 1;
if (pierce_perk_cooldown > 0) pierce_perk_cooldown -= 1;
if (pierce_perk_timer > 0) pierce_perk_timer -= 1;
if (sprint_cooldown > 0) sprint_cooldown -= 1;

// Z: Rüstung auf exakt 50% zurücksetzen, danach 5 s Cooldown.
if (keyboard_check_pressed(ord("Z")) && armor_perk_cooldown <= 0)
{
    global.player_armor = global.max_player_armor * 0.5;
    armor_perk_cooldown = perk_cooldown_max;
}

// N: 5 s lang sind alle neu abgefeuerten Kugeln Piercing + One-Shot.
if (keyboard_check_pressed(ord("N")) && pierce_perk_cooldown <= 0)
{
    pierce_perk_timer = perk_cooldown_max;
    pierce_perk_cooldown = perk_cooldown_max;
}

var _right = keyboard_check(ord("D"));
var _down  = keyboard_check(ord("S"));
var _left  = keyboard_check(ord("A"));
var _up    = keyboard_check(ord("W"));

var xinput = _right - _left;
var yinput = _down   - _up;
var _is_moving = (xinput != 0 || yinput != 0);

// --- Sprint ---
// Shift + Bewegung nutzt Ausdauer. Erst wenn die Leiste komplett leer ist,
// startet der gewünschte 10-Sekunden-Cooldown. Danach ist die Ausdauer wieder voll.
var _wants_to_sprint = keyboard_check(vk_shift) && _is_moving;
is_sprinting = (_wants_to_sprint && stamina > 0 && sprint_cooldown <= 0);

var _current_speed = my_speed;
if (is_sprinting)
{
    _current_speed *= global.sprintMultiplier;
    stamina = max(0, stamina - global.staminaDrain);
    if (stamina <= 0)
    {
        sprint_cooldown = sprint_cooldown_max;
        is_sprinting = false;
    }
}
else if (sprint_cooldown <= 0)
{
    stamina = min(global.staminaMax, stamina + global.staminaRegen);
}

if (sprint_cooldown == 1)
{
    stamina = global.staminaMax;
}

move_and_collide(xinput * _current_speed, yinput * _current_speed, collision_walls);

if (hp <= 0)
{
    room_persistent = false;
    room_goto(Death_screen);
}

// Sprite-Auswahl als else-if-Kette: bricht früher ab (weniger Vergleiche)
// und ist eindeutig in der Priorität. Ergebnis ist identisch zum alten
// Code aus vier unabhängigen ifs (dort "gewann" bei Diagonalbewegung immer
// die zuletzt geprüfte Achse, also Y vor X - das bildet diese Kette 1:1 ab).
if (yinput < 0)
{
	sprite_index = walk_sprites[1];
}
else if (yinput > 0)
{
	sprite_index = walk_sprites[3];
}
else if (xinput < 0)
{
	sprite_index = walk_sprites[2];
}
else if (xinput > 0)
{
	sprite_index = walk_sprites[0];
}
else
{
	sprite_index = Gamecharacter_standart;
}

//Keyboard checks
if (keyboard_check_pressed(vk_escape))
{
	global.Pos_x = x;
	global.Pos_y = y;
	global.curentroom = room;
	room_goto(Startscreen);
}

if (keyboard_check(ord("E")) && can_heal && (hp != global.max_player_hp))
{
	if (global.HealitemCount > 0)
	{
		global.HealitemCount -= 1;
		global.player_hp = min(global.player_hp + (global.HealValue * global.HealMultiplier), global.max_player_hp);
	}
	can_heal = false;
	alarm[1] = drink_cooldown;
}

if (mouse_check_button(mb_left) && can_shoot)
{
	// 1. Richtung zur Maus im Room berechnen
	var dir_to_mouse = point_direction(x, y, mouse_x, mouse_y);

	// 2. Kugel erstellen
	var bullet = instance_create_depth(x, y, -1, obj_player_bullet);

	// 3. Werte an die Kugel übertragen
	with (bullet) {
        direction = dir_to_mouse;
        image_angle = dir_to_mouse;
        speed = global.bulletSpeed;
        perk_piercing_oneshot = (other.pierce_perk_timer > 0);
    }

	// 4. Cooldown aktivieren
	can_shoot = false;
	alarm[0] = shoot_cooldown;
}

if (mouse_check_button(mb_right) && can_reflect)
{
	var _parry_radius = 100; // How close the bullet needs to be

	// Find all bullets within the radius
	with (obj_enemy_bullet) {
		if (point_distance(x, y, other.x, other.y) < _parry_radius) {
			instance_destroy(self);
		}
	}
	can_reflect = false;
	alarm[2] = reflect_cooldown;
}

//Checkpoint System (vorher 3x fast identischer if-Block, jetzt eine Schleife
//über die im Create-Event definierte checkpoints-Liste)
if (keyboard_check(ord("R")))
{
	for (var i = 0; i < array_length(checkpoints); i++)
	{
		var _cp = checkpoints[i];
		if (distance_to_object(_cp.inst) < 5)
		{
			global.Pos_x = x;
			global.Pos_y = y;
			global.latest_checkpoint = _cp.id;
			global.HealitemCount = global.MaxHealitemCount;
			global.player_hp = global.max_player_hp;
			room_persistent = false;
			room_restart();
			break;
		}
	}
}
