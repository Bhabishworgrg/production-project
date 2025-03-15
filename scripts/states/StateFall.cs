using Godot;


public partial class StateFall : State 
{
	public override void Enter()
	{
		_character = GetOwner<CharacterBody2D>();
		_stateMachine = GetParent<Node>();

		if (_character == null || _stateMachine == null)
        {
            GD.PrintRich("[color=red]ERROR[/color]: Fall state not properly initialized.");
        }
	}


	public override void Update(float delta)
	{
	}


	public override void PhysicsUpdate(float delta)
	{
		if (_character.IsOnFloor())
		{
			Error error = _stateMachine.EmitSignal("state_changed", "StateLand");
			if (error == Error.Unavailable)
			{
				GD.PrintRich("[color=red]ERROR[/color]: ", error);
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
