class_name Fishing extends CanvasLayer

signal won()
signal lost()

@export var fishing_scene: PackedScene

@onready var fishing_container: PanelContainer = %FishingContainer

func _ready() -> void:
    var scene = fishing_scene.instantiate()
    scene.won.connect(won.emit)
    scene.lost.connect(lost.emit)
    fishing_container.add_child(scene)
