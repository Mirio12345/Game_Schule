/// @description obj_npc – Create
/// Interactive NPC base. Child objects call event_inherited() and then set
/// npc_name / dialogue_lines (and optionally spr_idle / spr_walk arrays).

npc_name = "???";
dialogue_lines = ["..."];
interact_range = 48;
facing = 0;             // sprite index: 0=right 1=down 2=left 3=up
show_prompt = false;