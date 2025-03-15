using Godot;


public partial class StateJump : State 
{
	private float SPEED;


	public override void Enter()
	{
		_character = GetOwner<CharacterBody2D>();
		_stateMachine = GetParent<Node>();
	
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
			_stateMachine.EmitSignal("state_changed", "StateFall");
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
