function save_system_init() {
    if (!variable_global_exists("save_system_ready")) {
        global.save_system_ready=true;
        global.save_prefix="save_slot_";
        global.autosave_timer=0;
        global.playtime_seconds=0;
        global.story_flags={};
        global.checkpoint_flags={"1":false,"2":false,"3":false,"4":false,"5":false};
        global.boss_flags={};
    }
}
function save_path(_slot) { return working_directory + "save_slot_" + string(_slot) + ".json"; }
function save_payload() {
    save_system_init(); weapon_system_init();
    var data={version:2, room:room, room_name:room_get_name(room), x:global.Pos_x, y:global.Pos_y,
        checkpoint:global.latest_checkpoint, hp:global.player_hp, max_hp:global.max_player_hp,
        armor:global.player_armor, max_armor:global.max_player_armor, difficulty:global.difficulity,
        heal_count:global.HealitemCount, max_heal:global.MaxHealitemCount, current_weapon:global.current_weapon_slot,
        weapon_inventory:global.weapon_inventory, checkpoint_flags:global.checkpoint_flags,
        story_flags:global.story_flags, boss_flags:global.boss_flags, playtime:global.playtime_seconds};
    return data;
}
function save_slot(_slot, _autosave=false) {
    if (_slot<1 || _slot>3) return false;
    var data=save_payload();
    var text=json_stringify(data);
    var f=file_text_open_write(save_path(_slot));
    if (f<0) return false;
    file_text_write_string(f,text); file_text_close(f);
    // Verify the file immediately so a failed write is not treated as a valid save.
    var vf=file_text_open_read(save_path(_slot));
    if (vf<0) return false;
    var verify=file_text_read_string(vf); file_text_close(vf);
    if (string_length(verify)<2) return false;
    return true;
}
function save_autosave() {
    save_system_init();
    return save_slot(1,true);
}
function load_slot(_slot) {
    if (_slot<1 || _slot>3 || !file_exists(save_path(_slot))) return false;
    var f=file_text_open_read(save_path(_slot));
    if (f<0) return false;
    var text=file_text_read_string(f); file_text_close(f);
    var data=json_parse(text);
    if (!is_struct(data) || !variable_struct_exists(data,"version")) return false;
    global.Pos_x=data.x; global.Pos_y=data.y; global.latest_checkpoint=data.checkpoint;
    global.player_hp=data.hp; global.max_player_hp=data.max_hp; global.player_armor=data.armor; global.max_player_armor=data.max_armor;
    global.HealitemCount=data.heal_count; global.MaxHealitemCount=data.max_heal; global.difficulity=data.difficulty;
    global.current_weapon_slot=data.current_weapon; global.weapon_inventory=data.weapon_inventory;
    global.checkpoint_flags=data.checkpoint_flags; global.story_flags=data.story_flags; global.boss_flags=data.boss_flags;
    global.playtime_seconds=data.playtime;
    if (room != data.room) room_goto(data.room); else room_restart();
    return true;
}
function delete_save_slot(_slot) {
    if (_slot<1 || _slot>3) return false;
    var p=save_path(_slot); if (file_exists(p)) file_delete(p);
    return true;
}
function save_slot_exists(_slot) { return (_slot>=1 && _slot<=3 && file_exists(save_path(_slot))); }
function save_slot_info(_slot) {
    if (!save_slot_exists(_slot)) return {exists:false,label:"EMPTY",area:"—",checkpoint:"—",playtime:"00:00:00"};
    var f=file_text_open_read(save_path(_slot)); if (f<0) return {exists:false,label:"CORRUPT",area:"—",checkpoint:"—",playtime:"—"};
    var text=file_text_read_string(f); file_text_close(f);
    var ok=true; var data=undefined;
    try { data=json_parse(text); } catch(e) { ok=false; }
    if (!ok || !is_struct(data)) return {exists:false,label:"CORRUPT",area:"—",checkpoint:"—",playtime:"—"};
    var secs=max(0,real(data.playtime));
    return {exists:true,label:"SAVE SLOT "+string(_slot),area:string(data.room_name),checkpoint:string(data.checkpoint),playtime:string(floor(secs/3600))+":"+string_format(floor((secs%3600)/60),2,0)+":"+string_format(floor(secs%60),2,0)};
}
