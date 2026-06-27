class_name FishingPool extends Node3D

@export var fishing_scenes: Array[PackedScene]

func _ready():
    if fishing_scenes.size() == 0:
        queue_free()

func start() -> PackedScene:
    var scene = fishing_scenes.pop_front()

    if fishing_scenes.size() == 0:
        queue_free()

    return scene
