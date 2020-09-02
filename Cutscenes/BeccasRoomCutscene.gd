extends Node2D

onready var stepdad : StepdadMonster = $StepdadMonster
onready var remote_transform : RemoteTransform2D = $StepdadMonster/RemoteTransform2D
var door : Door
var will : Will
var camera : Camera2D

func load_nodes(_door : Door, _will : Will, _camera : Camera2D) -> void:
    door = _door
    will = _will
    camera = _camera

func start_cutscene() -> void:
    # set up
    camera.limit_right = 32 * 13
    remote_transform.remote_path = camera.get_path()
    var destination = Vector2(32*8,32*3 + 24)
    stepdad.position = destination
    stepdad.speed = 40
    door.visible = false
    will.visible = false
    will.paused = true
    var tree = get_tree()
    
    # move to middle of room
    destination.x -= 32 * 2
    stepdad.move_to(destination)
    yield(stepdad, "destination_reached")
    
    # move down to crib
    destination.y += 14
    stepdad.move_to(destination)
    yield(stepdad, "destination_reached")
    
    destination.x -= 32 * 3
    stepdad.move_to(destination)
    yield(stepdad, "destination_reached")

    # pause 1 second
    yield(tree.create_timer(2), "timeout")

    stepdad.set_facing_direction(Vector2.RIGHT)
    yield(tree.create_timer(1), "timeout")

    destination.x += 32 * 2
    stepdad.move_to(destination)
    yield(stepdad, "destination_reached")
    
    stepdad.set_facing_direction(Vector2.UP)
    yield(tree.create_timer(2), "timeout")

    # show next text
    Event.display_text("* CRASH *")
    Event.display_text("What was that noise? Sheila...")
    Event.display_text("SHEILA!!!!")

    stepdad.speed = 120
    destination.x += 32
    stepdad.move_to(destination)
    yield(stepdad, "destination_reached")
    destination.y -= 14
    destination.x += 32
    stepdad.move_to(destination)
    yield(stepdad, "destination_reached")
    destination.x += 32 * 2 + 10
    stepdad.move_to(destination)
    yield(stepdad, "destination_reached")
    stepdad.queue_free()
    door.visible = true
    will.visible = true
    will.paused = false
    yield(tree.create_timer(.5), "timeout")
    camera.position = will.position
    yield(tree.create_timer(.5), "timeout")

    camera.limit_right = 32 * 10

