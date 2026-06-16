class_name RobustBrick extends Brick


@onready var robust_brick: Sprite2D = $RobustBrick
@onready var robust_brick_break: Sprite2D = $RobustBrickBreak

var life: int = 2

func on_hit(damage: int, type: Constants.Variant) -> void:
    if type == Constants.Variant.FLOW:
        return
    
    life -= damage
    if life <= 0:
        collision_layer = 0

        var tween := create_tween()
        tween.tween_property(self , "modulate", Color(0, 0, 0, 1), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
        tween.tween_property(self , "modulate", Color(0, 0, 0, 0), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

        await tween.finished
        queue_free()
    elif life == 1:
        var first_tween := create_tween()
        first_tween.tween_property(self , "modulate", Color.BLACK, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
        await first_tween.finished

        robust_brick_break.visible = true
        robust_brick.visible = false

        var second_tween := create_tween()
        second_tween.tween_property(self , "modulate", Color.WHITE, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
        await second_tween.finished
    else:
        robust_brick_break.visible = false
        robust_brick.visible = true
