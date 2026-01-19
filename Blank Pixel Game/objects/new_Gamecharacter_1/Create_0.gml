my_speed = 2.5;
try 
{
	Pos_x = global.Pos_x;
	Pos_y = global.Pos_y;
}
catch(_error)
{
	global.Pos_x = 640;
	global.Pos_y = 320;
}

x = Pos_x;
y = Pos_y;
