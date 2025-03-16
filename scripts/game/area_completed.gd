extends Area2D


func _on_player_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		const LEVEL_COMPLETE_SCENE: String = 'res://scenes/ui/complete_ui.tscn'
		get_tree().change_scene_to_file.call_deferred(LEVEL_COMPLETE_SCENE)
