extends Node2D

class_name ThoughtBubble

onready var label = $Label

var text := ''
var duration := 2.0

func _ready() -> void:
    label.text = text
    yield(get_tree().create_timer(duration), 'timeout')
    queue_free()
