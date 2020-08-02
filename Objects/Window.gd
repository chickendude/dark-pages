extends Area2D

export (String) var map_name
export (float) var x
export (float) var y
export (Vector2) var direction
export (String) var text

const PLAYER_HITBOX_HEIGHT = 12

func _ready():
	var _e = connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if text:
		Event.push_player_back(Vector2(0, position.y + PLAYER_HITBOX_HEIGHT))
		Event.display_text("The window's stuck... can't get it open.")
	else:
		Event.load_map(map_name, x, y, direction)
