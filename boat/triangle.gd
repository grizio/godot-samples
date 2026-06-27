@tool
class_name Triangle extends Node2D

@export var width: float = 128:
    set(value):
        width = value
        queue_redraw()
@export var height: float = 128:
    set(value):
        height = value
        queue_redraw()
@export var color: Color = Color.WHITE:
    set(value):
        color = value
        queue_redraw()

func _draw() -> void:
    draw_colored_polygon([
        Vector2(-width / 2, 0),
        Vector2(width /2, 0),
        Vector2(0, -height),
    ], color)
