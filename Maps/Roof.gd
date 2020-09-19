extends Node2D

class_name Roof

onready var window_light = $YSort/Windows/WindowLightBecca
onready var will = $YSort/Will

func _ready():
    SoundManager.play_loop(SoundManager.rain)
    window_light.root_node = self

func start_will_cutscene():
    will.input_blocked = true
    will.direction = Vector2.UP
    yield(get_tree().create_timer(.2), "timeout")
    will.direction = Vector2.RIGHT
    yield(get_tree().create_timer(.1), "timeout")
    will.direction = Vector2.ZERO
    yield(get_tree().create_timer(1), "timeout")
    will.input_blocked = false
