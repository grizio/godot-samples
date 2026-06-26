class_name Water extends MeshInstance3D

const normal_speed: Vector3 = Vector3(1, 1, 2)
const bent_speed: Vector3 = Vector3(-1, -1, 2)

@onready var normal_noise: FastNoiseLite = get_surface_override_material(0).normal_texture.noise
@onready var bent_noise: FastNoiseLite = get_surface_override_material(0).bent_normal_texture.noise

func _process(delta: float) -> void:
    normal_noise.offset = normal_noise.offset + normal_speed * delta
    bent_noise.offset = bent_noise.offset + bent_speed * delta
