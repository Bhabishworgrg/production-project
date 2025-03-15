extends Node


@warning_ignore('unused_signal')
signal state_changed(new_state: String)

@export
var _state: Node 
var _states: Dictionary


func _ready() -> void:
	print('INFO: Initializing state machine...')

	var child_name: String
	for child in get_children():
		child_name = child.get_name()
		_states[child_name] = child
		print_rich('[color=green]SUCCESS[/color]: Added state: ' + child_name)

	_state.Enter()
	print_rich('[color=green]SUCCESS[/color]: State machine initialized')


func _process(delta: float) -> void:
	_state.Update(delta)


func _physics_process(delta: float) -> void:
	_state.PhysicsUpdate(delta)


func _on_state_changed(new_state: String) -> void:
	_state.Exit()
	
	if not _states.has(new_state):
		print_rich('[color=red]ERROR[/color]: State ' + new_state + ' does not exist')

	var _prev_state: Node = _state
	_state = _states[new_state]
	
	if not _state:
		print_rich('[color=red]ERROR[/color]: State ' + new_state + ' is not a valid state')
	elif _state == _prev_state:
		print_rich('[color=yellow]WARNING[/color]: State changed to the same state')
	print('INFO: State changed to ' + new_state)

	_state.Enter()
