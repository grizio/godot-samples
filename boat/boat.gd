class_name Boat extends Node3D

const speed = 10
const rotation_speed = 1

func _process(delta: float) -> void:
    if Input.is_action_pressed("ui_left"):
        rotation.y += rotation_speed * delta
    
    if Input.is_action_pressed("ui_right"):
        rotation.y -= rotation_speed * delta
    
    if Input.is_action_pressed("ui_up"):
        position.x += speed * delta * sin(rotation.y)
        position.z += speed * delta * cos(rotation.y)
    
    if Input.is_action_pressed("ui_down"):
        position.x -= speed * delta * sin(rotation.y)
        position.z -= speed * delta * cos(rotation.y)
