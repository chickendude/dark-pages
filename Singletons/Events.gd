extends Node

func load_map(map_name, x, y):
	get_tree().change_scene('res://Maps/' + map_name + '.tscn')
