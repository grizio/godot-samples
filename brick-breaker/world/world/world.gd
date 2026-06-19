class_name World extends Node2D

signal scene_selected(scene: PackedScene)

@onready var camera: Camera2D = $Camera2D
@onready var hud: CanvasLayer = $Hud

var selected_item: WorldItem

func _ready() -> void:
    _setup_navigation()

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
    selected_item.won()

func _setup_navigation() -> void:
    var map: Dictionary = {}
    for child in get_children():
        if child is WorldItem:
            map[child.global_position] = child
    
    for child in get_children():
        if child is WorldItem:
            var pos = child.global_position
            if map.has(pos + Vector2(0, -128)):
                child.up = map[pos + Vector2(0, -128)]
            
            if map.has(pos + Vector2(0, 128)):
                child.down = map[pos + Vector2(0, 128)]
            
            if map.has(pos + Vector2(-128, 0)):
                child.left = map[pos + Vector2(-128, 0)]
            
            if map.has(pos + Vector2(128, 0)):
                child.right = map[pos + Vector2(128, 0)]
