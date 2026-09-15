// Wie viel Rüstung dieses Kit gibt, hängt vom aktuellen Schwierigkeitsgrad ab
// (siehe scr_difficulty.gml -> global.armorPerKit).
armor_amount = global.armorPerKit;

// Kein Sprite nötig - das Kit wird komplett per Code im Draw-Event gezeichnet
// (siehe Draw_0.gml). Für die Platzierung im Raum-Editor zeigt GameMaker
// deshalb nur einen Platzhalter an; wer möchte, kann dem Objekt später
// jederzeit ein eigenes Sprite zuweisen, ohne den Code ändern zu müssen.
bob_timer = random(1000); // Startphase der kleinen Schwebe-Animation, damit
                          // nicht alle Kits synchron auf/ab wippen
