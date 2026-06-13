class_name RedBrick extends StaticBody2D

@export var life: int = 1

@onready var life_label: Label = $LifeLabel

func _ready() -> void:
    life_label.text = str(life)

func hit() -> void:
    life -= 1
    if life <= 0:
        queue_free()
    else:
        life_label.text = str(life)

func on_ball_collision(ball: Ball) -> void:
    if ball.variant == Constants.Variant.RED:
        hit()
