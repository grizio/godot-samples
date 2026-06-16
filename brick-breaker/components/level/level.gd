class_name Level extends Node2D

signal lost()
signal won()

@export var bricks: Bricks
@export_range(0, 2000, 1, "suffix: px/s") var ball_speed: float = 400
@export_range(0, 2000, 1, "prefix:+", "suffix: px/minute") var ball_acceleration: float = 200

@onready var paddle: Paddle = %Paddle
@onready var ball_generator: BallGenerator = $BallGenerator
@onready var acceleration_timer: Timer = $AccelerationTimer

var balls: Array[Ball] = []
var was_lost: bool = false

func _ready() -> void:
    bricks.total_bricks_changed.connect(_on_total_bricks_changed)
    acceleration_timer.timeout.connect(_on_acceleration_timer_timeout)
    ball_generator.ball_spawned.connect(_on_ball_spawned)

func _on_ball_died(ball) -> void:
    balls.erase(ball)
    if balls.size() == 0:
        was_lost = true
        lost.emit()

func _on_total_bricks_changed(total_bricks: int) -> void:
    if total_bricks == 0 and not was_lost:
        won.emit()

func _on_acceleration_timer_timeout() -> void:
    ball_speed += ball_acceleration * (acceleration_timer.wait_time / 60)
    for ball in balls:
        ball.speed = ball_speed

func _on_ball_spawned(ball: Ball) -> void:
    balls.append(ball)
    ball.speed = ball_speed
    ball.died.connect(_on_ball_died)
