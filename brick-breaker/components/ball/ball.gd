class_name Ball extends CharacterBody2D

signal died(ball: Ball)

@export var damage: int = 1:
    set(value):
        damage = value
        _setup_damage()
@export var speed: float = 1000
@export var variant: Constants.Variant = Constants.Variant.NORMAL:
    set(value):
        variant = value
        _setup_variant()

@onready var hitbox: Hitbox = $Hitbox
@onready var ball_sprite: Sprite2D = $BallSprite
@onready var flow_sprite: Sprite2D = $FlowSprite
@onready var fire_sprite: Sprite2D = $FireSprite
@onready var fire_particles: GPUParticles2D = $FireParticles

var angle: Vector2 = Vector2.ONE

func _ready() -> void:
    if Data.is_power_enabled(Constants.power_ball_power_up_1):
        damage += 1
    
    Data.power_added.connect(_on_power_added)
    _setup_damage()
    _setup_variant()

func _setup_damage() -> void:
    if hitbox != null:
        hitbox.damage = damage

func _setup_variant() -> void:
    if hitbox != null:
        hitbox.damage_type = variant
    if flow_sprite != null and ball_sprite != null:
        match variant:
            Constants.Variant.FLOW:
                flow_sprite.visible = true
                ball_sprite.visible = false
            Constants.Variant.NORMAL:
                flow_sprite.visible = false
                ball_sprite.visible = true

func _on_power_added(power: String) -> void:
    if power == Constants.power_ball_power_up_1:
        damage += 1

func bounce(normal: Vector2) -> void:
    angle = angle.bounce(normal)

func set_direction(direction: Vector2) -> void:
    angle = direction.normalized()

func _physics_process(delta: float) -> void:
    var kinematic_collision = move_and_collide(angle * speed * delta)
    if kinematic_collision != null:
        bounce(kinematic_collision.get_normal())

        var collider = kinematic_collision.get_collider()
        if collider != null and collider.has_method("on_ball_collision"):
            collider.on_ball_collision(self )

func on_hit(_damage: int, _type: Constants.Variant) -> void:
    died.emit(self )

func trigger_fire(duration: float) -> void:
    if fire_particles.emitting:
        return
    
    fire_particles.emitting = true
    fire_sprite.visible = true
    set_collision_mask_value(Constants.collision_brick, false)

    await get_tree().create_timer(duration).timeout
    set_collision_mask_value(Constants.collision_brick, true)
    fire_sprite.visible = false
    fire_particles.emitting = false
