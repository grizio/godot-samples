class_name Paddle extends CharacterBody2D

const initial_width: float = 256

signal ball_spawned(ball: Ball)

@export var speed: float = 300
@export var max_speed: float = 300
@export var width: float = initial_width:
    set(value):
        width = value
        _setup_width()
@export var variant: Constants.Variant = Constants.Variant.NORMAL:
    set(value):
        variant = value
        _setup_variant()

@onready var polygon: Polygon2D = $Polygon2D
@onready var shape: CapsuleShape2D = $CollisionShape2D.shape as CapsuleShape2D
@onready var initial_ball: Ball = $Ball
@onready var modifier_area: Area2D = $ModifierArea

var target_x: float = INF
var can_flow: bool = false

func _ready() -> void:
    _setup_width()
    _setup_variant()
    var max_shift = (shape.height * 0.8) / 2
    initial_ball.position.x = randf_range(-max_shift, max_shift)
    initial_ball.speed = 0
    can_flow = Data.is_power_enabled(Constants.power_flow)
    Data.power_added.connect(_on_power_added)
    modifier_area.body_entered.connect(_on_modifier_entered)

func _on_power_added(power: String) -> void:
    if power == Constants.power_flow:
        can_flow = true
        variant = Constants.Variant.FLOW

func _setup_variant() -> void:
    if polygon == null:
        return
    match variant:
        Constants.Variant.FLOW:
            polygon.color = Constants.color_light_green
        Constants.Variant.NORMAL:
            polygon.color = Constants.color_wheat

func _setup_width() -> void:
    if polygon == null:
        return
    
    print("setup width", width)
    polygon.polygon = [
        Vector2(- (width / 2 - 8), -8),
        Vector2(width / 2 - 8, -8),
        Vector2(width / 2 - 4, -7),
        Vector2(width / 2 - 1, -4),
        Vector2(width / 2, 0),
        Vector2(width / 2 - 1, 4),
        Vector2(width / 2 - 4, 7),
        Vector2(width / 2 - 8, 8),
        Vector2(- (width / 2 - 8), 8),
        Vector2(- (width / 2 - 4), 7),
        Vector2(- (width / 2 - 1), 4),
        Vector2(- (width / 2), 0),
        Vector2(- (width / 2 - 1), -4),
        Vector2(- (width / 2 - 4), -7),
    ]
    shape.height = width
    

func _physics_process(delta: float) -> void:
    if Input.is_action_pressed(Inputs.left):
        move_and_collide(Vector2(-speed * delta, 0))
    elif Input.is_action_pressed(Inputs.right):
        move_and_collide(Vector2(speed * delta, 0))
    elif target_x != INF:
        var distance = clamp(target_x - global_position.x, -max_speed * delta, max_speed * delta)
        move_and_collide(Vector2(distance, 0))

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        target_x = event.global_position.x
    elif event.is_action_pressed(Inputs.launch) and initial_ball != null:
        var current_ball_position = initial_ball.global_position
        remove_child(initial_ball)
        get_tree().get_first_node_in_group(Constants.group_level).add_child(initial_ball)
        initial_ball.global_position = current_ball_position
        ball_spawned.emit(initial_ball)
        initial_ball = null
    elif event.is_action_pressed(Inputs.change_variant):
        if can_flow:
            variant = (variant + 1) % Constants.Variant.size() as Constants.Variant
    elif event.is_action_pressed(Inputs.left) or event.is_action_pressed(Inputs.right):
        target_x = INF

func on_ball_collision(ball: Ball) -> void:
    var distance_from_center = abs(ball.global_position.x - global_position.x)
    var max_distance = width / 2
    
    var x = distance_from_center * 4 / max_distance

    ball.set_direction(Vector2(x * sign(ball.global_position.x - global_position.x), -1).normalized())
    ball.variant = variant

func _on_modifier_entered(modifier: Modifier) -> void:
    match modifier.action:
        Constants.modifier_grow:
            width *= 1.25
        Constants.modifier_shrink:
            width *= 0.75
    
    modifier.queue_free()
