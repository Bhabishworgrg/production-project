extends CanvasLayer

class_name PauseMenu


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('escape'):
		get_tree().paused = true
		show()


func _on_exit_button_pressed() -> void:
	$ConfirmationDialog.show()


func _on_confirmation_dialog_confirmed() -> void:
	get_tree().quit()


func _on_go_back_button_pressed() -> void:
	get_tree().paused = false
	var current_scene = GlobalState.get_current_scene()
	get_tree().change_scene_to_file.call_deferred(current_scene)


func _on_unpause_button_pressed() -> void:
	get_tree().paused = false
	hide()
