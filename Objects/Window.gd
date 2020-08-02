extends StaticBody2D

export (String) var map_name
export (float) var x
export (float) var y
export (Vector2) var direction
export (bool) var lights_on
export (String) var text

const PLAYER_HITBOX_HEIGHT = 12

func _ready():
	var _e = $Area2D.connect("body_entered", self, "_on_body_entered")
	if lights_on:
		$Sprite.texture = load("res://data/sprites/objects/window_light.png")

func _on_body_entered(body):
	print(body.name)
	if text:
		Event.display_text(text)
		Event.push_player_back(direction)
	else:
		Event.load_map(map_name, x, y, direction)
