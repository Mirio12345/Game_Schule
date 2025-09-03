/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Key_Down
/// @DnDVersion : 1
/// @DnDHash : 395443B8
/// @DnDArgument : "key" "ord("S")"
var l395443B8_0;l395443B8_0 = keyboard_check(ord("S"));if (l395443B8_0){	/// @DnDAction : YoYo Games.Movement.Add_Motion
	/// @DnDVersion : 1
	/// @DnDHash : 3C3DBBAB
	/// @DnDParent : 395443B8
	/// @DnDArgument : "dir" "image_angle"
	/// @DnDArgument : "speed" "0.1"
	motion_add(image_angle, 0.1);}

/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Key_Down
/// @DnDVersion : 1
/// @DnDHash : 6174FB05
/// @DnDArgument : "key" "ord("S")"
var l6174FB05_0;l6174FB05_0 = keyboard_check(ord("S"));if (l6174FB05_0){	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 059962E1
	/// @DnDParent : 6174FB05
	/// @DnDArgument : "expr" "4"
	/// @DnDArgument : "var" "image_angle"
	image_angle = 4;}