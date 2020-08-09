extends Area2D

export (int) var page_number = 1
export (String, MULTILINE) var text

var in_range := false

func _ready():
	var _e = connect("body_entered", self, "_on_body_entered")
	_e = connect("area_entered", self, "_on_area_entered")
	_e = connect("area_exited", self, "_on_area_exited")

func _unhandled_key_input(_event):
	if in_range and Input.is_action_just_pressed("ui_accept"):
		_pick_up_page()

func _on_area_entered(area):
	if area.is_in_group("Will"):
		in_range = true

func _on_area_exited(area):
	if area.is_in_group("Will"):
		in_range = false
		
func _on_body_entered(body: Will):
	if body and body.is_in_group("Will"):
		_pick_up_page()

func _pick_up_page():
	Event.display_text("Found diary page number " + str(page_number))
	Event.display_text(text)
	self.queue_free()
