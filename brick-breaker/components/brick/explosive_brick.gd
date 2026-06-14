class_name ExplosiveBrick extends Brick

@onready var polygon_border: Polygon2D = $PolygonBorder
@onready var explosion_area: Area2D = $ExplosionArea

func on_hit(_damage: int, _type: Constants.Variant) -> void:
    polygon_border.color = Color.RED
    
    await get_tree().create_timer(1).timeout

    for body in explosion_area.get_overlapping_bodies():
        if body.has_method("on_hit"):
            body.on_hit(1, Constants.Variant.WHITE)
    
    queue_free()
