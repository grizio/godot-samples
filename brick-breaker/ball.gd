class_name Ball extends CharacterBody2D

@export var speed: float = 1000
var angle: Vector2 = Vector2.ONE

func _physics_process(delta: float) -> void:
    var motion: Vector2 = Vector2.ONE * angle * speed * delta
    var kinematic_collision = move_and_collide(motion, true)
    if kinematic_collision != null:
        var collider = kinematic_collision.get_collider()
        if collider is Paddle:
            var next_angle: Vector2 = kinematic_collision.get_collider().global_position - global_position
            angle = next_angle.normalized() * -1
        elif collider is Brick:
            var normal: Vector2 = kinematic_collision.get_normal()
            angle = angle.bounce(normal)

            collider.hit()
        else:
            var normal: Vector2 = kinematic_collision.get_normal()
            angle = angle.bounce(normal)
    
    motion = Vector2.ONE * angle * speed * delta
    move_and_collide(motion, false)
