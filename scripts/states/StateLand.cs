using Godot;


public partial class StateLand : State 
{
	public override void Enter()
	{
		_character = GetOwner<CharacterBody2D>();
		_stateMachine = GetParent<Node>();

		if (_character == null || _stateMachine == null)
		{
			GD.PrintRich("[color=red]ERROR[/color]: Land state not properly initialized.");
		}

		if (Input.GetAxis("left", "right") == 0)
		{
			Error error = _stateMachine.EmitSignal("state_changed", "StateIdle");
			
			if (error == Error.Unavailable)
			{
				GD.PrintRich("[color=red]ERROR[/color]: State change to Idle failed.");
			}
		}
		else
		{
			Error error = _stateMachine.EmitSignal("state_changed", "StateWalk");

			if (error == Error.Unavailable)
			{
				GD.PrintRich("[color=red]ERROR[/color]: State change to Walk failed.");			
			}
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
