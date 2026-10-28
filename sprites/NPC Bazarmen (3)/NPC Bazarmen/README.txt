NPC BAZARMEN - kompakte Version (nur 2 Sprites)
===============================================
Frame-Groesse 32x32 px, transparent. Pro Animation EIN Sprite, alle 4 Richtungen
liegen hintereinander in diesem Sprite:

  spr_bazarmen_idle   24 Frames  = 4 Richtungen x 6 Frames
  spr_bazarmen_walk   32 Frames  = 4 Richtungen x 8 Frames

Frame-Reihenfolge im Sprite:  rechts | oben | links | unten
  image_index = richtung * frames_pro_richtung + frame
  Richtung: 0 = rechts, 1 = oben, 2 = links, 3 = unten

IMPORT IN GAMEMAKER STUDIO
--------------------------
1. Zwei Sprites anlegen: spr_bazarmen_idle und spr_bazarmen_walk.
2. Im Sprite-Editor "Import" -> Strip-Datei aus Sprites/ waehlen
   (_strip24 bzw. _strip32 im Dateinamen = Frame-Anzahl, wird automatisch erkannt).
3. Origin: Custom X 16, Y 31. Collision Mask: Manual, z.B. Left 9 / Right 23 / Top 18 / Bottom 31.
4. Texture-Filtering / Interpolation AUS.
5. Objekt obj_npc_bazarmen anlegen und die drei .gml-Dateien als Create / Step / Draw Event einfuegen.
   Die Animation laeuft manuell (image_speed = 0), damit die Richtung nicht
   in andere Frames springt. obj_player ggf. anpassen.

Vorschau_Uebersicht.png zeigt alle Frames: je Zeile eine Richtung (rechts, oben, links, unten),
zuerst idle, danach walk.
