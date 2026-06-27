extends Node3D

const FishingScene = preload("res://fishing.tscn")

@onready var _score_label: Label = %Score
@onready var _fish_label: Label = %FishLabel
@onready var _boat: Boat = %Boat

var _fishing: Fishing
var _score: int = 0

func _ready():
    _boat.fishing_pool_entered.connect(_on_fishing_pool_entered)
    _boat.fishing_pool_exited.connect(_on_fishing_pool_exited)

func _on_fishing_pool_entered():
    _fish_label.visible = true

func _on_fishing_pool_exited():
    _fish_label.visible = false

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("fish"):
        if _fishing or not _boat.is_on_fishing_pool():
            return

        var fishing_pool: FishingPool = _boat.get_fishing_pool()
        _fishing = FishingScene.instantiate()
        _fishing.fishing_scene = fishing_pool.start()
        _fishing.won.connect(_on_won)
        _fishing.lost.connect(_on_lost)
        add_child(_fishing)

func _on_won():
    _score += 1
    _update_score()
    await get_tree().process_frame
    _fishing.queue_free()
    _fishing = null

func _on_lost():
    _score -= 1
    _update_score()
    await get_tree().process_frame
    _fishing.queue_free()
    _fishing = null

func _update_score():
    _score_label.text = str(_score) + " 🐟"
