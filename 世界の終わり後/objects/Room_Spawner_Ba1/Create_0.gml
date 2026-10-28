// 1. Define all 18 possible spawn locations
spawn_points = [
    {x: 128,  y: 192},  {x: 320, y: 192},  {x: 512, y:224},
    {x:704,  y: 224}, {x: 896, y: 192}, {x: 992, y: 160},
    {x: 1219,  y: 195}, {x: 1312, y: 192}, {x: 574, y: 394},
    {x: 736, y: 448},  {x: 864, y: 448},  {x: 992, y: 448},
    {x: 1184, y: 448}, {x: 1280, y: 480}, {x: 1152, y: 576},
    {x: 1297, y: 572}, {x: 1216, y: 640}, {x: 1120, y: 704}
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