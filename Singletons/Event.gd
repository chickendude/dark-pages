extends Node

enum {
    WILLS_DOOR_UNLOCKED,
    BECCAS_ROOM_WINDOW,
    BECCAS_ROOM_CUTSCENE,
    BECCAS_ROOM_MONSTER_ENTER,
}

const TILE_SIZE = 32
const diary_pages = [
    preload("res://DiaryPages/DiaryPage1.tres"),
    preload("res://DiaryPages/DiaryPage2.tres")
]

const GameOverScene = preload("res://UI/GameOver.tscn")

var events : Array
var game_started = false
var game_over = false setget game_over
var player_position = Vector2.ZERO
var player_direction = Vector2.ZERO

signal display_text(text)
signal push_player_back(position)
signal game_over()

func _ready():
    for _i in range(10):
        events.append(false)


# load a map and place the player in the proper coordinates
func load_map(map_name, x, y, direction : Vector2):
    SoundManager.stop_all()
    game_started = true
    var offset_y : int
    var offset_x : int
    if direction.y != 0:
        offset_y = 15 if direction.y > 0 else 32
        offset_x = 15
    else:
        offset_y = 28
        offset_x = 7 if direction.x > 0 else 25
    player_position = Vector2(x * TILE_SIZE + offset_x, y * TILE_SIZE + offset_y)
    player_direction = direction
    var _e = get_tree().change_scene('res://Maps/' + map_name + '.tscn')


# prepare a text to be drawn to the screen
func display_text(text):
    emit_signal("display_text", text)


# if the player collides with something that should push it back but doesn't
# have StaticBody2D 
func push_player_back(position):
    emit_signal("push_player_back", position)


func game_over(value) -> void:
    game_over = value
    if game_over:
        emit_signal("game_over")
        yield(get_tree().create_timer(2), "timeout")
        var game_over_scene = GameOverScene.instance()
        get_tree().root.add_child(game_over_scene)
