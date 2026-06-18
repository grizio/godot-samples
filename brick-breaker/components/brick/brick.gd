class_name Brick extends StaticBody2D

const ShrinkModifierScene = preload("uid://deittmxa3h1ni")
const GrowModifierScene = preload("uid://dndwbm7ceifu5")

const modifiers = [Constants.modifier_grow, Constants.modifier_shrink]

func generate_modifier(probability: float = 0.1) -> void:
    if randf() > probability:
        return

    var n = randi_range(0, modifiers.size() - 1)
    var modifier: Modifier
    match modifiers[n]:
        Constants.modifier_grow:
            modifier = GrowModifierScene.instantiate()
        Constants.modifier_shrink:
            modifier = ShrinkModifierScene.instantiate()
    
    get_tree().get_first_node_in_group(Constants.group_level).call_deferred("add_child", modifier)
    modifier.global_position = global_position
