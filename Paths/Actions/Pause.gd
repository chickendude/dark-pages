extends "res://Paths/Actions/Action.gd"


export var wait_time : int


func _on_body_entered(body : StepdadMonster):
    emit_signal("pause")
    yield(get_tree().create_timer(wait_time), "timeout")
    emit_signal("resume")    
