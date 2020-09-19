extends Node2D

const BeccasRoomCutscene = preload("res://Cutscenes/BeccasRoomCutscene.tscn")

onready var door = $YSort/Furniture/Door

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
    if not Event.events[Event.BECCAS_ROOM_MONSTER_ENTER]:
        print('monster')
        yield(get_tree().create_timer(5), "timeout")
        yield(SoundManager.fade_in(SoundManager.footsteps, 10), "completed")
        door.visible = false
        SoundManager.play_single(SoundManager.door_open_slow)
