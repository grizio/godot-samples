class_name Paddle extends CharacterBody2D

@export var speed: float = 300
@export var max_speed: float = 300
@export var variant: Constants.Variant = Constants.Variant.GREEN:
    set(value):
        variant = value
        if polygon != null:
            match value:
                Constants.Variant.RED:
                    polygon.color = Color.RED
                Constants.Variant.GREEN:
                    polygon.color = Color.GREEN

@onready var polygon: Polygon2D = $Polygon2D

var target_x: float = INF

func _physics_process(delta: float) -> void:
    if Input.is_action_pressed(Inputs.left):
        move_and_collide(Vector2(-speed * delta, 0))
    elif Input.is_action_pressed(Inputs.right):
        move_and_collide(Vector2(speed * delta, 0))
    elif target_x != INF:
        var distance = clamp(target_x - global_position.x, -max_speed * delta, max_speed * delta)
        move_and_collide(Vector2(distance, 0))

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        target_x = event.global_position.x
    elif event.is_action_pressed(Inputs.change_variant):
        variant = (variant + 1) % Constants.Variant.size() as Constants.Variant
    elif event.is_action_pressed(Inputs.left) or event.is_action_pressed(Inputs.right):
        target_x = INF

func on_ball_collision(ball: Ball) -> void:
    ball.set_direction((ball.global_position - global_position).normalized())
    ball.variant = variant
