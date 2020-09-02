extends Node2D

onready var stepdad = $YSort/StepdadMonster
onready var door = $YSort/Furniture/Door

func _ready():
    var destination = Vector2(32*3,32*3 + 6)
    var tree = get_tree()
    yield(tree, "idle_frame")
    yield(tree, "idle_frame")
    stepdad.move_to(destination)
    yield(stepdad, "destination_reached")
    Event.display_text("Let's see how little Becca's doing...")
    Event.display_text("* CRASH *")
    Event.display_text("What was that noise? Sheila...")
    Event.display_text("SHEILA!!!!")
    yield(tree, "idle_frame")
    yield(tree, "idle_frame")
    yield(tree, "idle_frame")
    yield(tree, "idle_frame")
    destination.y += 32 - 10
    stepdad.move_to(destination)
    yield(stepdad, "destination_reached")
    destination.x += 32 * 5
    stepdad.move_to(destination)
    yield(stepdad, "destination_reached")
    door.visible = false
    destination.x += 32 * 2 + 10
    stepdad.move_to(destination)
    yield(stepdad, "destination_reached")
    door.visible = true
    yield(tree.create_timer(.5), "timeout")
    tree.change_scene("res://Maps/BeccasRoom.tscn")
