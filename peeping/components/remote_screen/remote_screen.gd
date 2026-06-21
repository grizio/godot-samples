class_name RemoteScreen extends Node3D

@onready var sprite: Sprite3D = $Sprite3D

func _ready():
    Signals.remote_camera_added.connect(on_remote_camera_added)

func on_remote_camera_added(remote_camera: RemoteCamera):
    sprite.texture.viewport_path = get_path_to(remote_camera)
