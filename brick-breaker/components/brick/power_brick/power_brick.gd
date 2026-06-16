class_name PowerBrick extends Brick

@export var power: String = ""

func _ready() -> void:
    assert(power != "", "power must be set")

    if Data.is_power_enabled(power):
        queue_free()

func on_hit(_damage: int, type: Constants.Variant) -> void:
    if type == Constants.Variant.FLOW:
        return
    
    Data.enable_power(power)

    collision_layer = 0

    var tween := create_tween()
    tween.tween_property(self , "modulate", Color(0, 0, 0, 1), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
    tween.tween_property(self , "modulate", Color(0, 0, 0, 0), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

    await tween.finished
    queue_free()