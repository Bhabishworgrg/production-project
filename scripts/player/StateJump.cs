public partial class StateJump : State 
{
	public override void Enter()
	{
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
	}


	public override void Exit()
	{
	}
}
