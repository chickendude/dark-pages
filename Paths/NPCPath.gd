extends Path2D


onready var path_follow : PathFollow2D = $PathFollow2D
onready var actions = $Actions
onready var stepdad : StepdadMonster = $PathFollow2D/StepdadMonster

var walker
var paused = false
var stopped = false


func _ready() -> void:
	Event.connect("game_over", self, "_stop")
	walker = path_follow.get_children().front()
	walker.remote_controlled = true
	for action in actions.get_children():
		if action is PathAction:
			action.connect("pause", self, "_pause")
			action.connect("resume", self, "_resume")


func _process(_delta) -> void:
	if not stopped:
		if not paused:
			var cur_pos := path_follow.global_position
			path_follow.offset += 1
			var new_pos := path_follow.global_position
			walker.direction = cur_pos.direction_to(new_pos)
		else:
			walker.direction = Vector2.ZERO


func _stop() -> void:
	walker.remote_controlled = false
	stopped = true

func _pause() -> void:
	paused = true


func _resume() -> void:
	paused = false
