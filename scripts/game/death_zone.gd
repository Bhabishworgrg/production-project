extends Area2D


const DEATH_SCENE: Resource = preload('res://scenes/ui/death_screen.tscn')


func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group('player'):
		get_tree().change_scene_to_packed.call_deferred(DEATH_SCENE)
