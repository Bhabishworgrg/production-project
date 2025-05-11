extends Window

class_name SaveAsWindow

@export
var _player: Node2D 
@export
var _area_completed: Node2D
@export
var _file_name_label: Label


func _on_close_requested() -> void:
	hide()


func _on_save_button_pressed() -> void:
	GlobalState.set_value("player", "position", _player.position)
	GlobalState.set_value("area_completed", "position", _area_completed.position)

	var dir_access = DirAccess.open("res://")
	if dir_access.change_dir("save") != OK:
		dir_access.make_dir("save")

	var file_name = $PathField.text
	var save_file = FileAccess.open("res://save".path_join(file_name)+".save", FileAccess.WRITE)
	if save_file:
		save_file.store_var(GlobalState.get_all())
		save_file.close()
		_file_name_label.text = file_name
		GlobalState.set_file_name(file_name)
	else:
		print_rich('[color=red]ERROR[/color]: Failed to save file.')

	hide()
