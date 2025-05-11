extends AspectRatioContainer

class_name ViewPort


var _moveable: bool
var _dragging: bool
var _drag_delta: Vector2


func _ready() -> void:
	_moveable = true
	_dragging = false
	_drag_delta = Vector2.ZERO


func _process(_delta: float) -> void:
	if _drag_delta.length() > 0:
		$Camera2D.global_position += _drag_delta
		_drag_delta = Vector2.ZERO
		

func _unhandled_input(event: InputEvent) -> void:
	if not _moveable:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		_dragging = true if event.is_pressed() else false
	elif event is InputEventMouseMotion and _dragging:
		_drag_delta -= event.relative


func _on_draggable_mouse_entered() -> void:
	_moveable = false


func _on_draggable_mouse_exited() -> void:
	if !Input.is_action_pressed('left_click'):
		_moveable = true 
