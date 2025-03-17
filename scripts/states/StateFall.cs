using Godot;


public partial class StateFall : State 
{
	private float SPEED;


	public override void Enter()
	{
		_character = GetOwner<CharacterBody2D>();
		_stateMachine = GetParent<Node>();
		
		SPEED = (float)_character.Get("SPEED");

		if (_character == null || _stateMachine == null)
        {
            GD.PrintRich("[color=red]ERROR[/color]: Fall state not properly initialized.");
        }
	}


	public override void Update(float delta)
	{
		float direction = Input.GetAxis("left", "right");
		if (direction != 0)
		{
			_character.Velocity = new Vector2(direction * SPEED, _character.Velocity.Y);
		}
	}


	public override void PhysicsUpdate(float delta)
	{
		if (_character.IsOnFloor())
		{
			Error error = _stateMachine.EmitSignal("state_changed", "StateLand");
			if (error == Error.Unavailable)
			{
				GD.PrintRich("[color=red]ERROR[/color]: State change to Land failed.");
			}
		}
		else	
		{
			_character.Velocity += _character.GetGravity() * delta;
		}
	}


	public override void Exit()
	{
	}
}
