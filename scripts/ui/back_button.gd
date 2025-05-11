extends TextureButton

class_name BackButton


func _on_pressed() -> void:
	var current_scene = GlobalState.get_current_scene()
	
	var previous_scene
	if current_scene == 'res://scenes/ui/import_screen.tscn':
		previous_scene = 'res://scenes/ui/main_menu.tscn'
	else:
		previous_scene = GlobalState.get_previous_scene()
	
	GlobalState.set_previous_scene(current_scene)
	GlobalState.set_current_scene(previous_scene)
	get_tree().change_scene_to_file.call_deferred(previous_scene)
