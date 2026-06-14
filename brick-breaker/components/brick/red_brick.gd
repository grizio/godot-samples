class_name RedBrick extends Brick

func on_ball_collision(ball: Ball) -> void:
    if ball.variant == Constants.Variant.RED:
        queue_free()
