extends Window

class_name ConfigWindow


@export
var _background_path_field: LineEdit
@export
var _music_path_field: LineEdit
@export
var _background: TextureRect 


func _on_close_requested() -> void:
	hide()	


func _on_save_button_pressed() -> void:
	var background_path = _background_path_field.text
	var music_path = _music_path_field.text
	
	_background.texture = load(background_path)

	hide()
