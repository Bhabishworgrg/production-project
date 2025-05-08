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
	
	if FileAccess.file_exists(background_path) or background_path == "":
		GlobalState.set_value("background", "texture", background_path)
		
		var ext = background_path.get_extension().to_lower()
		if ext in ["png", "jpg", "jpeg", "webp", "bmp", "tga"]:
			_background.texture = load(background_path)
		elif background_path == "":
			_background.texture = null
		else:
			print_rich('[color=red]ERROR[/color]: Invalid background texture format. Supported formats: png, jpg, jpeg, webp, bmp, tga.')	
	else:
		print_rich('[color=red]ERROR[/color]: Background texture not found.')

	if FileAccess.file_exists(music_path) or music_path == "":
		GlobalState.set_value("music", "audio_stream", music_path)
	else:
		print_rich('[color=red]ERROR[/color]: Music file not found.')

	hide()
