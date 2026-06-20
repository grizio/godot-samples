extends Control

const CardUiScene = preload("res://card_tile/card_ui.tscn")
const CardTileScene = preload("res://card_tile/card_tile.tscn")

const card_move_speed = 5000

@onready var cards: Cards = $Cards
@onready var drawer: Drawer = $Drawer

var move_state: MoveState = MoveState.NONE
var moving_card: CardUi = null
var created_card_tile: CardTile = null

enum MoveState {
    NONE,
    MOVING,
    FLIPPING
}

var all_cards: Array[Card] = [
    preload("res://cards/card1.tres"),
    preload("res://cards/card2.tres"),
    preload("res://cards/card3.tres"),
    preload("res://cards/card4.tres"),
    preload("res://cards/card5.tres"),
    preload("res://cards/card6.tres"),
    preload("res://cards/card7.tres"),
    preload("res://cards/card8.tres"),
    preload("res://cards/card9.tres"),
    preload("res://cards/card10.tres"),
    preload("res://cards/card11.tres"),
    preload("res://cards/card12.tres"),
    preload("res://cards/card13.tres"),
    preload("res://cards/card14.tres"),
    preload("res://cards/card15.tres"),
    preload("res://cards/card16.tres"),
    preload("res://cards/card17.tres"),
    preload("res://cards/card18.tres"),
    preload("res://cards/card19.tres"),
    preload("res://cards/card20.tres"),
]

func _ready() -> void:
    var drawer_cards = all_cards.duplicate()
    drawer_cards.shuffle()
    drawer.cards = drawer_cards

    drawer.pressed.connect(_on_drawer_pressed)

func _process(delta: float) -> void:
    if moving_card != null:
        moving_card.global_position = moving_card.global_position.move_toward(created_card_tile.global_position, card_move_speed * delta)
        if moving_card.global_position.distance_squared_to(created_card_tile.global_position) < 16:
            moving_card.global_position = created_card_tile.global_position
            flip_card()

func flip_card() -> void:
    if move_state == MoveState.FLIPPING:
        return
    
    move_state = MoveState.FLIPPING
    var tween_1 = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
    # Flip by scaling X to 0 and back
    tween_1.tween_property(moving_card, "scale:x", 0.01, 0.15)
    await tween_1.finished
    moving_card.queue_free()

    created_card_tile.modulate = Color.WHITE
    created_card_tile.scale.x = 0
    var tween_2 = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
    tween_2.tween_property(created_card_tile, "scale:x", 1, 0.15)
    await tween_2.finished
    
    moving_card = null
    created_card_tile = null
    move_state = MoveState.NONE

func _setup() -> void:
    var drawer_cards = all_cards.duplicate()
    drawer_cards.shuffle()

    drawer.cards = drawer_cards

    drawer.pressed.connect(_on_drawer_pressed)

func _on_drawer_pressed() -> void:
    if move_state != MoveState.NONE:
        return

    move_state = MoveState.MOVING
    var card = drawer.draw()
    if card == null:
        return
    
    moving_card = CardUiScene.instantiate()
    moving_card.card = card
    add_child(moving_card)
    moving_card.global_position = drawer.global_position

    created_card_tile = CardTileScene.instantiate()
    created_card_tile.card = card
    created_card_tile.modulate = Color.TRANSPARENT
    cards.add_child(created_card_tile)
