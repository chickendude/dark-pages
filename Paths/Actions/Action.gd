extends Area2D

class_name PathAction

signal pause()
signal resume()

var npc

func _ready():
	var _e = connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body : StepdadMonster):
	print(name + " has not implemented _on_body_entered function yet.")
