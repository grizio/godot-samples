extends Node2D

const ball_scene: PackedScene = preload("uid://bscb3hpn6rys8")

@export var ball_speed: float = 400
@export_range(0, 2000, 1, "suffix: px/minute") var ball_acceleration: float = 200

var balls: Array[Ball] = []

@onready var game_over: GameOver = $GameOver
@onready var win: Win = $Win
@onready var level: Level = $Level

func _ready() -> void:
    level.won.connect(_on_won)
    level.lost.connect(_on_lost)

func _on_won() -> void:
    win.visible = true
    get_tree().paused = true

func _on_lost() -> void:
    game_over.visible = true
    get_tree().paused = true
