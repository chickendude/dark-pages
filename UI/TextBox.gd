extends CanvasLayer

onready var textbox = $NinePatchRect
onready var label = $NinePatchRect/Label

var texts : Array

func _ready():
	textbox.visible = false
	label.text = ''
	Event.connect("display_text", self, "_queue_text")


func _unhandled_key_input(event):
	if event.is_action_pressed("ui_accept"):
		_next_text()

func _queue_text(_text):
	texts.append(_text)
	if not textbox.visible:
		_next_text()
	textbox.visible = true
	get_tree().paused = true

func _next_text():
	var text = texts.pop_front()
	if text:
		label.text = text
	else:
		textbox.visible = false
		get_tree().paused = false
