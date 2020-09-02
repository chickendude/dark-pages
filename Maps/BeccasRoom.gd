extends Node2D



func _ready():
    if not Event.events[Event.BECCAS_ROOM_CUTSCENE]:
        Event.events[Event.BECCAS_ROOM_CUTSCENE] = true
        get_tree().change_scene("res://Cutscenes/BeccasRoomCutscene.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
