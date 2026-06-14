class_name Level extends Node2D

const ball_scene: PackedScene = preload("uid://bscb3hpn6rys8")

signal lost()
signal won()

@export var bricks: Bricks
@export_range(0, 2000, 1, "suffix: px/s") var ball_speed: float = 400
@export_range(0, 2000, 1, "prefix:+", "suffix: px/minute") var ball_acceleration: float = 200
@export_range(0, 60, 1, "suffix: s") var ball_generation_interval: float = 10

@onready var paddle: Paddle = %Paddle
@onready var ball_generation_timer: Timer = $BallGenerationTimer
@onready var acceleration_timer: Timer = $AccelerationTimer

var balls: Array[Ball] = []

func _ready() -> void:
    _next_ball()

    bricks.total_bricks_changed.connect(_on_total_bricks_changed)
    ball_generation_timer.timeout.connect(_on_ball_generation_timer_timeout)
    acceleration_timer.timeout.connect(_on_acceleration_timer_timeout)

func _next_ball() -> void:
    var ball: Ball = ball_scene.instantiate()
    ball.global_position = paddle.global_position - Vector2(randi_range(-12, 12), 24)
    ball.set_direction(Vector2(0, -1))
    ball.died.connect(_on_ball_died)
    ball.speed = ball_speed
    balls.append(ball)
    add_child(ball)

func _on_ball_died(ball) -> void:
    balls.erase(ball)
    if balls.size() == 0:
        lost.emit()

func _on_total_bricks_changed(total_bricks: int) -> void:
    if total_bricks == 0:
        won.emit()

func _on_ball_generation_timer_timeout() -> void:
    _next_ball()

func _on_acceleration_timer_timeout() -> void:
    ball_speed += ball_acceleration * (acceleration_timer.wait_time / 60)
    for ball in balls:
        ball.speed = ball_speed
