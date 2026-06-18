class_name FireBullet extends Node2D


@export var target: Ball
@export var speed: float = 2400
@export var fire_duration: float = 10

func _process(delta: float) -> void:
    global_position = global_position.move_toward(target.global_position, speed * delta)
    if global_position.distance_squared_to(target.global_position) < 10:
        target.trigger_fire(fire_duration)
        queue_free()