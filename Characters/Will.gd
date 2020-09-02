extends KinematicBody2D

class_name Will

onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree["parameters/playback"]

var direction = Vector2.ZERO
var paused = false

export var SPEED = 100

func _ready() -> void:
    if Event.game_started:
        position = Event.player_position
        _set_animation_direction(Event.player_direction)	
    var _e = Event.connect("push_player_back", self, "_push_player_back")

func _process(_delta) -> void:
    if not paused:
        if direction:
            animation_state.travel("Walk")
            _set_animation_direction(direction)
        else:
            animation_state.travel("Idle")
    
        var _e = move_and_slide(direction.normalized() * SPEED)

func _unhandled_input(_event) -> void:
    direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

func _set_animation_direction(_direction) -> void:
    animation_tree.set("parameters/Walk/blend_position", _direction)
    animation_tree.set("parameters/Idle/blend_position", _direction)

func _push_player_back(_position) -> void:
    self.position -= _position
    direction = Vector2.ZERO
