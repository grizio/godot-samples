class_name CardTile extends Control

const max_rotation = PI / 16

@export var card: Card:
    set(value):
        card = value
        _setup()
@export var index: int = 0:
    set(value):
        index = value
        _setup()
@export var max_index: int = 0:
    set(value):
        max_index = value
        _setup()

@onready var container: Panel = $CardTile
@onready var title_label: Label = %Title
@onready var texture_rect: TextureRect = %Texture
@onready var description_text: RichTextLabel = %Description
@onready var minimum_size = custom_minimum_size.x

var tween: Tween = null

func _ready():
    _setup()
    container.mouse_entered.connect(_on_mouse_entered)
    container.mouse_exited.connect(_on_mouse_exited)

func _setup() -> void:
    if texture_rect == null:
        return
    
    if card == null:
        title_label.text = ""
        texture_rect.texture = null
        description_text.text = ""
    else:
        title_label.text = card.title
        texture_rect.texture = card.texture
        description_text.text = card.description
    
    if index == 0:
        container.offset_transform_rotation = 0.0
        container.offset_transform_position.y = 0
    elif index > 0:
        container.offset_transform_rotation = index * max_rotation / max_index
        container.offset_transform_position.y = index * 10
    else:
        container.offset_transform_rotation = - (-index * max_rotation / max_index)
        container.offset_transform_position.y = - index * 10

func _on_mouse_entered() -> void:
    z_index = 1
    
    if tween != null and tween.is_running():
        tween.kill()
    
    tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
    tween.set_parallel(true)
    tween.tween_property(container, "offset_transform_scale", Vector2(1.5, 1.5), 0.2)
    tween.tween_property(container, "offset_transform_rotation", 0, 0.2)
    tween.tween_property(container, "offset_transform_position:y", 0, 0.2)
    tween.tween_property(self, "custom_minimum_size:x", 256, 0.2)

func _on_mouse_exited() -> void:
    z_index = 0
    
    if tween != null and tween.is_running():
        tween.kill()
    
    tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
    tween.set_parallel(true)
    tween.tween_property(container, "offset_transform_scale", Vector2(1, 1), 0.2)
    tween.tween_property(container, "offset_transform_rotation", index * max_rotation / max_index, 0.2)
    tween.tween_property(container, "offset_transform_position:y", abs(index) * 10, 0.2)
    tween.tween_property(self, "custom_minimum_size:x", minimum_size, 0.2)
