class_name FireTrigger extends Node2D

@onready var timer: Timer = $Timer

func _ready() -> void:
    timer.timeout.connect(_on_timeout)
    get_tree().get_first_node_in_group(Constants.group_level).started.connect(_on_level_started)

func _on_level_started() -> void:
    timer.start()


func _on_timeout() -> void:
    var balls = get_tree().get_nodes_in_group("ball")
    var random_ball = balls[randi() % balls.size()]
    random_ball.trigger_fire(10)