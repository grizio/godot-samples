class_name BallGenerator extends Node2D

signal ball_spawned(ball: Ball)

const ball_scene: PackedScene = preload("uid://bscb3hpn6rys8")

@export_range(0, 60, 1, "suffix: s") var interval: float = 10:
    set(value):
        interval = value
        _setup()

@onready var timer: Timer = $Timer
@onready var processing_animation_player: AnimationPlayer = $ProcessingAnimationPlayer

func _ready() -> void:
    _setup()
    timer.timeout.connect(_on_timer_timeout)
    get_tree().get_first_node_in_group(Constants.group_level).started.connect(_on_level_started)
    get_tree().get_first_node_in_group(Constants.group_level).stopped.connect(_on_level_stopped)
    Data.power_added.connect(_on_power_added)

func _setup() -> void:
    visible = Data.is_power_enabled(Constants.power_ball_generator)
    
    if timer != null:
        timer.wait_time = interval
    if processing_animation_player != null:
        processing_animation_player.speed_scale = 1 / interval

func _on_level_started() -> void:
    if Data.is_power_enabled(Constants.power_ball_generator):
        _start()

func _start() -> void:
    timer.start()
    processing_animation_player.play("process")

func _on_level_stopped() -> void:
    timer.stop()
    processing_animation_player.stop()

func _on_timer_timeout() -> void:
    _next_ball()
    processing_animation_player.stop()
    processing_animation_player.play("process")

func _next_ball() -> void:
    var ball: Ball = ball_scene.instantiate()
    add_child(ball)
    ball.global_position = global_position
    ball.set_direction(Vector2(randi_range(-4, 4), -1))
    ball_spawned.emit(ball)

func _on_power_added(power: String) -> void:
    if power == Constants.power_ball_generator:
        visible = true
        _start()
