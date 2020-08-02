extends KinematicBody2D

onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree["parameters/playback"]

var direction = Vector2.ZERO

export var SPEED = 100

func _ready():
	if Event.game_started:
		position = Event.player_position
		_set_animation_direction(Event.player_direction)	
	var _e = Event.connect("push_player_back", self, "_push_player_back")

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

func _push_player_back(_position):
	print('push back')
	self.position -= _position
#	if _position.y:
#		position.y = _position.y
#	if _position.x:
#		position.x = _position.x
	direction = Vector2.ZERO
