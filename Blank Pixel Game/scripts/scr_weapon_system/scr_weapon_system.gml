/// Weapon definitions and runtime inventory.
function weapon_definition(_id) {
    switch (_id) {
        case "pistol": return {
            id:"pistol", name:"Pistol", type:"gun", damage:24, damage_type:"bullet",
            fire_rate:0.22, range:700, magazine:12, reserve:72, reload:1.2,
            spread:1.5, pellets:1, knockback:2.5, crit_chance:0.12, crit_mult:2.0,
            bullet_speed:13, lifetime:55, melee_range:0, color:c_white
        };
        case "shotgun": return {
            id:"shotgun", name:"Shotgun", type:"gun", damage:16, damage_type:"bullet",
            fire_rate:0.9, range:430, magazine:6, reserve:36, reload:1.65,
            spread:9, pellets:7, knockback:8, crit_chance:0.08, crit_mult:1.8,
            bullet_speed:11, lifetime:38, color:c_yellow
        };
        case "smg": return {
            id:"smg", name:"Machine Gun", type:"gun", damage:12, damage_type:"bullet",
            fire_rate:0.095, range:600, magazine:30, reserve:150, reload:1.5,
            spread:4, pellets:1, knockback:1.5, crit_chance:0.06, crit_mult:2.1,
            bullet_speed:14, lifetime:48, color:c_lime
        };
        case "blade": return {
            id:"blade", name:"Combat Blade", type:"melee", damage:42, damage_type:"melee",
            fire_rate:0.5, range:95, magazine:0, reserve:0, reload:0,
            spread:0, pellets:1, knockback:12, crit_chance:0.18, crit_mult:2.2,
            bullet_speed:0, lifetime:0, melee_range:95, color:c_aqua
        };
    }
    return weapon_definition("pistol");
}

function weapon_system_init() {
    if (variable_global_exists("weapon_inventory_initialized")) return;
    global.weapon_inventory_initialized = true;
    global.weapon_inventory = [
        {id:"pistol", ammo:12, reserve:72},
        {id:"shotgun", ammo:0, reserve:0},
        {id:"smg", ammo:0, reserve:0},
        {id:"blade", ammo:0, reserve:0}
    ];
    global.current_weapon_slot = 0;
    global.weapon_reloading = false;
    global.weapon_reload_timer = 0;
    global.weapon_fire_timer = 0;
}

function weapon_slot_find(_id) {
    weapon_system_init();
    for (var i=0; i<array_length(global.weapon_inventory); i++) {
        if (global.weapon_inventory[i].id == _id) return i;
    }
    return -1;
}

function weapon_add(_id, _ammo=0, _reserve=0) {
    weapon_system_init();
    var idx = weapon_slot_find(_id);
    var def = weapon_definition(_id);
    if (idx < 0) {
        for (var i=0; i<array_length(global.weapon_inventory); i++) {
            if (global.weapon_inventory[i].id == "") { idx=i; break; }
        }
    }
    if (idx >= 0) {
        global.weapon_inventory[idx] = {id:_id, ammo:max(0,_ammo), reserve:max(0,_reserve)};
        global.current_weapon_slot = idx;
        return true;
    }
    return false;
}

function weapon_current() {
    weapon_system_init();
    var item = global.weapon_inventory[global.current_weapon_slot];
    return weapon_definition(item.id);
}

function weapon_switch(_slot) {
    weapon_system_init();
    if (_slot < 0 || _slot >= array_length(global.weapon_inventory)) return false;
    if (global.weapon_inventory[_slot].id == "") return false;
    global.current_weapon_slot = _slot;
    global.weapon_reloading = false;
    global.weapon_reload_timer = 0;
    return true;
}

function weapon_reload() {
    weapon_system_init();
    if (global.weapon_reloading) return;
    var item = global.weapon_inventory[global.current_weapon_slot];
    var def = weapon_definition(item.id);
    if (def.type != "gun" || item.ammo >= def.magazine || item.reserve <= 0) return;
    global.weapon_reloading = true;
    global.weapon_reload_timer = max(1, round(def.reload * game_get_speed(gamespeed_fps)));
}

function weapon_reload_step() {
    if (!global.weapon_reloading) return;
    global.weapon_reload_timer--;
    if (global.weapon_reload_timer <= 0) {
        var item = global.weapon_inventory[global.current_weapon_slot];
        var def = weapon_definition(item.id);
        var need = def.magazine - item.ammo;
        var load = min(need, item.reserve);
        item.ammo += load;
        item.reserve -= load;
        global.weapon_inventory[global.current_weapon_slot] = item;
        global.weapon_reloading = false;
    }
}

function weapon_fire(_player) {
    weapon_system_init();
    if (global.weapon_reloading || global.weapon_fire_timer > 0) return false;
    var item = global.weapon_inventory[global.current_weapon_slot];
    var def = weapon_definition(item.id);
    if (def.type == "gun") {
        if (item.ammo <= 0) { weapon_reload(); return false; }
        item.ammo--;
        global.weapon_inventory[global.current_weapon_slot] = item;
        var base_dir = point_direction(_player.x,_player.y,mouse_x,mouse_y);
        for (var p=0; p<def.pellets; p++) {
            var d = base_dir + random_range(-def.spread,def.spread);
            var b = instance_create_depth(_player.x,_player.y,-2,obj_player_bullet);
            b.direction=d; b.image_angle=d; b.speed=def.bullet_speed;
            b.damage=def.damage; b.damage_type=def.damage_type; b.weapon_id=def.id;
            b.knockback=def.knockback; b.crit_chance=def.crit_chance; b.crit_mult=def.crit_mult;
            b.range_left=def.range; b.owner_id=_player.id;
            b.perk_piercing_oneshot = (_player.pierce_perk_timer > 0);
            b.bullet_color=def.color;
        }
        global.weapon_fire_timer = max(1, round(def.fire_rate * game_get_speed(gamespeed_fps)));
        _player.weapon_muzzle_timer = 5;
        return true;
    }
    // Melee: one close-range hit per swing, with central damage calculation.
    var targets = [enemy_lary, enemy_roadboss, enemy_boss_lary];
    for (var t=0; t<array_length(targets); t++) {
        var count = instance_number(targets[t]);
        for (var j=0; j<count; j++) {
            var enemy_id = instance_find(targets[t], j);
            if (instance_exists(enemy_id) && point_distance(_player.x,_player.y,enemy_id.x,enemy_id.y) <= def.melee_range) {
                var hit_dir = point_direction(_player.x,_player.y,enemy_id.x,enemy_id.y);
                damage_apply(enemy_id, def.damage, def.damage_type, _player.id, def.knockback, def.crit_chance, def.crit_mult, hit_dir);
            }
        }
    }
    global.weapon_fire_timer = max(1, round(def.fire_rate * game_get_speed(gamespeed_fps)));
    _player.weapon_muzzle_timer = 7;
    return true;
}

function weapon_runtime_step() {
    weapon_system_init();
    if (global.weapon_fire_timer > 0) global.weapon_fire_timer--;
    weapon_reload_step();
}
