extends CanvasLayer

class_name MainMenu


const _IMPORT_SCENE: String = 'res://scenes/ui/import_screen.tscn'
const _DEMO_SCENE: String = 'res://scenes/demo/demo.tscn'
const _EDITOR_SCENE: String = 'res://scenes/editor/editor.tscn'


func _ready() -> void:
	$LoadContainer/LoadButton.grab_focus()
	GlobalState.set_current_scene('res://scenes/ui/main_menu.tscn')


func _on_load_button_pressed() -> void:
	$LoadContainer/FileDialog.show()	


func _on_load_file_selected(path: String) -> void:
	GlobalState.clear_all()
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var data = file.get_var()
		file.close()

		var file_name = path.get_file().get_basename()
		GlobalState.set_file_name(file_name)
		GlobalState.set_all(data)

		GlobalState.set_previous_scene(GlobalState.get_current_scene())
		GlobalState.set_current_scene(_EDITOR_SCENE)
		get_tree().change_scene_to_file.call_deferred(_EDITOR_SCENE)
	else:
		print_rich('[color=red]ERROR[/color]: Failed to load file.')


func _on_create_button_pressed() -> void:
	GlobalState.set_previous_scene(GlobalState.get_current_scene())
	GlobalState.set_current_scene(_IMPORT_SCENE)
	get_tree().change_scene_to_file.call_deferred(_IMPORT_SCENE)


func _on_demo_button_pressed() -> void:
	GlobalState.set_previous_scene(GlobalState.get_current_scene())
	GlobalState.set_current_scene(_DEMO_SCENE)
	get_tree().change_scene_to_file.call_deferred(_DEMO_SCENE)


func _on_exit_button_pressed() -> void:
	$ExitContainer/ConfirmationDialog.show()	


func _on_exit_dialog_confirmed() -> void:
	get_tree().quit()
