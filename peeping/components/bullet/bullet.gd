class_name Bullet extends AnimatableBody3D

const RemoteCameraScene = preload("res://components/remote_camera/remote_camera.tscn")

@export var direction: Vector3 = Vector3.ZERO
@export var speed: float = 10
@export var lifetime: float = 10

func setup(initial_global_position: Vector3, initial_direction: Vector3) -> void:
    direction = initial_direction.normalized()
    transform.origin = initial_global_position + direction

func _physics_process(delta: float) -> void:
    lifetime -= delta
    if lifetime <= 0:
        queue_free()
        return
    
    var motion = direction.normalized() * speed * delta
    var collision = move_and_collide(motion)
    if collision:
        var remote_camera = RemoteCameraScene.instantiate()
        get_tree().current_scene.add_child(remote_camera)
        remote_camera.camera.transform.origin = collision.get_position()
        remote_camera.camera.look_at(collision.get_position() + collision.get_normal(), Vector3.UP)
        queue_free()
