if (variable_instance_exists(other.id, "perk_piercing_oneshot") && other.perk_piercing_oneshot) {
    hp = 0;
    // Piercing: Kugel bleibt bestehen.
} else {
    hp -= global.playerDMG;
    if (instance_exists(other)) instance_destroy(other);
}
