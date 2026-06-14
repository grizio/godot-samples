class_name SimpleBrick extends Brick

func on_ball_collision(_ball: Ball) -> void:
    queue_free()