extends CanvasLayer


const _IMPORT_SCENE: String = 'res://scenes/ui/import_screen.tscn'
const _DEMO_SCENE: String = 'res://scenes/demo.tscn'


func _ready() -> void:
	$LoadButton.grab_focus()


func _on_load_button_pressed() -> void:
	pass


func _on_create_button_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred(_IMPORT_SCENE)


func _on_demo_button_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred(_DEMO_SCENE)


func _on_exit_button_pressed() -> void:
	pass
