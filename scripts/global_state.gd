extends Node


var data: Dictionary = {
	"player": {},
	"area_completed": {},
	"background": {},
	"music": {},
}


func set_value(id: String, key: String, value: Variant) -> void:
	data[id][key] = value 


func get_value(id: String, key: String) -> Variant:
	if not data[id].has(key):
		return null
	return data[id][key]


func clear_data(id: String) -> void:
	data.erase(id)


func clear_all() -> void:
	data.clear()
