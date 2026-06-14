class_name RedBrick extends Brick

func on_hit(_damage: int, _type: Constants.Variant) -> void:
    if _type == Constants.Variant.RED:
        queue_free()
