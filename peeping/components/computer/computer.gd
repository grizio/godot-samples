class_name Computer extends Node3D

@export var expected_code_1: String = ""
@export var expected_code_2: String = ""
@export var expected_code_3: String = ""
@export var expected_code_4: String = ""

@export var openable: Openable

@onready var triangle_button: ComputerButton = %TriangleButton
@onready var rectangle_button: ComputerButton = %RectangleButton
@onready var cross_button: ComputerButton = %CrossButton

@onready var symbol_1: Sprite3D = %Symbol1
@onready var symbol_2: Sprite3D = %Symbol2
@onready var symbol_3: Sprite3D = %Symbol3
@onready var symbol_4: Sprite3D = %Symbol4

var code_1: String = ""
var code_2: String = ""
var code_3: String = ""
var code_4: String = ""

func _ready() -> void:
    triangle_button.clicked.connect(on_button_clicked)
    rectangle_button.clicked.connect(on_button_clicked)
    cross_button.clicked.connect(on_button_clicked)

func on_button_clicked(code: String) -> void:
    if code_1 == "":
        code_1 = code
    elif code_2 == "":
        code_2 = code
    elif code_3 == "":
        code_3 = code
    elif code_4 == "":
        code_4 = code
        _code_completed()
    
    _setup_sprites()

func _code_completed() -> void:
    if code_1 == expected_code_1 and code_2 == expected_code_2 and code_3 == expected_code_3 and code_4 == expected_code_4:
        openable.open()
    else:
        code_1 = ""
        code_2 = ""
        code_3 = ""
        code_4 = ""

func _setup_sprites() -> void:
    symbol_1.texture = get_texture(code_1)
    symbol_2.texture = get_texture(code_2)
    symbol_3.texture = get_texture(code_3)
    symbol_4.texture = get_texture(code_4)

func get_texture(code: String) -> Texture:
    if code == "triangle":
        return load("res://components/symbols/triangle.tres")
    elif code == "rectangle":
        return load("res://components/symbols/rectangle.tres")
    elif code == "cross":
        return load("res://components/symbols/cross.tres")
    else:
        return load("res://components/symbols/none.tres")