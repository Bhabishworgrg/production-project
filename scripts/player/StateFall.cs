public partial class StateFall : State 
{
	public override void Enter()
	{
	}


	public override void Update(float delta)
	{
	}


	public override void PhysicsUpdate(float delta)
	{
		if (_character.IsOnFloor())
		{
			_stateMachine.EmitSignal("state_changed", "StateLand");
		}
	}


	public override void Exit()
	{
	}
}
