extends Area2D

export (int) var page_number

var in_range := false

func _ready():
    if not Event.diary_pages[page_number - 1].is_found:
        var _e = connect("body_entered", self, "_on_body_entered")
        _e = connect("area_entered", self, "_on_area_entered")
        _e = connect("area_exited", self, "_on_area_exited")
    else:
        visible = false

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
    var diary_page : DiaryPage = Event.diary_pages[page_number - 1]
    Event.display_text("Found diary page number " + str(diary_page.page_number))
    Event.display_text(diary_page.text)
    diary_page.is_found = true
    self.queue_free()
