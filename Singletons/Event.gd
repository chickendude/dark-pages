extends Node

const TILE_SIZE = 32

var game_started = false
var player_position = Vector2.ZERO
var player_direction = Vector2.ZERO

func load_map(map_name, x, y, direction : Vector2):
	print(map_name)
	print(direction)
	game_started = true
	var offset_y = 15 if direction.y > 0 else 0
	player_position = Vector2(x * TILE_SIZE + 15, y * TILE_SIZE + offset_y)
	player_direction = direction
	var _e = get_tree().change_scene('res://Maps/' + map_name + '.tscn')
