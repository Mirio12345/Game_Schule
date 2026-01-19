// 1. Damage the player
// Check if the player has a variable called 'hp'
if (instance_exists(other)) {
    other.hp -= 1; // Subtract 1 health (change to whatever damage you want)
    
    // Optional: Add a hit effect or flash sound here
    // audio_play_sound(snd_hit, 1, false);
}

// 2. Destroy the bullet so it doesn't pass through
instance_destroy();