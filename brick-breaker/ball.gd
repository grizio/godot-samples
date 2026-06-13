class_name Ball extends CharacterBody2D

@export var speed: float = 1000
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
