class_name SimpleBrick extends StaticBody2D

func on_ball_collision(_ball: Ball) -> void:
    queue_free()