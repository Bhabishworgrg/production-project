using Godot;


public partial class StateIdle : State 
{
	private float SPEED;

	public override void Enter()
	{
		_character = GetOwner<CharacterBody2D>();
		_stateMachine = GetParent<Node>();

		SPEED = (float)_character.Get("SPEED");
	}


	public override void Update(float delta)
	{
		if (Input.GetAxis("left", "right") != 0)
		{
			_stateMachine.EmitSignal("state_changed", "StateWalk");
		}

		if (Input.IsActionJustPressed("jump"))
		{
			_stateMachine.EmitSignal("state_changed", "StateJump");
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
			_stateMachine.EmitSignal("state_changed", "StateFall");
		}
	}


	public override void Exit()
	{
	}
}
