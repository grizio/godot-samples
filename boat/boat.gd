class_name Boat extends Node3D

const speed = 10
const rotation_speed = 1

signal fishing_pool_entered()
signal fishing_pool_exited()

@onready var fishing_pool_detector: Area3D = $FishingPoolDetector

func _ready():
    fishing_pool_detector.area_entered.connect(func (_x): fishing_pool_entered.emit())
    fishing_pool_detector.area_exited.connect(func (_x): fishing_pool_exited.emit())

func is_on_fishing_pool() -> bool:
    return fishing_pool_detector.has_overlapping_areas()

func get_fishing_pool() -> FishingPool:
    return fishing_pool_detector.get_overlapping_areas()[0].get_parent()

func _process(delta: float) -> void:
    if Input.is_action_pressed("ui_left"):
        rotation.y += rotation_speed * delta

    if Input.is_action_pressed("ui_right"):
        rotation.y -= rotation_speed * delta

    if Input.is_action_pressed("ui_up"):
        position.x += speed * delta * sin(rotation.y)
        position.z += speed * delta * cos(rotation.y)

    if Input.is_action_pressed("ui_down"):
        position.x -= speed * delta * sin(rotation.y)
        position.z -= speed * delta * cos(rotation.y)
