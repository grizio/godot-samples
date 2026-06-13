class_name Brick extends Node2D

@export var color: Color = Color.RED:
    set(value):
        color = value
        if is_node_ready():
            polygon.color = color

@onready var polygon: Polygon2D = $Polygon2D

func hit() -> void:
    queue_free()