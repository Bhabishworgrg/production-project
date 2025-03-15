extends CharacterBody2D


@export
var SPEED: float = 300.0
@export
var JUMP_VELOCITY: float = -400.0


func _ready() -> void:
	print_rich('[color=green]SUCCESS[/color]: Player initialized') 


@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	move_and_slide()
