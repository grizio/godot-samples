class_name SimpleBrick extends Brick

func on_hit(_damage: int, _type: Constants.Variant) -> void:
    queue_free()