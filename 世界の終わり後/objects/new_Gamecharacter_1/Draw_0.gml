if (mentol_speed_active)
{
    var _outline = 2;
    var _outline_colour = make_color_rgb(0, 175, 255);
    var _outline_offsets = [
        [-_outline, 0], [_outline, 0],
        [0, -_outline], [0, _outline],
        [-1.5, -1.5], [1.5, -1.5], [-1.5, 1.5], [1.5, 1.5]
    ];

    for (var i = 0; i < array_length(_outline_offsets); i++)
    {
        draw_sprite_ext(
            sprite_index,
            image_index,
            x + _outline_offsets[i][0],
            y + _outline_offsets[i][1],
            image_xscale,
            image_yscale,
            image_angle,
            _outline_colour,
            image_alpha
        );
    }
}

draw_self();
