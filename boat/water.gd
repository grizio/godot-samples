class_name Water extends MeshInstance3D

const speed: Vector3 = Vector3(0.1, 0.1, 1)

@onready var noise: FastNoiseLite = get_surface_override_material(0).roughness_texture.noise

func _process(delta: float) -> void:
    noise.offset = noise.offset + speed * delta
