using Godot;


public partial class StateLand : State 
{
	public override void Enter()
	{
		_character = GetOwner<CharacterBody2D>();
		_stateMachine = GetParent<Node>();

		if (Input.GetAxis("left", "right") == 0)
		{
			_stateMachine.EmitSignal("state_changed", "StateIdle");
		}
		else
		{
			_stateMachine.EmitSignal("state_changed", "StateWalk");
		}
	}


	public override void Update(float delta)
	{
	}


	public override void PhysicsUpdate(float delta)
	{
	}


	public override void Exit()
	{
	}
}
