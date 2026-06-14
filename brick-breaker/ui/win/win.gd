class_name Win extends CanvasLayer

@onready var quit: Button = %Quit

func _ready() -> void:
    visibility_changed.connect(_on_visibility_changed)
    quit.pressed.connect(_on_quit)


func _on_visibility_changed() -> void:
    if visible:
        quit.grab_focus()

func _on_quit() -> void:
    get_tree().quit()