extends Node2D

const ball_scene: PackedScene = preload("uid://bscb3hpn6rys8")

@export var ball_speed: float = 400
@export_range(0, 2000, 1, "suffix: px/minute") var ball_acceleration: float = 200

var balls: Array[Ball] = []

@onready var world: Node2D = $World

var current_level: Level

func _ready() -> void:
    world.scene_selected.connect(_on_scene_selected)

func _on_scene_selected(scene: PackedScene) -> void:
    world.visible = false
    current_level = scene.instantiate()
    current_level.won.connect(_on_won)
    current_level.lost.connect(_on_lost)
    add_child(current_level)

func _on_won() -> void:
    world.visible = true
    world.enable_next()
    current_level.queue_free()

func _on_lost() -> void:
    world.visible = true
    current_level.queue_free()
