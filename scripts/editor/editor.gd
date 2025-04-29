extends Node2D


func _on_config_button_pressed() -> void:
	$ConfigWindow.show()


func _on_play_button_pressed() -> void:
	GlobalState.set_value("player", "position", $Viewport/Player.position)
	GlobalState.set_value("area_completed", "position", $Viewport/AreaCompleted.position)
	
	get_tree().change_scene_to_file.call_deferred('res://scenes/game/game.tscn')


func _process(_delta: float) -> void:
	print($Viewport/Player.position)
