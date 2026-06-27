class_name Fishing1 extends Node2D

signal won()
signal lost()

@export_range(0, 1, 0.01) var ratio: float = 0.25
@export_range(0, 720, 0.1, "radians_as_degrees") var speed: float = PI

@onready var _circle: Circle = $Circle

func _ready() -> void:
    _circle.start = - PI  * ratio
    _circle.end = PI  * ratio
    _circle.rotation = randf_range(0, 2 * PI)


func _process(delta: float) -> void:
    _circle.rotate(speed * delta)

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("fish"):
        if _has_won():
            won.emit()
        else:
            lost.emit()

func _has_won() -> bool:
    var diff = angle_difference(0, _circle.rotation)
    if abs(diff) < PI * ratio:
        return true
    else:
        return false
