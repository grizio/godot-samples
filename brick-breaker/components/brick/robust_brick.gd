class_name RobustBrick extends Brick


@onready var polygon: Polygon2D = $Polygon2D

var life: int = 2

func _ready() -> void:
    polygon.color = Color.BLACK

func on_hit(damage: int, _type: Constants.Variant) -> void:
    life -= damage
    match life:
        0:
            queue_free()
        1:
            polygon.color = Color.WHITE
        2:
            polygon.color = Color.BLACK
