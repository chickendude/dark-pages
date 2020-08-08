extends Node

enum {
	WILLS_DOOR_UNLOCKED
}

const TILE_SIZE = 32

var events : Array
var game_started = false
var player_position = Vector2.ZERO
var player_direction = Vector2.ZERO

signal display_text(text)
signal push_player_back(position)


func _ready():
	for _i in range(5):
		events.append(false)


# load a map and place the player in the proper coordinates
func load_map(map_name, x, y, direction : Vector2):
#	print(map_name)
#	print(direction)
	game_started = true
	var offset_y : int
	var offset_x : int
	if direction.y != 0:
		offset_y = 15 if direction.y > 0 else 0
		offset_x = 15
	else:
		offset_y = 28
		offset_x = 8 if direction.x > 0 else 26
	player_position = Vector2(x * TILE_SIZE + offset_x, y * TILE_SIZE + offset_y)
	player_direction = direction
	var _e = get_tree().change_scene('res://Maps/' + map_name + '.tscn')


# prepare a text to be drawn to the screen
func display_text(text):
	emit_signal("display_text", text)


# if the player collides with something that should push it back but doesn't
# have StaticBody2D 
func push_player_back(position):
	emit_signal("push_player_back", position)
