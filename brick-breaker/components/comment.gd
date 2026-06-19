@tool
class_name Comment extends Node2D

@export_multiline var notes := "":
    set(value):
        notes = value
        if label != null:
            label.text = value

var label: Label

func _ready():
    if not Engine.is_editor_hint():
        queue_free()
        return
    
    label = Label.new()
    label.text = notes
    add_child(label)