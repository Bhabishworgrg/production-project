extends Control


func _on_button_pressed() -> void:
	$FileDialog.show()


func _on_file_selected(path: String) -> void:
	$PathField.text = path
