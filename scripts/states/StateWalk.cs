using Godot;


public partial class StateWalk : State
{
	private float _speed;


	public override void Enter()
	{
		_character = GetOwner<CharacterBody2D>();
		_stateMachine = GetParent<Node>();

		_speed = (float)_character.Get("speed");

		if (_character == null || _stateMachine == null || _speed == 0)
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
				GD.PrintRich("[color=red]ERROR[/color]: State change to Jump failed.");
			}
		}
	
		float direction = Input.GetAxis("left", "right");
		if (direction == 0)
		{
			Error error = _stateMachine.EmitSignal("state_changed", "StateIdle");

			if (error == Error.Unavailable)
			{
				GD.PrintRich("[color=red]ERROR[/color]: State change to Idle failed."); 
			}
		}
		else
		{
			_character.Velocity = new Vector2(direction * _speed, _character.Velocity.Y);
		}
	}


	public override void PhysicsUpdate(float delta)
	{
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
