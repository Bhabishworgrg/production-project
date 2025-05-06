extends Node2D


func _on_config_button_pressed() -> void:
	$ConfigWindow.show()


func _on_play_button_pressed() -> void:
	GlobalState.set_value("player", "position", $Viewport/Player.position)
	GlobalState.set_value("area_completed", "position", $Viewport/AreaCompleted.position)
	
	get_tree().change_scene_to_file.call_deferred('res://scenes/game/game.tscn')


func _process(_delta: float) -> void:
	print($Viewport/Player.position)


func _on_save_button_pressed() -> void:
	GlobalState.set_value("player", "position", $Viewport/Player.position)
	GlobalState.set_value("area_completed", "position", $Viewport/AreaCompleted.position)

	var dir_access = DirAccess.open("res://")
	if dir_access.change_dir("save") != OK:
		dir_access.make_dir("save")

	var save_file = FileAccess.open("res://save/savegame.save", FileAccess.WRITE)
	if save_file:
		save_file.store_var(GlobalState.get_all())
		save_file.close()
	else:
		print_rich('[color=red]ERROR[/color]: Failed to save file.')


func _on_save_as_button_pressed() -> void:
	$SaveAsWindow.show()
