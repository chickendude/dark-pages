extends Node

onready var door_open_fast :AudioStreamPlayer = $Effects/DoorOpenFast
onready var door_open_slow :AudioStreamPlayer = $Effects/DoorOpenSlow
onready var footsteps : AudioStreamPlayer = $Effects/Footsteps
onready var player_footsteps : AudioStreamPlayer = $Effects/PlayerFootsteps
onready var rain : AudioStreamPlayer = $Effects/Rain

onready var tween : Tween = $Tween

var cur_playing := []

func _ready() -> void:
    door_open_fast.stream.loop = false

func play_single(player : AudioStreamPlayer) -> void:
    player.stream.loop = false
    player.play()

func fade_in(player : AudioStreamPlayer, seconds : int) -> void:
    print('fade in')
    player.stream.loop = true
    var volume_db = player.volume_db
    tween.interpolate_property(player, 'volume_db', -60, volume_db, seconds, Tween.TRANS_LINEAR, Tween.EASE_IN)
    tween.start()
    player.play()
    if not cur_playing.has(player):
        cur_playing.append(player)
    yield(tween, "tween_completed")
    stop_loop(player)

func play_loop(player : AudioStreamPlayer) -> void:
    if not cur_playing.has(player):
        cur_playing.append(player)
    if not player.is_playing():
        player.stream.loop = true
        player.play()

func stop_loop(player : AudioStreamPlayer) -> void:
    if cur_playing.has(player):
        var index = cur_playing.find(player)
        cur_playing.remove(index)
    player.stop()

func stop_all() -> void:
    for player in cur_playing:
        player.stop()
