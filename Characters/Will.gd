extends KinematicBody2D

onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree["parameters/playback"]

var direction = Vector2.ZERO

export var SPEED = 100

func _process(_delta):
	if direction:
		animation_state.travel("Walk")
		_set_animation_direction(direction)
	else:
		animation_state.travel("Idle")

	var _e = move_and_slide(direction.normalized() * SPEED)

func _unhandled_input(_event):
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

func _set_animation_direction(_direction):
	animation_tree.set("parameters/Walk/blend_position", _direction)
	animation_tree.set("parameters/Idle/blend_position", _direction)
