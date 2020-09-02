extends Node2D

const BeccasRoomCutscene = preload("res://Cutscenes/BeccasRoomCutscene.tscn")

func _ready():
    if not Event.events[Event.BECCAS_ROOM_CUTSCENE]:
        Event.events[Event.BECCAS_ROOM_CUTSCENE] = true
        # load cutscene
        var cutscene = BeccasRoomCutscene.instance()
        var ysort = $YSort
        ysort.add_child(cutscene)
        cutscene.load_nodes($YSort/Furniture/Door, $YSort/Will, $Camera2D)
        yield(cutscene.start_cutscene(), 'completed')
        $YSort/Will.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
