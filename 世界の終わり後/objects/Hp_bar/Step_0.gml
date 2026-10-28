draw_self()
frame = global.player_hp
max_player_hp = global.max_player_hp
var hp_percent = frame / max_player_hp;

hp_percent = clamp(hp_percent, 0, 1);


image_index = hp_percent * (image_number - 1);