class_name RobustBrick extends Brick


@onready var robust_brick: Sprite2D = $RobustBrick
@onready var robust_brick_break: Sprite2D = $RobustBrickBreak

var life: int = 2

func on_hit(damage: int, _type: Constants.Variant) -> void:
    life -= damage
    if life <= 0:
        collision_layer = 0

        var tween := create_tween()
        tween.tween_property(self , "modulate", Color(0, 0, 0, 1), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
        tween.tween_property(self , "modulate", Color(0, 0, 0, 0), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

        await tween.finished
        queue_free()
    elif life <= 1:
        robust_brick_break.visible = true
        robust_brick.visible = false
    else:
        robust_brick_break.visible = false
        robust_brick.visible = true
