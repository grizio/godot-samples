class_name FireTrigger extends Node2D

@onready var timer: Timer = $Timer

func _ready() -> void:
    timer.timeout.connect(_on_timeout)


func _on_timeout() -> void:
    var balls = get_tree().get_nodes_in_group("ball")
    var random_ball = balls[randi() % balls.size()]
    random_ball.trigger_fire(10)