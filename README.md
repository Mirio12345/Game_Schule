# Todo:

### (David)
- Heal System ✔️
- Besseres Checkpoint System ✔️
- Vollstaendiges "Level"
- Shader system fur crazy Visioals
- Entity für roommanagement z.B. die Tür geht nur auf wenn alle Tod sind
- (Gewisse Story einbindung)(Mishi)
- (Controller einbindung)

### (Maxim)
- Gamecharacter Sprites!!
- room sprites overwork/neue
- Chest Sprite Offen und zu ✔️
- Random raum stuff wie schilde
- (Menu Designen)
  
### (Amin)
- Boss weiter machen
- Boss raum
- Level Layout

### (Michi)
- Difficulty Anpassen
- Maxim/Amin Helfen
- Gamemaker Lanuage Lernen/Im Game etwas "Programieren"
- Level Layout

# Dokumentation: 

## Stand 23.03.2026:

### Buttons:
Difficulity Buttons funktionieren alle nach dem selben prinzip das sie wichtige Variablen wie den Schaden Erhöhen:
<img width="896" height="592" alt="image" src="https://github.com/user-attachments/assets/811ad420-9a09-409f-97c4-1642cc13bf94" />
Bei anderen geht er meistens nur in einen anderen Raum:
<img width="899" height="593" alt="image" src="https://github.com/user-attachments/assets/3fe60055-43c2-49ee-a090-eccf5ba1e5f9" />
Bei den Zoom Buttons Setzt man genauso eine Zoom Variable:
<img width="655" height="591" alt="image" src="https://github.com/user-attachments/assets/a98bec52-3e5d-4ccc-9f28-516a287ef5fc" />
### Die Checkpoints
haben keinen Code weil deren Logic im Player sind:
<img width="148" height="91" alt="image" src="https://github.com/user-attachments/assets/69800ecf-e5bc-4b95-bd8b-feb2e0a368fb" />
### Gegner
Der Gegner hat verschiedene "States" in der er ist wie chase, shoot und idle:
<img width="735" height="903" alt="image" src="https://github.com/user-attachments/assets/b9c828ff-0176-4e6c-a0ec-67848cb09b06" />
### Player
Im player wird vieles wie movement Healing Checkpoint Cheking Ins Menu gehen und weiteres gemanaged.
### Andere Objekte
<img width="181" height="225" alt="image" src="https://github.com/user-attachments/assets/4bb8bde0-c729-444a-8662-895252b4bb48" />
Sie sind wie die Checkpoints "Dumme Objekte" und werden hauptsächlich von anderen Objekten benutzt.
### Übersicht aller Räume:
<img width="1057" height="595" alt="image" src="https://github.com/user-attachments/assets/63baec7a-4fe4-4a5f-bde3-9de882f19611" />
<img width="954" height="540" alt="image" src="https://github.com/user-attachments/assets/2e6151e9-9d30-4b5c-8568-59428ae1074c" />
<img width="968" height="549" alt="image" src="https://github.com/user-attachments/assets/730e13b3-1aed-4ce7-92ea-2550e29919b6" />
<img width="831" height="864" alt="image" src="https://github.com/user-attachments/assets/c6e71899-eb35-4b4a-8781-f169186bf013" />
<img width="1077" height="763" alt="image" src="https://github.com/user-attachments/assets/8eec8db6-0fd1-4005-a255-875ad99b8697" />


## Winterferien bis 20.01.2026

### Game character:
Hier sieht man die Action des Objektes Game_character:
<img width="568" height="450" alt="image" src="https://github.com/user-attachments/assets/340f631c-67f4-43fb-bc9d-8854635a5d64" />
### code für die Actionen:
Hier sieht man die "Intitialiesierung" das alle Wichtigen Variablen vom Character gesetzt werden:
<img width="1117" height="699" alt="image" src="https://github.com/user-attachments/assets/3e83dad9-65f6-48c4-96ec-03e0fc86742d" />
Hier sieht man was jeden Frame berechnet werden soll wie lauf und collisionts logic, Todes logic und Menu oenfnugs logic:
<img width="1116" height="692" alt="image" src="https://github.com/user-attachments/assets/72405f40-3cac-4699-9d3f-bdfb249db589" />
Hier sieht man jetzt die logic fuer das speichern der Checkpoints:
<img width="1120" height="698" alt="image" src="https://github.com/user-attachments/assets/a214b875-dd6a-47a6-af0a-e164f5d158ef" />
<img width="1114" height="701" alt="image" src="https://github.com/user-attachments/assets/17e037d5-662d-4d54-96dc-abd934524978" />

### Camara:
Das die Kamara dem Character Folgt:
Man sieht die Action:
<img width="1144" height="445" alt="image" src="https://github.com/user-attachments/assets/3af6fedc-5778-4627-a87e-d1d9bd9179e4" />
Man sieht den Code der Actionnen:
<img width="1033" height="700" alt="image" src="https://github.com/user-attachments/assets/fd7c331a-9542-4495-a33c-8a5db144024f" />

