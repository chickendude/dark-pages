extends Path2D


onready var path_follow : PathFollow2D = $PathFollow2D
onready var actions = $Actions
onready var remote2d = $PathFollow2D/RemoteTransform2D

#export (NodePath) var walker_path

var walker : KinematicBody2D
var paused = false
var stopped = false


func _ready() -> void:
	stopped = true
	var _e = Event.connect("game_over", self, "_stop")
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

func load_walker(walker_path : NodePath):
	# We need to account for remote2d being in PathFollow2D,
	# which itself is within NPCPath, hence the double "../"
	remote2d.remote_path = walker_path
	walker = get_node(walker_path)
	walker.remote_controlled = true
	stopped = false


func _stop() -> void:
	walker.remote_controlled = false
	stopped = true

func _pause() -> void:
	paused = true

func _resume() -> void:
	paused = false
