class_name Bricks extends TileMapLayer

signal total_bricks_changed(total_bricks: int)

var total_bricks: int = 0

func _ready() -> void:
    child_entered_tree.connect(_on_child_entered_tree)
    child_exiting_tree.connect(_on_child_exiting_tree)

func _on_child_entered_tree(child: Node) -> void:
    if child is Brick:
        total_bricks += 1
        total_bricks_changed.emit(total_bricks)

func _on_child_exiting_tree(child: Node) -> void:
    if child is Brick:
        total_bricks -= 1
        total_bricks_changed.emit(total_bricks)