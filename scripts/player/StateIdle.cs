using Godot;


public partial class StateIdle : State 
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

		if (Input.IsActionJustPressed("jump"))
		{
			_stateMachine.EmitSignal("state_changed", "StateJump");
		}
	}


	public override void PhysicsUpdate(float delta)
	{
	}


	public override void Exit()
	{
	}
}
