using Godot;


public partial class StateJump : State 
{
	private float SPEED;


	public override void Enter()
	{
		_character = GetOwner<CharacterBody2D>();
		_stateMachine = GetParent<Node>();

		if (_character == null || _stateMachine == null)
		{
			GD.PrintRich("[color=red]ERROR[/color]: Jump state not properly initialized.");
		}

		float JUMP_VELOCITY = (float)_character.Get("JUMP_VELOCITY");
		_character.Velocity = new Vector2(_character.Velocity.X, JUMP_VELOCITY);
	}


	public override void Update(float delta)
	{
	}


	public override void PhysicsUpdate(float delta)
	{
		if (_character.Velocity.Y >= 0)
		{
			Error error = _stateMachine.EmitSignal("state_changed", "StateFall");

			if (error == Error.Unavailable)
			{
				GD.PrintRich("[color=red]ERROR[/color]: ", error);
			}
		}

		if (!_character.IsOnFloor())
		{
			_character.Velocity += _character.GetGravity() * delta;
		}
	}


	public override void Exit()
	{
	}
}
