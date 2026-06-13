class_name RedBrick extends StaticBody2D

func on_ball_collision(ball: Ball) -> void:
    if ball.variant == Constants.Variant.RED:
        queue_free()
