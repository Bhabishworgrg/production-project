using Godot;


public partial class StateLand : State 
{
	public override void Enter()
	{
	}

	public override void Update(float delta)
	{
		if (Input.GetAxis("left", "right") != 0)
		{
			_stateMachine.EmitSignal("state_changed", "StateWalk");
		}

		_stateMachine.EmitSignal("state_changed", "StateIdle");
	}

	public override void PhysicsUpdate(float delta)
	{
	}

	public override void Exit()
	{
	}
}
