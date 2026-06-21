@tool
class_name ComputerButton extends Node3D

signal clicked(code: String)

@export var code: String = ""
@export var texture: Texture:
    set(value):
        texture = value
        _setup()

@onready var sprite: Sprite3D = $Sprite3D

func _ready() -> void:
    _setup()

func _setup() -> void:
    if not is_node_ready():
        return
    
    sprite.texture = texture

func click() -> void:
    clicked.emit(code)
