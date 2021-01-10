extends Node2D

const BeccasRoomCutscene = preload("res://Cutscenes/BeccasRoomCutscene.tscn")
const StepdadMonsterCheckRoom = preload("res://Characters/BeccasRoom/StepdadMonsterCheckRoom.tscn")

onready var door = $YSort/Furniture/Door
onready var ysort = $YSort
onready var paths = $Paths
onready var stepdad_monster = $YSort/StepdadMonster

func _ready():
	if not Event.events[Event.BECCAS_ROOM_CUTSCENE]:
		Event.events[Event.BECCAS_ROOM_CUTSCENE] = true
		# load cutscene
#        var cutscene = BeccasRoomCutscene.instance()
#        ysort.add_child(cutscene)
#        cutscene.load_nodes($YSort/Furniture/Door, $YSort/Will, $Camera2D)
#        yield(cutscene.start_cutscene(), 'completed')
#        cutscene.queue_free()
		$YSort/Will.visible = true
	if not Event.events[Event.BECCAS_ROOM_MONSTER_ENTER]:
		print('monster')
		var num_paths : int = paths.get_child_count()
		var index : int = randi() % num_paths
		for path in paths.get_children():
			if path.get_index() == index:
				path.load_walker(stepdad_monster.get_path())
			else:
				path.queue_free()
#        var monster = StepdadMonsterCheckRoom.instance()
#        monster.connect("open_door", self, "_open_door")
#        path_follow.add_child(monster)

func _open_door() -> void:
	door.visible = false
	SoundManager.play_single(SoundManager.door_open_slow)
