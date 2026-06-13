class_name Brick extends Node2D

@export var color: Color = Color.RED:
    set(value):
        color = value
        if is_node_ready():
            polygon.color = color
@export var life: int = 1

@onready var polygon: Polygon2D = $Polygon2D
@onready var life_label: Label = $LifeLabel

func _ready() -> void:
    polygon.color = color
    life_label.text = str(life)

func hit() -> void:
    life -= 1
    if life <= 0:
        queue_free()
    else:
        life_label.text = str(life)

func on_ball_collision(_ball: Ball) -> void:
    hit()