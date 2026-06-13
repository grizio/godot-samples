class_name Paddle extends CharacterBody2D

@export var speed: float = 300

func _physics_process(delta: float) -> void:
    if Input.is_action_pressed("ui_left"):
        move_and_collide(Vector2(-speed * delta, 0))
    elif Input.is_action_pressed("ui_right"):
        move_and_collide(Vector2(speed * delta, 0))

func on_ball_collision(ball: Ball) -> void:
    ball.set_direction((ball.global_position - global_position).normalized())