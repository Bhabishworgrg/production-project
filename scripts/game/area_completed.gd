extends Area2D

class_name AreaCompleted


const _LEVEL_COMPLETE_SCENE: String = 'res://scenes/ui/complete_ui.tscn'


func _on_player_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		get_tree().change_scene_to_file.call_deferred(_LEVEL_COMPLETE_SCENE)
	else:
		print_rich('[color=yellow]WARNING:[/color] Body not in group player entered AreaCompleted')
