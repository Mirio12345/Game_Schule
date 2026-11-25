var draw_x = 20; 
var draw_y = 500;

draw_sprite_ext(
    sprite_index, 
    min(count, sprite_get_number(sprite_index) - 1), 
    draw_x, 
    draw_y, 
    1, 1, 0, c_white, 1 // Scale, Rotation, Color, Alpha
);
