class_name Cards extends HBoxContainer

func _ready() -> void:
    var children = get_children()
    var nb_children = children.size()
    var middle: float = (nb_children - 1) / 2.0
    var max_index: int = nb_children / 2 if nb_children % 2 == 0 else (nb_children - 1) / 2
    for i in range(nb_children):
        var child = children[i]
        if i == middle:
            child.index = 0
        elif i > middle:
            child.index = i - middle
        else:
            child.index = - (middle - i)
        child.max_index = max_index
