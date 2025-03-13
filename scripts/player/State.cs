using Godot;


public abstract partial class State : Node
{
	protected CharacterBody2D _character;
	protected Node _stateMachine;
	
	public virtual void Enter()
	{
		_character = GetOwner<CharacterBody2D>();
		_stateMachine = GetParent<Node>();
	}

	public abstract void Update(float delta);
	public abstract void PhysicsUpdate(float delta);
	public abstract void Exit();
	
}
