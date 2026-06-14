class_name Ball extends CharacterBody2D

signal died(ball: Ball)

@export var speed: float = 1000
@export var variant: Constants.Variant = Constants.Variant.WHITE:
    set(value):
        variant = value
        if hitbox != null:
            hitbox.damage_type = value
        if polygon != null:
            match value:
                Constants.Variant.RED:
                    polygon.color = Color.RED
                Constants.Variant.WHITE:
                    polygon.color = Color.WHITE

@onready var polygon: Polygon2D = $Polygon2D
@onready var hitbox: Hitbox = $Hitbox
@onready var fire_particles: GPUParticles2D = $FireParticles

var angle: Vector2 = Vector2.ONE

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
    set_collision_mask_value(Constants.collision_brick, false)

    await get_tree().create_timer(duration).timeout
    set_collision_mask_value(Constants.collision_brick, true)
    fire_particles.emitting = false
