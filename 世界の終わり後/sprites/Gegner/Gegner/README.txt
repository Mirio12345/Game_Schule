GEGNER - Cyberpunk Enemy Pack
=============================
Var1 = "Radioaktiver Spinnen-Roboter"  (spr_gegner1_*)
   - lange, duenne Form, lange Arme mit Krallen, radioaktive Staubwolke ueber dem Kopf,
     4 Spinnenbeine, gruener Reaktorkern, giftgruene Neon-Augen
Var2 = "Neon-Mensch"  (spr_gegner2_*)
   - menschliches Aussehen, Neon-Roehren (Cyan/Magenta), lange Beine, kurze Arme,
     gruenes Kreuz auf dem Bauch, Neon-Irokese

Frame-Groesse: 48x48 px, transparenter Hintergrund, 2D Pixel Art

ANIMATIONEN pro Variante
------------------------
idle    6 Frames  x 4 Richtungen (right / up / left / down)
walk    8 Frames  x 4 Richtungen
attack  6 Frames  x 4 Richtungen   (Var1: Krallenschlag mit Strahlungsstoss, Var2: Kick + Neon-Schlag)
death   6 Frames  (ohne Richtung)

ORDNER je Variante (Var1 / Var2)
 Sprites_Strips/        Strip-PNGs  (Dateiname enthaelt _stripN = Frame-Anzahl)
 Sprites_Einzelframes/  alle Frames einzeln
 Spritesheet/           alle Animationen in einem Sheet (Zeilen: idle, walk, attack je R/U/L/D, danach death)
 Vorschau/              GIFs (6x) + Contact Sheet
 GML_Scripts/           Create / Step / Draw Event (KI: idle -> verfolgen -> angreifen -> sterben)

IMPORT IN GAMEMAKER STUDIO
--------------------------
1. Pro Animation einen Sprite anlegen (Name = Dateiname ohne _stripN), z.B.
   spr_gegner1_walk_down. Im Sprite-Editor "Import" -> Strip-Datei waehlen;
   GameMaker erkennt die Frame-Anzahl aus "_stripN".
2. Origin: Custom X 24, Y 47 (Fuesse).
   Collision Mask (manual) Var1: Left 14 / Right 34 / Top 7 / Bottom 47
                           Var2: Left 18 / Right 30 / Top 3 / Bottom 47
3. Texture-Filtering / Interpolation AUS, damit die Pixel scharf bleiben.
4. Objekt obj_gegner1 bzw. obj_gegner2 anlegen und die drei .gml-Dateien als
   Create / Step / Draw Event einfuegen (obj_player ggf. anpassen).
   Richtungs-Index: 0 = rechts, 1 = oben, 2 = links, 3 = unten.
5. Der death-Sprite bleibt auf dem letzten Frame stehen (Script erledigt das).
