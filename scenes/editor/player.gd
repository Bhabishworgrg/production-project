extends Area2D


var draggable = false


func _process(delta: float) -> void:
	if draggable:
		if Input.is_action_pressed('left_click'):
			global_position = get_global_mouse_position()
	

func _on_mouse_entered() -> void:
	draggable = true
	scale = Vector2(1.05, 1.05)


func _on_mouse_exited() -> void:
	draggable = false
	scale = Vector2(1, 1)
