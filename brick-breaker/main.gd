extends Node2D

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
