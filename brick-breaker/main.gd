extends Node2D

const ball_scene: PackedScene = preload("uid://bscb3hpn6rys8")

var balls: int = 0

@onready var ball_generation_timer: Timer = $BallGenerationTimer
@onready var paddle: Paddle = %Paddle

func _ready() -> void:
    _setup_ball(self )
    ball_generation_timer.timeout.connect(_on_ball_generation_timer_timeout)

func _setup_ball(node: Node) -> void:
    if node is Ball:
        balls += 1
        node.died.connect(_on_ball_died)
    
    for child in node.get_children():
        _setup_ball(child)

func _on_ball_died() -> void:
    balls -= 1
    if balls <= 0:
        print("Game over")

func _on_ball_generation_timer_timeout() -> void:
    var ball: Ball = ball_scene.instantiate()
    ball.global_position = paddle.global_position - Vector2(0, 24)
    ball.set_direction(Vector2(0, -1))
    ball.died.connect(_on_ball_died)
    balls += 1
    add_child(ball)
