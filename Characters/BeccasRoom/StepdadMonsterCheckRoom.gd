extends StepdadMonster

const Bubble = preload("res://UI/ThoughtBubble.tscn")


func _ready():
    visible = false
    paused = true
    yield(get_tree().create_timer(1), "timeout")
    yield(SoundManager.fade_in(SoundManager.footsteps, 5), "completed")
    emit_signal("open_door")
    visible = true
    yield(get_tree().create_timer(.2), "timeout")
    paused = false

    var destination = Vector2(32*8,32*3 + 24)
    position = destination
    speed = 40
    SoundManager.play_single(SoundManager.door_open_fast)
    var tree = get_tree()
    
    # move to middle of room
    destination.x -= 32 * 2
    move_to(destination)
    yield(self, "destination_reached")
    
    # move down to crib
    destination.y += 14
    move_to(destination)
    yield(self, "destination_reached")
    
    # move to window
    destination.x -= 32 * 3
    move_to(destination)
    yield(self, "destination_reached")


    yield(tree.create_timer(1), "timeout")

    var thought_bubble : ThoughtBubble = Bubble.instance()
    thought_bubble.text = '...'
    thought_bubble.duration = 1
    add_child(thought_bubble)

    # pause
    yield(tree.create_timer(2), "timeout")

    set_facing_direction(Vector2.RIGHT)
    yield(tree.create_timer(1), "timeout")

    destination.x += 32 * 2
    move_to(destination)
    yield(self, "destination_reached")
    
    set_facing_direction(Vector2.UP)
    yield(tree.create_timer(1), "timeout")

    set_facing_direction(Vector2.RIGHT)
    yield(wait(), 'completed')

    thought_bubble = Bubble.instance()
    thought_bubble.text = '!'
    add_child(thought_bubble)
    yield(tree.create_timer(2), "timeout")

    speed = 120
    destination.x += 32
    move_to(destination)
    yield(self, "destination_reached")
    destination.y -= 14
    destination.x += 32
    move_to(destination)
    yield(self, "destination_reached")
    destination.x += 32 * 2 + 10
    move_to(destination)
    yield(self, "destination_reached")
    SoundManager.stop_loop(SoundManager.footsteps)
    queue_free()

func wait() -> void:
    yield(get_tree(), "idle_frame")
    yield(get_tree(), "idle_frame")
    yield(get_tree(), "idle_frame")
    yield(get_tree(), "idle_frame")

func _found_will() -> void:
    print('found ya')
    Event.display_text("Ahh! Will is dead!")
