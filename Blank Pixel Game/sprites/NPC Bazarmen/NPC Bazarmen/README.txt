NPC BAZARMEN - Cyberpunk Haendler (Waffen & Ausruestung)
=========================================================
Stil:       2D Pixel Art, 32x32 px pro Frame, transparenter Hintergrund
Charakter:  Maennlich, Halb Mensch / Halb Roboter, Neon-Cyber-Auge (cyan) +
            Neon-Akzente (magenta/cyan), neutrale Mimik, Haendler-Look
            (Guertel mit Beuteln, Rucksack, Cyber-Arm & Cyber-Bein)

ANIMATIONEN
-----------
Idle   (Stehen): 6 Frames  -> up / down / left / right  (Atmen, Neon-Pulsieren, Blinzeln)
Walk   (Laufen): 8 Frames  -> up / down / left / right

Ordner:
 Sprites_Strips/         -> 8 Strip-PNGs (Dateiname enthaelt _stripN = Frame-Anzahl)
 Sprites_Einzelframes/   -> jeder Frame einzeln als PNG (pro Animation ein Ordner)
 Spritesheet/            -> alle Animationen in einem Sheet (Zeilen: idle R/U/L/D, walk R/U/L/D)
 Vorschau/               -> GIFs (8x) + Contact Sheet
 GML_Scripts/            -> Create-, Step- und Draw-Event fuer obj_npc_bazarmen

IMPORT IN GAMEMAKER STUDIO
--------------------------
1. Rechtsklick im Asset Browser -> Create -> Sprite (8x, Namen wie die Dateien):
   spr_bazarmen_idle_right / _up / _left / _down
   spr_bazarmen_walk_right / _up / _left / _down
2. Im Sprite-Editor: "Import" -> Strip-Datei waehlen. Wegen "_stripN" im
   Dateinamen erkennt GameMaker die Frame-Anzahl automatisch.
   (Alternativ: alle Dateien aus dem passenden Ordner in Sprites_Einzelframes
   per Drag & Drop in den Sprite-Editor ziehen.)
3. Origin: Custom -> X 16, Y 31 (Fuesse). Collision Mask: Manual, z.B.
   Left 9 / Right 23 / Top 18 / Bottom 31.
4. Sprite-Einstellung: Texture-Filtering AUS (Interpolate colours = off),
   damit die Pixel scharf bleiben.
5. Objekt obj_npc_bazarmen anlegen und die drei .gml-Dateien als
   Create / Step / Draw Event einfuegen. In Step ggf. "obj_player" an dein
   Spielerobjekt anpassen.

Hinweis: Richtungs-Index im Script: 0 = rechts, 1 = oben, 2 = links, 3 = unten.
Das Cyber-Auge ist in der Seitenansicht immer zur Kamera gerichtet sichtbar.
