if (instance_exists(other)) {
	scr_weapon_bullet_hit(id, other);
	instance_destroy(other);
}
