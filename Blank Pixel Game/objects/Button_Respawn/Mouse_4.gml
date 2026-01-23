event_inherited();

global.player_hp = 100

if global.latest_checkpoint == 0
{
	
}
if global.latest_checkpoint == 1
{
	global.Pos_x = 550
	global.Pos_y = 360
	room_goto(TestRoom)
}
if global.latest_checkpoint == 2
{
	global.Pos_x = 700
	global.Pos_y = 340
	room_goto(lausgang)
}