/// HP Bar - Step Event

// Smoothly interpolate the display bar to actual HP
var _target = global.player_hp / max(global.max_player_hp, 1);
display_hp = lerp(display_hp, _target, 0.08);

// Damage trail follows slower behind
trail_hp = lerp(trail_hp, _target, trail_speed);

// Update max in case it changes
display_max_hp = global.max_player_hp;

// Glow pulse when damaged
if (_target < display_hp - 0.01) {
    glow_alpha = lerp(glow_alpha, 1, 0.15);
} else {
    glow_alpha = lerp(glow_alpha, 0, 0.04);
}
glow_pulse += 0.05;