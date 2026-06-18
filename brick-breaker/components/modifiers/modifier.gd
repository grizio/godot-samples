class_name Modifier extends AnimatableBody2D

const speed: float = 300

@export var action: String

func _process(delta: float) -> void:
    position.y += delta * speed