### Bullet:
Hier sieht man die Actionen des Objektes Bullet:
<img width="693" height="539" alt="image" src="https://github.com/user-attachments/assets/2d34f175-8f47-4cc2-9f44-25a8b1e48f12" />
den Code fuer die creation: 
<img width="1119" height="685" alt="image" src="https://github.com/user-attachments/assets/bc842e1b-dd3a-48d3-954e-fad64dd31b60" />
bei fast allen Collisionen soll er sich loeschen.
beim gamecharacter zieht er ihm hp ab:
<img width="1110" height="701" alt="image" src="https://github.com/user-attachments/assets/9544c119-38ea-4a69-8bec-8aebb5e35bd1" />

### Hier sieht man die Actionen dser Hp Bar:
<img width="687" height="540" alt="image" src="https://github.com/user-attachments/assets/ee444db9-5d52-4797-85cd-c4fdf0ad9358" />

### Um in andere räume zu kommen: 
Setzt man die position des Characters und Setzt den raum auf den Gewuenschtem raum:
<img width="1164" height="547" alt="image" src="https://github.com/user-attachments/assets/efa6d748-5be8-43a5-943b-032b1336ba16" />
<img width="1168" height="563" alt="image" src="https://github.com/user-attachments/assets/8d0ad7b4-0860-4c2e-b3a2-33ea381e30be" />

### Hier gibts die LOgic des Buttons Base:
<img width="1223" height="669" alt="image" src="https://github.com/user-attachments/assets/80bd5474-47e9-4e63-8bd7-2bd31edb5e01" />

### Beim Respawn Button kommt hinzu:
<img width="1219" height="543" alt="image" src="https://github.com/user-attachments/assets/414203e1-420b-4593-b442-9b8a1c3a0c00" />

### Hier ist der Code der Test Enemys: (Alles nur zum Test des Gegner)
<img width="694" height="520" alt="image" src="https://github.com/user-attachments/assets/17bff6ea-9348-4451-a639-449b125f5ed8" />
<img width="289" height="312" alt="image" src="https://github.com/user-attachments/assets/53aaf2f5-9457-49ac-ba19-5a60612c1620" />
<img width="672" height="633" alt="image" src="https://github.com/user-attachments/assets/c9aac5b6-4236-4faf-a015-4b672ddcd8f3" />
<img width="870" height="117" alt="image" src="https://github.com/user-attachments/assets/c0b1b818-17c9-43fe-8b1f-e658228a30d1" />


### Hier sieht man nochmal den Aufbau aller Räume:
<img width="1601" height="722" alt="image" src="https://github.com/user-attachments/assets/0b6cee56-63c4-4ce2-9751-968e788186fa" />
<img width="1641" height="736" alt="image" src="https://github.com/user-attachments/assets/4801d562-97c4-421c-8f86-1612850c6bd3" />
<img width="1636" height="716" alt="image" src="https://github.com/user-attachments/assets/e5839298-51b5-409a-aed0-c2479a8eb860" />
<img width="1626" height="664" alt="image" src="https://github.com/user-attachments/assets/5b2e1808-22f1-422a-81c1-6e2fb78f9d62" />



## 24.10.25-25.12 Gemacht das man nicht durch objekte kann:

<img width="932" height="536" alt="grafik" src="https://github.com/user-attachments/assets/dc95f0f0-cc5e-4f2b-8402-7075e8b0e806" /> 

### sowie Player Position on runtime gespeichert:

<img width="312" height="349" alt="grafik" src="https://github.com/user-attachments/assets/07188416-6ef1-49e6-a552-0f8a6f828ab3" /> 

### und player bewegung aktualusiert/neugemacht:
Hier sieht man als erstes die logic fuers laufen danach logic das der "Samurai" sich ein die richtung dreht wie in der er laeuft. Als letztes das wenn man den Escape butten druegt man ins Menu kommpt:
<img width="688" height="595" alt="grafik" src="https://github.com/user-attachments/assets/a1ae4720-a68a-4c14-8f95-d52543c9330e" />

## 29.10.25-23.10.25 Story von Ki überarbeitet

## 29.10.25 Story weitergearbeitet 

<img width="1082" height="734" alt="grafik" src="https://github.com/user-attachments/assets/84eee73b-3b8e-4bde-a669-31cdbea0811f" />
https://konradzuseschule-my.sharepoint.com/:w:/r/personal/michael_schmidt_konrad-zuse-schule_de/_layouts/15/Doc.aspx?sourcedoc=%7B2A2DB5D3-5448-4085-9F45-4C979FA7B393%7D&file=Storyboard.docx&fromShare=true&action=default&mobileredirect=true

## 27.10.25 Skizze Worldmap 

<img width="1920" height="1080" alt="grafik" src="https://github.com/user-attachments/assets/9feb7ace-2d36-4eb5-bce3-a3f5f44af1a1" /> 
