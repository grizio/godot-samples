@tool
class_name WorldItem extends Button

signal item_focused(item: WorldItem)
signal item_pressed(item: WorldItem)

@export var id: String = ""
@export var scene: PackedScene
@export var label: String = "":
    set(value):
        label = value
        text = value

@export var up: WorldItem = null
@export var left: WorldItem = null
@export var right: WorldItem = null
@export var down: WorldItem = null

func _ready() -> void:
    text = label
    pressed.connect(_on_pressed)
    focus_entered.connect(_on_focus_entered)

    assert(id != "", "id must be set")
    disabled = not Data.is_level_enabled(id)

func _on_pressed() -> void:
    item_pressed.emit(self )

func _on_focus_entered() -> void:
    item_focused.emit(self )

func _input(event: InputEvent) -> void:
    if not is_visible_in_tree():
        release_focus()
        return

    if event.is_action_pressed(Inputs.left):
        if left != null && not left.disabled:
            left.grab_focus()
    elif event.is_action_pressed(Inputs.right):
        if right != null && not right.disabled:
            right.grab_focus()
    elif event.is_action_pressed(Inputs.up):
        if up != null && not up.disabled:
            up.grab_focus()
    elif event.is_action_pressed(Inputs.down):
        if down != null && not down.disabled:
            down.grab_focus()

func enable() -> void:
    disabled = false
    Data.enable_level(id)

func enable_next() -> void:
    if left != null:
        left.enable()
    if right != null:
        right.enable()
    if up != null:
        up.enable()
    if down != null:
        down.enable()