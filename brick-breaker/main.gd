extends Node2D

const ball_scene: PackedScene = preload("uid://bscb3hpn6rys8")

@export var ball_speed: float = 400
@export_range(0, 2000, 1, "suffix: px/minute") var ball_acceleration: float = 200

var balls: Array[Ball] = []

@onready var game: Node2D = $Game
@onready var ball_generation_timer: Timer = $Game/BallGenerationTimer
@onready var paddle: Paddle = %Paddle
@onready var game_over: GameOver = $GameOver
@onready var win: Win = $Win
@onready var acceleration_timer: Timer = $AccelerationTimer
@onready var bricks: Bricks = %Bricks

func _ready() -> void:
    _setup_ball(self )
    ball_generation_timer.timeout.connect(_on_ball_generation_timer_timeout)
    acceleration_timer.timeout.connect(_on_acceleration_timer_timeout)
    bricks.total_bricks_changed.connect(_on_total_bricks_changed)

func _setup_ball(node: Node) -> void:
    if node is Ball:
        node.speed = ball_speed
        balls.append(node)
        node.died.connect(_on_ball_died)
    
    for child in node.get_children():
        _setup_ball(child)

func _on_ball_died(ball) -> void:
    balls.erase(ball)
    if balls.size() == 0:
        _on_game_over()

func _on_ball_generation_timer_timeout() -> void:
    var ball: Ball = ball_scene.instantiate()
    ball.global_position = paddle.global_position - Vector2(0, 24)
    ball.set_direction(Vector2(0, -1))
    ball.died.connect(_on_ball_died)
    balls.append(ball)
    add_child(ball)

func _on_game_over() -> void:
    game_over.visible = true
    get_tree().paused = true

func _on_win() -> void:
    win.visible = true
    get_tree().paused = true

func _on_acceleration_timer_timeout() -> void:
    ball_speed += ball_acceleration * (acceleration_timer.wait_time / 60)
    for ball in balls:
        ball.speed = ball_speed

func _on_total_bricks_changed(total_bricks: int) -> void:
    if total_bricks == 0:
        _on_win()
