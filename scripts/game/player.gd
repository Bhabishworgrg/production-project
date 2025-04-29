extends CharacterBody2D

class_name Player


@export
var speed: float = 300.0
@export
var jump_velocity: float = -400.0


func _ready() -> void:
	position = GlobalState.get_value("player", "position")
	print_rich('[color=green]SUCCESS[/color]: Player initialized') 


func _physics_process(_delta: float) -> void:
	move_and_slide()
