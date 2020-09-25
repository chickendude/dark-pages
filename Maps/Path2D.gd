extends Path2D


onready var path_follow = $PathFollow2D


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func _process(delta):
    path_follow.offset += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
