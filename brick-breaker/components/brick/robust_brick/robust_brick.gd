class_name RobustBrick extends Brick

const SHINE_TIME: float = 0.15

@onready var robust_brick: Sprite2D = $RobustBrick
@onready var robust_brick_break: Sprite2D = $RobustBrickBreak

@onready var robust_sprite_material: ShaderMaterial = $RobustBrick.material
@onready var break_sprite_material: ShaderMaterial = $RobustBrickBreak.material

var life: int = 2
var shining: bool = false

func _ready() -> void:
    robust_brick.material = null
    robust_brick_break.material = null

func on_hit(damage: int, type: Constants.Variant) -> void:
    if type == Constants.Variant.FLOW:
        return
    
    if damage <= 1:
        _shine()
        return
    
    life = life - (damage - 1)
    if life <= 0:
        collision_layer = 0

        generate_modifier(0.05)

        var tween := create_tween()
        tween.tween_property(self , "modulate", Color(0, 0, 0, 1), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
        tween.tween_property(self , "modulate", Color(0, 0, 0, 0), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

        await tween.finished
        queue_free()
    elif life == 1:
        var first_tween := create_tween()
        first_tween.tween_property(self , "modulate", Color.BLACK, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
        await first_tween.finished

        robust_brick_break.visible = true
        robust_brick.visible = false

        var second_tween := create_tween()
        second_tween.tween_property(self , "modulate", Color.WHITE, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
        await second_tween.finished
    else:
        robust_brick_break.visible = false
        robust_brick.visible = true

func _shine() -> void:
    if shining:
        return
    
    shining = true
    
    robust_brick.material = robust_sprite_material
    robust_brick_break.material = break_sprite_material

    robust_sprite_material.set_shader_parameter("shine_progress", 0.)
    robust_sprite_material.set_shader_parameter("shine_size", 0.13)
    break_sprite_material.set_shader_parameter("shine_progress", 0.)
    break_sprite_material.set_shader_parameter("shine_size", 0.13)
    var tween := create_tween()
    tween.tween_property(robust_sprite_material, "shader_parameter/shine_progress", 1.0, SHINE_TIME) \
        .set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
    tween.parallel().tween_property(robust_sprite_material, "shader_parameter/shine_size", 0.01, SHINE_TIME * 0.75) \
        .set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN).set_delay(SHINE_TIME * 0.25)
    tween.tween_property(break_sprite_material, "shader_parameter/shine_progress", 1.0, SHINE_TIME) \
        .set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
    tween.parallel().tween_property(break_sprite_material, "shader_parameter/shine_size", 0.01, SHINE_TIME * 0.75) \
        .set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN).set_delay(SHINE_TIME * 0.25)

    await tween.finished
    
    robust_brick.material = null
    robust_brick_break.material = null
    shining = false
