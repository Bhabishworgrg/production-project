extends Area2D

class_name DeathZone


const _DEATH_SCENE: Resource = preload('res://scenes/ui/death_screen.tscn')


func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group('player'):
		get_tree().change_scene_to_packed.call_deferred(_DEATH_SCENE)
	else:
		print_rich('[color=yellow]WARNING:[/color] Body not in group player entered DeathZone')
