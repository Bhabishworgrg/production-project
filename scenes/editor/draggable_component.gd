extends Node


var draggable: bool
var parent: CollisionObject2D 
var viewport: AspectRatioContainer 


func _ready() -> void:
	draggable = false
	parent = get_parent()
	viewport = parent.get_parent()

	parent.mouse_entered.connect(_on_mouse_entered)
	parent.mouse_exited.connect(_on_mouse_exited)
		
	parent.mouse_entered.connect(viewport._on_draggable_mouse_entered)
	parent.mouse_exited.connect(viewport._on_draggable_mouse_exited)


func _process(delta: float) -> void:
	if draggable:
		if Input.is_action_pressed('left_click'):
			parent.global_position = parent.get_global_mouse_position()
	

func _on_mouse_entered() -> void:
	draggable = true
	parent.scale = Vector2(1.05, 1.05)


func _on_mouse_exited() -> void:
	draggable = false
	parent.scale = Vector2(1, 1)
