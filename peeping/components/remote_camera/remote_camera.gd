class_name RemoteCamera extends SubViewport

@onready var camera: Camera3D = $Camera3D

func _ready():
    Signals.remote_camera_added.connect(on_remote_camera_added)

    Signals.remote_camera_added.emit(self)


func on_remote_camera_added(remote_camera: RemoteCamera):
    if remote_camera != self:
        queue_free()