class_name Drawer extends VBoxContainer

signal pressed()

const CardUiScene = preload("res://card_tile/card_ui.tscn")

@export var cards: Array[Card]:
    set(value):
        cards = value
        _setup()

func _ready() -> void:
    _setup()
    gui_input.connect(_on_gui_input)

func _setup() -> void:
    if not is_node_ready():
        return

    while get_child_count() > 0:
        remove_child(get_child(0))
    
    for i in range(cards.size()):
        var control = Control.new()
        control.mouse_filter = Control.MOUSE_FILTER_PASS
        add_child(control)
        var card_ui = CardUiScene.instantiate()
        card_ui.card = cards[i]
        control.add_child(card_ui)

func draw() -> Card:
    if cards.size() == 0:
        return null

    var card = cards.pop_front()
    remove_child(get_child(0))
    
    return card

func _on_gui_input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT:
            if event.pressed:
                pressed.emit()