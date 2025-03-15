using Godot;


public partial class StateWalk : State
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
		if (Input.IsActionJustPressed("jump"))
		{
			_stateMachine.EmitSignal("state_changed", "StateJump");
		}
	
		float direction = Input.GetAxis("left", "right");
		if (direction == 0)
		{
			_stateMachine.EmitSignal("state_changed", "StateIdle");
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
			_stateMachine.EmitSignal("state_changed", "StateFall");
		}
	}


	public override void Exit()
	{
	}
}
