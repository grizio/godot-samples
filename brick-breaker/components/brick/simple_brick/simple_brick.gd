class_name SimpleBrick extends Brick

func on_hit(_damage: int, type: Constants.Variant) -> void:
    if type == Constants.Variant.FLOW:
        return
    collision_layer = 0

    generate_modifier(0.1)

    var tween := create_tween()
    tween.tween_property(self , "modulate", Color(0, 0, 0, 1), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
    tween.tween_property(self , "modulate", Color(0, 0, 0, 0), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

    await tween.finished
    queue_free()