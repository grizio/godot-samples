class_name Hitbox extends Area2D

@export var damage: int = 1

func _ready() -> void:
    body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
    if body.has_method("on_hit"):
        body.on_hit(damage)
