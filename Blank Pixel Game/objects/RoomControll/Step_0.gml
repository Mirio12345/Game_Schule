
if (!schon_geloescht1 && instance_number(enemy_lary) == 0) 
{
    instance_destroy(sealed_door1);
    schon_geloescht1 = true;
    // Track door destruction in save state
    if (!variable_global_exists("door_states")) { global.door_states = {}; }
    global.door_states.door1 = true;
}
if (!schon_geloescht2 && instance_number(enemy_lary) == 2) 
{
    instance_destroy(sealed_door2);
    schon_geloescht2 = true;
    // Track door destruction in save state
    if (!variable_global_exists("door_states")) { global.door_states = {}; }
    global.door_states.door2 = true;
}