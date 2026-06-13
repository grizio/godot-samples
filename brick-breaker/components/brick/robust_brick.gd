class_name RobustBrick extends StaticBody2D


@onready var polygon: Polygon2D = $Polygon2D

var life: int = 2

func _ready() -> void:
    polygon.color = Color.BLACK

func hit() -> void:
    life -= 1
    match life:
        0:
            queue_free()
        1:
            polygon.color = Color.WHITE
        2:
            polygon.color = Color.BLACK

func on_ball_collision(_ball: Ball) -> void:
    hit()