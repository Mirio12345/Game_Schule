
if (!schon_geloescht && instance_number(enemy_lary) == 0) 
{
    instance_destroy(sealed_door);
    schon_geloescht = true; // Verhindert, dass der Code erneut ausgeführt wird
}