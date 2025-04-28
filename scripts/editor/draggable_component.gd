extends Node

class_name DraggableComponent


var _draggable: bool
var _parent: CollisionObject2D 
var _viewport: AspectRatioContainer 


func _ready() -> void:
	_draggable = false
	_parent = get_parent()
	_viewport = _parent.get_parent()

	_parent.mouse_entered.connect(_on_mouse_entered)
	_parent.mouse_exited.connect(_on_mouse_exited)
		
	_parent.mouse_entered.connect(_viewport._on_draggable_mouse_entered)
	_parent.mouse_exited.connect(_viewport._on_draggable_mouse_exited)


@warning_ignore('unused_parameter')
func _process(delta: float) -> void:
	if _draggable:
		if Input.is_action_pressed('left_click'):
			_parent.global_position = _parent.get_global_mouse_position()
	

func _on_mouse_entered() -> void:
	_draggable = true
	_parent.scale = Vector2(1.05, 1.05)


func _on_mouse_exited() -> void:
	_draggable = false
	_parent.scale = Vector2(1, 1)
