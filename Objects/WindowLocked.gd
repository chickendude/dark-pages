extends "res://Objects/Window.gd"
const PLAYER_HITBOX_HEIGHT = 12

func _on_body_entered(body):
	Event.push_player_back(Vector2(0, position.y + PLAYER_HITBOX_HEIGHT))
	Event.display_text("The window's stuck... can't get it open.")
