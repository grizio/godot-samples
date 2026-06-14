class_name ExplosiveBrick extends Brick

const explosion_scene: PackedScene = preload("uid://btfki0j2vu4h3")

@onready var explosion_area: Area2D = $ExplosionArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func on_hit(_damage: int, _type: Constants.Variant) -> void:
    animation_player.play("explosion")

    await animation_player.animation_finished
    
    var explosion: GPUParticles2D = explosion_scene.instantiate()
    get_tree().current_scene.add_child(explosion)
    explosion.global_position = global_position
    explosion.emitting = true
    explosion.finished.connect(func(): explosion.queue_free())
    
    for body in explosion_area.get_overlapping_bodies():
        if body.has_method("on_hit"):
            body.on_hit(1, Constants.Variant.NORMAL)

    collision_layer = 0

    var tween := create_tween()
    tween.tween_property(self , "modulate", Color(0, 0, 0, 1), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
    tween.tween_property(self , "modulate", Color(0, 0, 0, 0), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

    await tween.finished
    queue_free()
