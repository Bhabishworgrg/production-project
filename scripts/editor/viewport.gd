extends AspectRatioContainer

class_name ViewPort


var _moveable: bool
var _drag_start


func _ready() -> void:
	_moveable = true


func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		_drag_start = get_global_mouse_position() if event.pressed else null

	if event is InputEventMouseMotion and _drag_start and _moveable:
		$Camera2D.position += _drag_start - get_global_mouse_position()
		_drag_start = get_global_mouse_position()


func _on_draggable_mouse_entered() -> void:
	_moveable = false


func _on_draggable_mouse_exited() -> void:
	_moveable = true
