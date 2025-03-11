extends Area2D


func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group('player'):
		var death_scene: String = 'res://scenes/ui/death_screen.tscn'
		get_tree().change_scene_to_file.call_deferred(death_scene)
