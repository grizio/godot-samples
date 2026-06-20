class_name CardUi extends Control

@export var card: Card:
    set(value):
        card = value
        _setup()
@export var face: Face = Face.BACK:
    set(value):
        face = value
        _setup()

enum Face {
    FRONT,
    BACK
}

@onready var front: Panel = $Front
@onready var back: TextureRect = $Back
@onready var title_label: Label = %Title
@onready var texture_rect: TextureRect = %Texture
@onready var description_text: RichTextLabel = %Description

func _ready() -> void:
    _setup()

func _setup() -> void:
    if not is_node_ready():
        return

    if card == null:
        visible = false
        title_label.text = ""
        texture_rect.texture = null
        description_text.text = ""
    else:
        visible = true
        title_label.text = card.title
        texture_rect.texture = card.texture
        description_text.text = card.description

    match face:
        Face.FRONT:
            front.visible = true
            back.visible = false
        Face.BACK:
            front.visible = false
            back.visible = true
