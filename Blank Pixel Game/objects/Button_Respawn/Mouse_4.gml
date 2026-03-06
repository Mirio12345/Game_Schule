event_inherited();

if global.difficulity = 0
{
	global.player_hp = 120;
}
if global.difficulity = 1
{
	global.player_hp = 100;
}
if global.difficulity = 2
{
	global.player_hp = 80;
}
if global.difficulity = 3
{
	global.player_hp = 60;
}

if global.latest_checkpoint == 0
{
	
}
if global.latest_checkpoint == 1
{
	//									!SCRAPED!
	global.Pos_x = 550
	global.Pos_y = 360
	room_goto(TestRoom)
}
if global.latest_checkpoint == 2
{
	//									!SCRAPED!
	global.Pos_x = 700
	global.Pos_y = 340
	room_goto(lausgang)
}
if global.latest_checkpoint == 3
{
	global.Pos_x = 333
	global.Pos_y = 237
	global.curent_room = Startroom_battle
	room_goto(Startroom_battle)
}
if global.latest_checkpoint == 4
{
	global.Pos_x =264;
	global.Pos_y =475;
	global.curent_room = Fight_many
	room_goto(Fight_many);
}