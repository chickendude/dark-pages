extends StepdadMonster

signal open_door()

# Called when the node enters the scene tree for the first time.
func _ready():
    visible = false

func _enter_room():
    get_tree().create_timer(10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
