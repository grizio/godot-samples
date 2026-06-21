class_name Player extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export_range(0.0, 1.0, 0.01) var rotation_speed: float = 0.15
@export var tilt_limit = deg_to_rad(75)

@onready var camera = %Camera3D
@onready var camera_pivot := %CameraPivot as Node3D

func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta

    # Handle jump.
    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
    var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    if direction:
        velocity.x = direction.x * SPEED
        velocity.z = direction.z * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
        velocity.z = move_toward(velocity.z, 0, SPEED)

    move_and_slide()

func _process(_delta: float) -> void:
    # Handle controller right stick camera look.
    var right_stick_x = - Input.get_axis("look_left", "look_right")
    var right_stick_y = Input.get_axis("look_up", "look_down")
    
    if abs(right_stick_x) > 0.1 or abs(right_stick_y) > 0.1:
        camera_pivot.rotation.x += right_stick_y * rotation_speed
        # Prevent the camera from rotating too far up or down.
        camera_pivot.rotation.x = clampf(camera_pivot.rotation.x, -tilt_limit, tilt_limit)
        rotation.y += right_stick_x * rotation_speed