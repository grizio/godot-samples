class_name UnbreakableBrick extends Brick

const SHINE_TIME: float = 0.15

@onready var sprite_material: ShaderMaterial = $UnbreakableBrick.material

var shining: bool = false

func on_hit(_damage: int, _type: Constants.Variant) -> void:
    if shining:
        return
    
    shining = true
    sprite_material.set_shader_parameter("shine_progress", 0.)
    sprite_material.set_shader_parameter("shine_size", 0.13)
    var tween := create_tween()
    tween.tween_property(sprite_material, "shader_parameter/shine_progress", 1.0, SHINE_TIME) \
        .set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
    tween.parallel().tween_property(sprite_material, "shader_parameter/shine_size", 0.01, SHINE_TIME * 0.75) \
        .set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN).set_delay(SHINE_TIME * 0.25)

    await tween.finished
    shining = false
