class_name BallGenerator extends Node2D

signal ball_spawned(ball: Ball)

const ball_scene: PackedScene = preload("uid://bscb3hpn6rys8")

@export_range(0, 60, 1, "suffix: s") var interval: float = 10:
    set(value):
        interval = value
        if timer != null:
            timer.wait_time = value

@onready var timer: Timer = $Timer

func _ready() -> void:
    timer.wait_time = interval
    timer.timeout.connect(_on_timer_timeout)
    get_tree().get_first_node_in_group(Constants.group_level).started.connect(_on_level_started)
    get_tree().get_first_node_in_group(Constants.group_level).stopped.connect(_on_level_stopped)

func _on_level_started() -> void:
    timer.start()

func _on_level_stopped() -> void:
    timer.stop()

func _on_timer_timeout() -> void:
    _next_ball()

func _next_ball() -> void:
    var ball: Ball = ball_scene.instantiate()
    add_child(ball)
    ball.global_position = global_position
    ball.set_direction(Vector2(randi_range(-4, 4), -1))
    ball_spawned.emit(ball)
