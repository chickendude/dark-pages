extends Path2D


onready var path_follow : PathFollow2D = $PathFollow2D
var walker


# Called when the node enters the scene tree for the first time.
func _ready():
    walker = path_follow.get_children().front()
    walker.remote_controlled = true


func _process(delta):
    var cur_pos := path_follow.global_position
    path_follow.offset += 1
    var new_pos := path_follow.global_position
    walker.direction = cur_pos.direction_to(new_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
