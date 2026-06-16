class_name World extends Node2D

signal scene_selected(scene: PackedScene)

@onready var camera: Camera2D = $Camera2D
@onready var hud: CanvasLayer = $Hud

var selected_item: WorldItem

func _ready() -> void:
    for child in get_children():
        if child is WorldItem:
            child.item_focused.connect(_on_item_focused)
            child.item_pressed.connect(_on_item_pressed)
    
    visibility_changed.connect(_on_visibility_changed)
    _on_visibility_changed()

func _on_item_focused(world_item: WorldItem) -> void:
    camera.global_position = world_item.global_position

func _on_item_pressed(item: WorldItem) -> void:
    selected_item = item
    scene_selected.emit(item.scene)

func _on_visibility_changed() -> void:
    if visible:
        camera.enabled = true
        for child in get_children():
            if child is WorldItem:
                child.grab_focus()
                return
    else:
        camera.enabled = false
    
    hud.visible = visible

func enable_next() -> void:
    selected_item.enable_next()