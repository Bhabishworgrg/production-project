extends AspectRatioContainer


var moveable: bool
var mouse_pos: Vector2
var drag_start


func _ready() -> void:
	moveable = true


func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		drag_start = get_global_mouse_position() if event.pressed else null

	if event is InputEventMouseMotion and drag_start and moveable:
		$Camera2D.position += drag_start - get_global_mouse_position()
		drag_start = get_global_mouse_position()

func _on_draggable_mouse_entered() -> void:
	moveable = false


func _on_draggable_mouse_exited() -> void:
	moveable = true
