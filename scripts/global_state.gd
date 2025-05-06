extends Node


var _file_name: String = 'Unsaved(*)'
var _data: Dictionary = {
	"player": {},
	"area_completed": {},
	"background": {},
	"music": {},
}


func get_file_name() -> String:
	return _file_name


func set_file_name(file_name: String) -> void:
	_file_name = file_name


func set_value(id: String, key: String, value: Variant) -> void:
	_data[id][key] = value 


func get_value(id: String, key: String) -> Variant:
	if not _data[id].has(key):
		return null
	return _data[id][key]


func get_all() -> Dictionary:
	return _data


func set_all(data: Dictionary) -> void:
	_data = data


func clear_all() -> void:
	_data.clear()
