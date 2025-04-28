extends CanvasLayer

class_name MainMenu


const _IMPORT_SCENE: String = 'res://scenes/ui/import_screen.tscn'
const _DEMO_SCENE: String = 'res://scenes/demo.tscn'


func _ready() -> void:
	$LoadContainer/LoadButton.grab_focus()


func _on_load_button_pressed() -> void:
	$LoadContainer/FileDialog.show()	


func _on_create_button_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred(_IMPORT_SCENE)


func _on_demo_button_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred(_DEMO_SCENE)


func _on_exit_button_pressed() -> void:
	$ExitContainer/ConfirmationDialog.show()	


func _on_exit_dialog_confirmed() -> void:
	get_tree().quit()
