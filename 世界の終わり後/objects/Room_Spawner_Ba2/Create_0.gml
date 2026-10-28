// 1. Define all 18 possible spawn locations
spawn_points = [
    {x: 800,  y: 704},  {x: 576, y: 704},  {x: 576, y:576},
    {x:320,  y: 704}, {x: 96, y: 704}, {x: 96, y: 448},
    {x: 256,  y: 448}, {x: 96, y: 320}, {x: 256, y: 320},
    {x: 96, y: 192},  {x: 256, y: 192},  {x: 416, y: 192},
    {x: 576, y: 192}, {x: 736, y: 192}, {x: 896, y: 192},
    {x: 1056, y: 192}, {x: 1216, y: 192}
];

// Always call randomize() so the seed changes every time you play
randomize();

// 2. Shuffle the entire list of positions
var shuffled_points = array_shuffle(spawn_points);

// 3. Loop 10 times to spawn enemies at the first 10 random spots
var spawn_count = 10;

for (var i = 0; i < spawn_count; i++) {
    var pos = shuffled_points[i];
    instance_create_layer(pos.x, pos.y, "Instances_1", enemy_lary);
	enemy_lary.image_xscale = 1.6;
    enemy_lary.image_yscale = 1.4;
}