extends Node

const SAVE_FILE = "user://save.json"

signal power_added(power: String)

class SaveData:
    var enabled_levels: Array[String]
    var powers: Array[String]

var data: SaveData = null

func _ready() -> void:
    _load()
    
    if data == null:
        data = _create_empty_data()
        _save()

func _load() -> void:
    if not FileAccess.file_exists(SAVE_FILE):
        return
    
    var json_string = FileAccess.get_file_as_string(SAVE_FILE)
    var json = JSON.new()
    var parse_result = json.parse(json_string)
    if not parse_result == OK:
        printerr("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
        return
    
    data = SaveData.new()
    data.enabled_levels = []
    for level in json.data.enabled_levels:
        data.enabled_levels.append(level)
    
    data.powers = []
    if json.data.has("powers"):
        for power in json.data.powers:
            data.powers.append(power)

func _save() -> void:
    if data == null:
        return
    
    var json_data = {}
    json_data["enabled_levels"] = data.enabled_levels
    json_data["powers"] = data.powers

    var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
    file.store_string(JSON.stringify(json_data))
    file.close()

func commit() -> void:
    _save()

func rollback() -> void:
    _load()

func reset() -> void:
    if not FileAccess.file_exists(SAVE_FILE):
        return
    
    data = _create_empty_data()
    _save()

func _create_empty_data() -> SaveData:
    data = SaveData.new()
    data.enabled_levels = ["tuto"]
    return data

func enable_level(level: String) -> void:
    if data.enabled_levels.has(level):
        return
    
    data.enabled_levels.append(level)
    _save()

func is_level_enabled(level: String) -> bool:
    return data.enabled_levels.has(level)

func enable_power(power: String) -> void:
    if data.powers.has(power):
        return
    
    data.powers.append(power)
    power_added.emit(power)

func is_power_enabled(power: String) -> bool:
    return data.powers.has(power)
