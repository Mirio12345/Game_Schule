pulse += 0.08;
if (instance_exists(new_Gamecharacter_1) && point_distance(x,y,new_Gamecharacter_1.x,new_Gamecharacter_1.y)<28) {
    var def=weapon_definition(weapon_id);
    weapon_add(weapon_id,def.magazine,def.reserve);
    instance_destroy();
}
