/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Key_Down
/// @DnDVersion : 1
/// @DnDHash : 395443B8
/// @DnDArgument : "key" "ord("D")"
var l395443B8_0;l395443B8_0 = keyboard_check(ord("D"));if (l395443B8_0){	/// @DnDAction : YoYo Games.Collisions.If_Object_At
	/// @DnDVersion : 1.1
	/// @DnDHash : 71755B29
	/// @DnDParent : 395443B8
	/// @DnDArgument : "x" "2.55"
	/// @DnDArgument : "x_relative" "1"
	/// @DnDArgument : "y_relative" "1"
	/// @DnDArgument : "object" "Object5,Object6"
	/// @DnDArgument : "not" "1"
	/// @DnDSaveInfo : "object" "Object5"
	var l71755B29_0 = instance_place(x + 2.55, y + 0, [Wall,Halfwall]);if (!(l71755B29_0 > 0)){	/// @DnDAction : YoYo Games.Movement.Jump_To_Point
		/// @DnDVersion : 1
		/// @DnDHash : 5AFE4C8A
		/// @DnDParent : 71755B29
		/// @DnDArgument : "x" "2.5"
		/// @DnDArgument : "x_relative" "1"
		/// @DnDArgument : "y" "0"
		/// @DnDArgument : "y_relative" "1"
		x += 2.5;y += 0;
	
		/// @DnDAction : YoYo Games.Instances.Set_Sprite
		/// @DnDVersion : 1
		/// @DnDHash : 6AD23C48
		/// @DnDParent : 71755B29
		/// @DnDArgument : "spriteind" "Samurei"
		/// @DnDSaveInfo : "spriteind" "Samurei"
		sprite_index = Samurei;
		image_index = 0;}}

/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Key_Down
/// @DnDVersion : 1
/// @DnDHash : 1560D84C
/// @DnDArgument : "key" "ord("W")"
var l1560D84C_0;l1560D84C_0 = keyboard_check(ord("W"));if (l1560D84C_0){	/// @DnDAction : YoYo Games.Collisions.If_Object_At
	/// @DnDVersion : 1.1
	/// @DnDHash : 61A88FC7
	/// @DnDParent : 1560D84C
	/// @DnDArgument : "x_relative" "1"
	/// @DnDArgument : "y" "-2.55"
	/// @DnDArgument : "y_relative" "1"
	/// @DnDArgument : "object" "Object5,Object6"
	/// @DnDArgument : "not" "1"
	var l61A88FC7_0 = instance_place(x + 0, y + -2.55, [Wall,Halfwall]);if (!(l61A88FC7_0 > 0)){	/// @DnDAction : YoYo Games.Movement.Jump_To_Point
		/// @DnDVersion : 1
		/// @DnDHash : 417D6D33
		/// @DnDParent : 61A88FC7
		/// @DnDArgument : "x" "0"
		/// @DnDArgument : "x_relative" "1"
		/// @DnDArgument : "y" "-2.5"
		/// @DnDArgument : "y_relative" "1"
		x += 0;y += -2.5;}}

/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Key_Down
/// @DnDVersion : 1
/// @DnDHash : 202D60DC
/// @DnDArgument : "key" "ord("A")"
var l202D60DC_0;l202D60DC_0 = keyboard_check(ord("A"));if (l202D60DC_0){	/// @DnDAction : YoYo Games.Collisions.If_Object_At
	/// @DnDVersion : 1.1
	/// @DnDHash : 15AFF0E4
	/// @DnDParent : 202D60DC
	/// @DnDArgument : "x" "-2.55"
	/// @DnDArgument : "x_relative" "1"
	/// @DnDArgument : "y_relative" "1"
	/// @DnDArgument : "object" "Object5,Object6"
	/// @DnDArgument : "not" "1"
	var l15AFF0E4_0 = instance_place(x + -2.55, y + 0, [Wall,Halfwall]);if (!(l15AFF0E4_0 > 0)){	/// @DnDAction : YoYo Games.Movement.Jump_To_Point
		/// @DnDVersion : 1
		/// @DnDHash : 2BD24AF2
		/// @DnDParent : 15AFF0E4
		/// @DnDArgument : "x" "-2.5"
		/// @DnDArgument : "x_relative" "1"
		/// @DnDArgument : "y" "0"
		/// @DnDArgument : "y_relative" "1"
		x += -2.5;y += 0;
	
		/// @DnDAction : YoYo Games.Instances.Set_Sprite
		/// @DnDVersion : 1
		/// @DnDHash : 4A2C39E9
		/// @DnDParent : 15AFF0E4
		/// @DnDArgument : "imageind_relative" "1"
		/// @DnDArgument : "spriteind" "Flip_samurei"
		/// @DnDSaveInfo : "spriteind" "Flip_samurei"
		sprite_index = Flip_samurei;
		image_index += 0;}}

/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Key_Down
/// @DnDVersion : 1
/// @DnDHash : 4B8B39C6
/// @DnDArgument : "key" "ord("S")"
var l4B8B39C6_0;l4B8B39C6_0 = keyboard_check(ord("S"));if (l4B8B39C6_0){	/// @DnDAction : YoYo Games.Collisions.If_Object_At
	/// @DnDVersion : 1.1
	/// @DnDHash : 22327F5E
	/// @DnDParent : 4B8B39C6
	/// @DnDArgument : "x_relative" "1"
	/// @DnDArgument : "y" "2.55"
	/// @DnDArgument : "y_relative" "1"
	/// @DnDArgument : "object" "Object5,Object6"
	/// @DnDArgument : "not" "1"
	var l22327F5E_0 = instance_place(x + 0, y + 2.55, [Wall,Halfwall]);if (!(l22327F5E_0 > 0)){	/// @DnDAction : YoYo Games.Movement.Jump_To_Point
		/// @DnDVersion : 1
		/// @DnDHash : 32D9E9CD
		/// @DnDParent : 22327F5E
		/// @DnDArgument : "x" "0"
		/// @DnDArgument : "x_relative" "1"
		/// @DnDArgument : "y" "2.5"
		/// @DnDArgument : "y_relative" "1"
		x += 0;y += 2.5;}}

/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Key_Down
/// @DnDVersion : 1
/// @DnDHash : 57C8AB4A
/// @DnDArgument : "key" "vk_escape"
var l57C8AB4A_0;l57C8AB4A_0 = keyboard_check(vk_escape);if (l57C8AB4A_0){	/// @DnDAction : YoYo Games.Rooms.Go_To_Room
	/// @DnDVersion : 1
	/// @DnDHash : 3859A54E
	/// @DnDParent : 57C8AB4A
	/// @DnDArgument : "room" "Startscreen"
	/// @DnDSaveInfo : "room" "Startscreen"
	room_goto(Startscreen);

	/// @DnDAction : YoYo Games.Instances.Destroy_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 63941B5E
	/// @DnDParent : 57C8AB4A
	instance_destroy();}