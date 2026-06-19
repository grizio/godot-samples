class_name Level extends Node2D

const paddle_scene: PackedScene = preload("uid://dnok4dpadxev")

signal started()
signal stopped()
signal lost()
signal won()

@export_range(0, 2000, 1, "suffix: px/s") var ball_speed: float = 400
@export_range(0, 2000, 1, "prefix:+", "suffix: px/minute") var ball_acceleration: float = 200

@onready var bricks: Bricks = $Bricks
@onready var paddle: Paddle = %Paddle
@onready var ball_generator: BallGenerator = $BallGenerator
@onready var acceleration_timer: Timer = $AccelerationTimer

@onready var life1: Sprite2D = $CanvasLayer/Life1
@onready var life2: Sprite2D = $CanvasLayer/Life2
@onready var life3: Sprite2D = $CanvasLayer/Life3

@onready var initial_paddle_position: Vector2 = paddle.global_position
@onready var initial_paddle_speed: float = paddle.speed
@onready var initial_paddle_max_speed: float = paddle.max_speed

var balls: Array[Ball] = []
var was_lost: bool = false
var lives: int = 2

func _ready() -> void:
    bricks.total_bricks_changed.connect(_on_total_bricks_changed)
    acceleration_timer.timeout.connect(_on_acceleration_timer_timeout)
    ball_generator.ball_spawned.connect(_on_ball_spawned)
    paddle.ball_spawned.connect(_on_paddle_ball_spawned)
    _setup_lives()

func _on_ball_died(ball) -> void:
    balls.erase(ball)
    if balls.size() == 0:
        lives -= 1
        _setup_lives()
        stopped.emit()
        if lives == 0:
            was_lost = true
            lost.emit()
        else:
            var out_tween := create_tween()
            out_tween.tween_property(paddle, "global_position:y", 1120, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
            await out_tween.finished
    
            paddle.queue_free()
            paddle = paddle_scene.instantiate()
            call_deferred("add_child", paddle)
            paddle.global_position = Vector2(initial_paddle_position.x, 1120)
            paddle.speed = initial_paddle_speed
            paddle.max_speed = initial_paddle_max_speed
            paddle.ball_spawned.connect(_on_paddle_ball_spawned)
            
            var in_tween := create_tween()
            in_tween.tween_property(paddle, "global_position:y", initial_paddle_position.y, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
            await in_tween.finished

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

func _on_paddle_ball_spawned(ball: Ball) -> void:
    _on_ball_spawned(ball)
    started.emit()

func _setup_lives() -> void:
    life1.visible = lives >= 1
    life2.visible = lives >= 2
    life3.visible = lives >= 3
