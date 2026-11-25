var draw_x = 90;
var draw_y = 500;

image_index = count;
draw_sprite_ext(
    sprite_index,
    min(image_index, sprite_get_number(sprite_index) - 1),
    draw_x,
    draw_y,
    1, 1, 0, c_white, 1
);
