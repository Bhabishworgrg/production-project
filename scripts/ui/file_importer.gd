extends Control

class_name FileImporter


@export
var _initial_focus_control: Control


func _ready() -> void:
	if _initial_focus_control:
		_initial_focus_control.grab_focus()


func _on_button_pressed() -> void:
	$FileDialog.show()


func _on_file_selected(path: String) -> void:
	$PathField.text = path
