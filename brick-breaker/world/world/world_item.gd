@tool
class_name WorldItem extends TextureButton

const item_disabled: Texture = preload("uid://blf1od0v3frxu")
const item_enabled: Texture = preload("uid://ba7qoq80nb3y2")
const item_won: Texture = preload("uid://cf5ji0xhknumg")

signal item_focused(item: WorldItem)
signal item_pressed(item: WorldItem)

@export var scene: PackedScene

@export_group("Navigation - auto-generated")
@export var up: WorldItem = null
@export var left: WorldItem = null
@export var right: WorldItem = null
@export var down: WorldItem = null

enum State {
    DISABLED,
    ENABLED,
    WON
}


func _ready() -> void:
    assert(scene != null, "scene must be set for " + name)

    var comment: Node2D = get_node_or_null("Comment")
    if comment != null:
        comment.notes = name

    _setup_state()

    pressed.connect(_on_pressed)
    focus_entered.connect(_on_focus_entered)

func _setup_state() -> void:
    var expected_texture: Texture
    if Engine.is_editor_hint() or Data.is_level_won(name):
        expected_texture = item_won
        disabled = false
    elif Data.is_level_enabled(name):
        expected_texture = item_enabled
        disabled = false
    else:
        expected_texture = item_disabled
        disabled = true
    
    texture_normal = expected_texture
    texture_pressed = expected_texture
    texture_hover = expected_texture
    texture_focused = expected_texture

func _on_pressed() -> void:
    item_pressed.emit(self)

func _on_focus_entered() -> void:
    item_focused.emit(self)

func enable() -> void:
    Data.enable_level(name)
    _setup_state()

func won() -> void:
    Data.won_level(name)

    if left != null:
        left.enable()
    if right != null:
        right.enable()
    if up != null:
        up.enable()
    if down != null:
        down.enable()
    
    _setup_state()
