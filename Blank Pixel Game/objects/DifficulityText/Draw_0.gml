var draw_x = 256; 
var draw_y = 320;

if global.difficulity == 0
{
	draw_text(draw_x, draw_y, "Easy")
}
if global.difficulity == 1
{
	draw_text(draw_x, draw_y, "Normal")
}
if global.difficulity == 2
{
	draw_text(draw_x, draw_y, "Hard")
}
if global.difficulity == 3
{
	draw_text(draw_x, draw_y, "Dominix")
}