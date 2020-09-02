extends KinematicBody2D

class_name StepdadMonster

onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree["parameters/playback"]
onready var sight_range = $SightRangeArea
onready var raycast = $RayCast2D

var direction := Vector2.ZERO
var will_in_range := false
var will : Will = null
var destination : Vector2

export var SPEED = 100

signal destination_reached()

func _ready():
    var _e = sight_range.connect("body_entered", self, "_player_in_range")
    _e = sight_range.connect("body_exited", self, "_player_out_of_range")

func _physics_process(_delta):
    if will_in_range:
        _check_in_sight()
    
    if destination:
        direction = position.direction_to(destination)
        if position.distance_to(destination) < 1:
            direction = Vector2.ZERO
            emit_signal("destination_reached")
    
    if direction:
        animation_state.travel("Walk")
        _set_animation_direction(direction)
    else:
        animation_state.travel("Idle")

    var _e = move_and_slide(direction.normalized() * SPEED)

func _unhandled_input(_event):
#    direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#    direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    pass


func set_facing_direction(_direction : Vector2):
    _set_animation_direction(_direction)

func move_direction(_direction : Vector2):
    direction = _direction

func move_to(_destination : Vector2):
    destination = _destination

func _set_animation_direction(_direction):
    animation_tree.set("parameters/Walk/blend_position", _direction)
    animation_tree.set("parameters/Idle/blend_position", _direction)

func _check_in_sight():
    if will:
        # raycast cast_to coordinates are local to the raycast, so need to account for that
        raycast.cast_to = will.position - position - raycast.position - Vector2(0, 10)
        raycast.force_raycast_update()
        if not raycast.is_colliding():
            print('Gotcha!')

# signal functions

func _player_in_range(body : Will):
    will_in_range = true
    will = body

func _player_out_of_range(body : Will):
    will_in_range = false
    will = null
