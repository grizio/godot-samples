@tool
class_name Circle extends Node2D

const segments = 32

@export var radius: float = 128:
    set(value):
        radius = value
        queue_redraw()
@export_range(0, 360, 0.1, "radians_as_degrees") var start: float = 0:
    set(value):
        start = value
        queue_redraw()
@export_range(0, 360, 0.1, "radians_as_degrees") var end: float = 2 * PI:
    set(value):
        end = value
        queue_redraw()
@export var primary_color: Color = Color.WHITE:
    set(value):
        primary_color = value
        queue_redraw()
@export var secondary_color: Color = Color.BLACK:
    set(value):
        secondary_color = value
        queue_redraw()

func _draw() -> void:
    draw_circle(Vector2.ZERO, radius, secondary_color, true, true)

    var points: PackedVector2Array = []

    # Center of the fan
    points.append(Vector2.ZERO)

    for i in range(segments + 1):
        var t = float(i) / segments
        var angle = lerp(start, end, t)
        points.append(Vector2(cos(angle), sin(angle)) * radius)

    draw_colored_polygon(points, primary_color)
