extends CharacterBody2D


class_name Player
const SPEED: float = 300.0
@export var JUMP_VELOCITY: float = -400.0


@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle jump.
		#	if Input.is_action_just_pressed('jump') and is_on_floor():
		#		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	#var direction: float = Input.get_axis('left', 'right')
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
