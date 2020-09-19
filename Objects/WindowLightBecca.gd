tool
extends "res://Objects/Window.gd"

signal move_will_cutscene()

# set in Roof.gd
var root_node : Roof

func _on_body_entered(body) -> void:
    if not Event.events[Event.BECCAS_ROOM_WINDOW]:
        Event.events[Event.BECCAS_ROOM_WINDOW] = true
        yield(root_node.start_will_cutscene(), "completed")
        ._on_body_entered(body)
    else:
        ._on_body_entered(body)
