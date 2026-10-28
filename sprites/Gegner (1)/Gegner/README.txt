GEGNER - kompakte Version (nur 4 Sprites pro Gegner)
====================================================
Var1 = "Radioaktiver Spinnen-Roboter"  (spr_gegner1_*)
Var2 = "Neon-Mensch"                   (spr_gegner2_*)
Frame-Groesse 48x48 px, transparent. Pro Animation EIN Sprite, alle 4 Richtungen
liegen hintereinander in diesem Sprite:

  spr_gegnerN_idle     24 Frames = 4 Richtungen x 6
  spr_gegnerN_walk     32 Frames = 4 Richtungen x 8
  spr_gegnerN_attack   24 Frames = 4 Richtungen x 6
  spr_gegnerN_death     6 Frames (ohne Richtung)

Frame-Reihenfolge im Sprite:  rechts | oben | links | unten
  image_index = richtung * frames_pro_richtung + frame
  Richtung: 0 = rechts, 1 = oben, 2 = links, 3 = unten

IMPORT IN GAMEMAKER STUDIO
--------------------------
1. Je Gegner 4 Sprites anlegen (Name = Dateiname ohne _stripN), z.B. spr_gegner1_walk.
   Im Sprite-Editor "Import" -> Strip-Datei aus Var1/Sprites bzw. Var2/Sprites waehlen;
   GameMaker erkennt die Frame-Anzahl aus "_stripN".
2. Origin: Custom X 24, Y 47 (Fuesse).
   Collision Mask (manual) Var1: Left 14 / Right 34 / Top 7 / Bottom 47
                           Var2: Left 18 / Right 30 / Top 3 / Bottom 47
3. Texture-Filtering / Interpolation AUS.
4. Objekt obj_gegner1 bzw. obj_gegner2 anlegen und die drei .gml-Dateien als
   Create / Step / Draw Event einfuegen (obj_player ggf. anpassen).
   Idle/Walk/Attack laufen manuell (image_speed = 0), Death mit normalem image_speed.
5. Der death-Sprite bleibt auf dem letzten Frame stehen (Script erledigt das).

Vorschau_Uebersicht.png in jedem Var-Ordner zeigt alle Frames: je Zeile eine Richtung
(rechts, oben, links, unten) fuer idle, walk, attack, danach death.
