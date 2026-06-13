extends Node2D

var balls: int = 0

func _ready() -> void:
    _setup_ball(self )

func _setup_ball(node: Node) -> void:
    if node is Ball:
        balls += 1
        node.died.connect(_on_ball_died)
    
    for child in node.get_children():
        _setup_ball(child)

func _on_ball_died() -> void:
    balls -= 1
    if balls <= 0:
        print("Game over")
