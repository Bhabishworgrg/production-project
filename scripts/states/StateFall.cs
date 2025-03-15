using Godot;


public partial class StateFall : State 
{
	public override void Enter()
	{
		_character = GetOwner<CharacterBody2D>();
		_stateMachine = GetParent<Node>();
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
		else	
		{
			_character.Velocity += _character.GetGravity() * delta;
		}
	}


	public override void Exit()
	{
	}
}
