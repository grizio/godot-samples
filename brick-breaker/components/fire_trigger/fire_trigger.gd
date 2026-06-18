class_name FireTrigger extends Node2D

const FireBulletScene = preload("uid://srj5chqesqu")

@export_range(0, 60, 1, "suffix: s") var interval: float = 20:
    set(value):
        interval = value
        _setup()

@onready var timer: Timer = $Timer
@onready var processing_animation_player: AnimationPlayer = $ProcessingAnimationPlayer

func _ready() -> void:
    _setup()
    timer.timeout.connect(_on_timeout)
    get_tree().get_first_node_in_group(Constants.group_level).started.connect(_on_level_started)
    get_tree().get_first_node_in_group(Constants.group_level).stopped.connect(_on_level_stopped)
    Data.power_added.connect(_on_power_added)

func _setup() -> void:
    visible = Data.is_power_enabled(Constants.power_fire)
    
    if timer != null:
        timer.wait_time = interval
    if processing_animation_player != null:
        processing_animation_player.speed_scale = 1 / interval

func _on_level_started() -> void:
    if Data.is_power_enabled(Constants.power_fire):
        _start()

func _start() -> void:
    timer.start()
    processing_animation_player.play("process")

func _on_level_stopped() -> void:
    timer.stop()
    processing_animation_player.stop()

func _on_timeout() -> void:
    _next_fire_bullet()
    processing_animation_player.play("process")

func _next_fire_bullet() -> void:
    var balls = get_tree().get_nodes_in_group("ball")
    var random_ball = balls[randi() % balls.size()]
    var fire_bullet = FireBulletScene.instantiate()
    fire_bullet.target = random_ball
    add_child(fire_bullet)

func _on_power_added(power: String) -> void:
    if power == Constants.power_fire:
        visible = true
        _start()
        # first time: trigger immediately
        _next_fire_bullet()
