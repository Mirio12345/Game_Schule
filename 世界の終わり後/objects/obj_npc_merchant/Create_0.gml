/// @description obj_npc_merchant – Create
/// Bazaar trader (NPC Bazarmen). Trade dialogue only; the shop UI is a later task.

event_inherited();

npc_name = "Bazarmen";
dialogue_lines = [
    "Back from the dead, huh? The whole market's talking about you.",
    "Fresh gear just came in: armor plates, weapon mods... even cigarettes that put fire in your legs.",
    "Come back when your purse is heavier. I don't do credit, choom."
];

// Directional sprite lookup: index = round(dir/90) mod 4 -> 0=right 1=up 2=left 3=down
spr_idle = [spr_bazarmen_idle_right, spr_bazarmen_idle_up, spr_bazarmen_idle_left, spr_bazarmen_idle_down];
spr_walk = [spr_bazarmen_walk_right, spr_bazarmen_walk_up, spr_bazarmen_walk_left, spr_bazarmen_walk_down];

// Player approaches from the right side in the Bazaar
facing = 0;
sprite_index = spr_idle[facing];
image_speed = 0.15;