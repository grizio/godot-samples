class_name Paddle extends CharacterBody2D

@export var speed: float = 300

func _physics_process(delta: float) -> void:
    if Input.is_action_pressed("ui_left"):
        move_and_collide(Vector2(-speed * delta, 0))
    elif Input.is_action_pressed("ui_right"):
        move_and_collide(Vector2(speed * delta, 0))