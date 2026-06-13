class_name Paddle extends CharacterBody2D

@export var speed: float = 300
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


func _physics_process(delta: float) -> void:
    if Input.is_action_pressed(Inputs.left):
        move_and_collide(Vector2(-speed * delta, 0))
    elif Input.is_action_pressed(Inputs.right):
        move_and_collide(Vector2(speed * delta, 0))

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed(Inputs.change_variant):
        variant = (variant + 1) % Constants.Variant.size() as Constants.Variant

func on_ball_collision(ball: Ball) -> void:
    ball.set_direction((ball.global_position - global_position).normalized())
    ball.variant = variant