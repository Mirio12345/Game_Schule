/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 6DDBDF21
/// @DnDArgument : "expr" "2.5"
/// @DnDArgument : "var" "my_speed"
my_speed = 2.5;

/// @DnDAction : YoYo Games.Common.If_Undefined
/// @DnDVersion : 1
/// @DnDHash : 3A3E19D5
/// @DnDArgument : "var" "global.Pos_x"
if(global.Pos_x == undefined){	/// @DnDAction : YoYo Games.Common.Set_Global
	/// @DnDVersion : 1
	/// @DnDHash : 067E1F9A
	/// @DnDParent : 3A3E19D5
	/// @DnDArgument : "value" "10"
	/// @DnDArgument : "var" "global.Pos_x"
	global.Pos_x = 10;}

/// @DnDAction : YoYo Games.Common.If_Undefined
/// @DnDVersion : 1
/// @DnDHash : 47DFFB67
/// @DnDArgument : "var" "global.Pos_y"
if(global.Pos_y == undefined){	/// @DnDAction : YoYo Games.Common.Set_Global
	/// @DnDVersion : 1
	/// @DnDHash : 0BFE0C87
	/// @DnDParent : 47DFFB67
	/// @DnDArgument : "value" "10"
	/// @DnDArgument : "var" "global.Pos_y"
	global.Pos_y = 10;}

/// @DnDAction : YoYo Games.Movement.Jump_To_Point
/// @DnDVersion : 1
/// @DnDHash : 46A6ED01
/// @DnDArgument : "x" "Pos_x"
/// @DnDArgument : "y" "Pos_y"
x = Pos_x;y = Pos_y;