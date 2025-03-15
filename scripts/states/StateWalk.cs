using Godot;


public partial class StateWalk : State
{
	private float SPEED;


	public override void Enter()
	{
		_character = GetOwner<CharacterBody2D>();
		_stateMachine = GetParent<Node>();

		SPEED = (float)_character.Get("SPEED");

		if (_character == null || _stateMachine == null || SPEED == 0)
		{
			GD.PrintRich("[color=red]ERROR[/color]: Walk state not properly initialized.");
		}
	}


	public override void Update(float delta)
	{
		if (Input.IsActionJustPressed("jump"))
		{
			Error error = _stateMachine.EmitSignal("state_changed", "StateJump");

			if (error == Error.Unavailable)
			{
				GD.PrintRich("[color=red]ERROR[/color]: ", error);
			}
		}
	
		float direction = Input.GetAxis("left", "right");
		if (direction == 0)
		{
			Error error = _stateMachine.EmitSignal("state_changed", "StateIdle");

			if (error == Error.Unavailable)
			{
				GD.PrintRich("[color=red]ERROR[/color]: ", error);
			}
		}
		else
		{
			_character.Velocity = new Vector2(direction * SPEED, _character.Velocity.Y);
		}
	}


	public override void PhysicsUpdate(float delta)
	{
		if (!_character.IsOnFloor())
		{
			Error error = _stateMachine.EmitSignal("state_changed", "StateFall");

			if (error == Error.Unavailable)
			{
				GD.PrintRich("[color=red]ERROR[/color]: ", error);
			}
		}
	}


	public override void Exit()
	{
	}
}
