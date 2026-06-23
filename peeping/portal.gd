extends Node3D

@onready var portal_input_mesh: MeshInstance3D = %PortalInputMesh
@onready var portal_output_mesh: MeshInstance3D = %PortalOutputMesh
@onready var portal_camera: Camera3D = %PortalCamera

func _process(_delta: float) -> void:
    var player_camera = get_viewport().get_camera_3d()

    var player_transform = player_camera.global_transform

    var local_transform = portal_input_mesh.global_transform.affine_inverse() * player_transform

    var flip = Transform3D(
        Basis(Vector3.UP, PI),
        Vector3.ZERO
    )

    portal_camera.global_transform = portal_output_mesh.global_transform * flip * local_transform

    portal_camera.fov = player_camera.fov
