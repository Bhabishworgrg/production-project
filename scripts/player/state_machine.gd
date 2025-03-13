extends Node


signal state_changed(new_state: String)

@export
var _state: Node 
var _states: Dictionary


func _ready() -> void:
	_state = $State
	for child in get_children():
		_states[child.get_name()] = child
	_state.Enter()


func _process(delta: float) -> void:
	_state.Update(delta)


func _physics_process(delta: float) -> void:
	_state.PhysicsUpdate(delta)


func _on_state_changed(new_state: String) -> void:
	_state.Exit()

	_state = _states[new_state]
	_state.Enter()
