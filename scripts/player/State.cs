using Godot;


public abstract partial class State : Node
{
	public abstract void Enter();
	public abstract void Update(float delta);
	public abstract void PhysicsUpdate(float delta);
	public abstract void Exit();
}
