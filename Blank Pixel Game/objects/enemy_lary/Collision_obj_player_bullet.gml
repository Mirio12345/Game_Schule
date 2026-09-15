if (variable_instance_exists(other.id, "perk_piercing_oneshot") && other.perk_piercing_oneshot) {
    hp = 0;
} else {
    hp -= global.playerDMG;
}
