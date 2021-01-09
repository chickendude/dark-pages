extends KinematicBody2D

class_name StepdadMonster

onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree["parameters/playback"]
onready var sight_range = $SightRangeArea
onready var raycast = $RayCast2D

const DialogBubble = preload("res://UI/ThoughtBubble.tscn")

var direction := Vector2.ZERO
var paused := false
var remote_controlled := false
var will_in_range := false
var will : Will = null
var destination : Vector2

export var speed = 100

signal destination_reached()


func _ready() -> void:
	var _e = sight_range.connect("body_entered", self, "_player_in_range")
	_e = sight_range.connect("body_exited", self, "_player_out_of_range")


func _physics_process(_delta) -> void:
	if not paused:
		if will_in_range:
			_check_in_sight()
		
		if destination:
			direction = global_position.direction_to(destination)
			if position.distance_to(destination) < 1:
				direction = Vector2.ZERO
				emit_signal("destination_reached")
		
		if direction:
			SoundManager.play_loop(SoundManager.footsteps)
			animation_state.travel("Walk")
			_set_animation_direction(direction)
		else:
			animation_state.travel("Idle")
			yield(get_tree().create_timer(.1), "timeout")
			if not direction:
				SoundManager.stop_loop(SoundManager.footsteps)

		if not remote_controlled:
			var _e = move_and_slide(direction.normalized() * speed)


func set_facing_direction(_direction : Vector2):
	_set_animation_direction(_direction)


func move_direction(_direction : Vector2):
	direction = _direction


func move_to(_destination : Vector2):
	destination = _destination


func _set_animation_direction(_direction):
	animation_tree.set("parameters/Walk/blend_position", _direction)
	animation_tree.set("parameters/Idle/blend_position", _direction)
	# Add pi otherwise the rotation is behind the stepdad.
	sight_range.rotation = _direction.angle() + PI

func _check_in_sight():
	if will and not Event.game_over:
		# raycast cast_to coordinates are local to the raycast, so need to account for that
		raycast.cast_to = will.global_position - global_position - raycast.position - Vector2(0, 10)
		raycast.force_raycast_update()
		if raycast.get_collider() is Will:
			_found_will()
		else:
			pass

func _found_will() -> void:
	Event.game_over = true
	var bubble = DialogBubble.instance()
	bubble.text = "!"
	add_child(bubble)
	move_to(will.global_position)
	print('Gotcha!')


# signal functions

func _player_in_range(body : Will):
	will_in_range = true
	will = body

func _player_out_of_range(_body : Will):
	will_in_range = false
	will = null

func on_action_reached(_body):
	print(_body.name)
