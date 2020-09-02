extends Area2D


export (String) var map_name
export (float) var x
export (float) var y
export (Vector2) var direction

func _ready():
    var _e = connect("body_entered", self, "_on_body_entered")

func _on_body_entered(_body: KinematicBody2D):
    print('body: ' + _body.name)
    if _body.is_in_group("Will"):
        Event.load_map(map_name, x, y, direction)
