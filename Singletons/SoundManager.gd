extends Node

onready var door_open_fast :AudioStreamPlayer = $Effects/DoorOpenFast
onready var footsteps : AudioStreamPlayer = $Effects/Footsteps
onready var player_footsteps : AudioStreamPlayer = $Effects/PlayerFootsteps
onready var rain : AudioStreamPlayer = $Effects/Rain

var cur_playing := []

func _ready() -> void:
    door_open_fast.stream.loop = false

func play_single(player : AudioStreamPlayer) -> void:
    player.stream.loop = false
    player.play()

func play_loop(player : AudioStreamPlayer) -> void:
    if not cur_playing.has(player):
        player.stream.loop = true
        cur_playing.append(player)
        player.play()

func stop_loop(player : AudioStreamPlayer) -> void:
    if cur_playing.has(player):
        var index = cur_playing.find(player)
        cur_playing.remove(index)
    player.stop()

func stop_all() -> void:
    for player in cur_playing:
        player.stop()
