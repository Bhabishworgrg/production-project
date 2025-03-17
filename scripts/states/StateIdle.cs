using Godot;


public partial class StateIdle : State 
{
	private float SPEED;

	public override void Enter()
	{
		_character = GetOwner<CharacterBody2D>();
		_stateMachine = GetParent<Node>();

		SPEED = (float)_character.Get("SPEED");

		if (_character == null || _stateMachine == null || SPEED == 0)
		{
			GD.PrintRich("[color=red]ERROR[/color]: Idle state not properly initialized.");
		}
	}


	public override void Update(float delta)
	{
		if (Input.GetAxis("left", "right") != 0)
		{
			Error error = _stateMachine.EmitSignal("state_changed", "StateWalk");

			if (error == Error.Unavailable)
			{
				GD.PrintRich("[color=red]ERROR[/color]: State change to Walk failed.");
			}
		}

		if (Input.IsActionJustPressed("jump"))
		{
			Error error = _stateMachine.EmitSignal("state_changed", "StateJump");

			if (error == Error.Unavailable)
			{
				GD.PrintRich("[color=red]ERROR[/color]: State change to Jump failed.");
			}
		}
	}


	public override void PhysicsUpdate(float delta)
	{
		if (_character.Velocity.X != 0)
		{
			_character.Velocity = new Vector2(0, _character.Velocity.Y);
		}

		if (!_character.IsOnFloor())
		{
			Error error = _stateMachine.EmitSignal("state_changed", "StateFall");

			if (error == Error.Unavailable)
			{
				GD.PrintRich("[color=red]ERROR[/color]: State change to Fall failed.");
			}
		}
	}


	public override void Exit()
	{
	}
}
