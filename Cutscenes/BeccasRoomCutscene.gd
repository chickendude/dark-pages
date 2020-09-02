extends Node2D

const Bubble = preload("res://UI/ThoughtBubble.tscn")

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
    
    # move to window
    destination.x -= 32 * 3
    stepdad.move_to(destination)
    yield(stepdad, "destination_reached")


    yield(tree.create_timer(1), "timeout")

    var thought_bubble : ThoughtBubble = Bubble.instance()
    thought_bubble.text = '...'
    thought_bubble.duration = 1
    stepdad.add_child(thought_bubble)

    # pause
    yield(tree.create_timer(2), "timeout")

    stepdad.set_facing_direction(Vector2.RIGHT)
    yield(tree.create_timer(1), "timeout")

    destination.x += 32 * 2
    stepdad.move_to(destination)
    yield(stepdad, "destination_reached")
    
    stepdad.set_facing_direction(Vector2.UP)
    yield(tree.create_timer(2), "timeout")

    # show next text
    for i in range(5):
        var num_pixels = (i & 1) * 2 - 1
        print(num_pixels)
        camera.offset_h = num_pixels
        yield(tree.create_timer(.1), "timeout")
    camera.offset_h = 0

    thought_bubble = Bubble.instance()
    thought_bubble.text = '!'
    stepdad.add_child(thought_bubble)
    yield(tree.create_timer(2), "timeout")

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

