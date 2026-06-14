@tool
class_name FlowBrick extends Brick

@export var speed: Vector3 = Vector3.ONE

@onready var noise: FastNoiseLite = $Sprite2D.texture.noise

func _ready() -> void:
    noise.seed = randi()

func _process(delta: float) -> void:
    noise.offset += speed * delta


func on_hit(_damage: int, _type: Constants.Variant) -> void:
    if _type == Constants.Variant.FLOW:
        queue_free()
