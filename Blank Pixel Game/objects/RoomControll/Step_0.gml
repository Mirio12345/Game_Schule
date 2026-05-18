
if (!schon_geloescht1 && instance_number(enemy_lary) == 0) 
{
    instance_destroy(sealed_door1);
    schon_geloescht1 = true; // Verhindert, dass der Code erneut ausgeführt wird
}
if (!schon_geloescht2 && instance_number(enemy_lary) == 2) 
{
    instance_destroy(sealed_door2);
    schon_geloescht2 = true; // Verhindert, dass der Code erneut ausgeführt wird
}