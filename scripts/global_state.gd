extends Node


var _data: Dictionary = {
	"player": {},
	"area_completed": {},
	"background": {},
	"music": {},
}


func set_value(id: String, key: String, value: Variant) -> void:
	_data[id][key] = value 


func get_value(id: String, key: String) -> Variant:
	if not _data[id].has(key):
		return null
	return _data[id][key]


func get_all() -> Dictionary:
	return _data


func clear_all() -> void:
	_data.clear()
