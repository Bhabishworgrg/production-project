using Godot;
using System.Diagnostics;
using System.IO;


public partial class GenerateButton : Button
{
	[Export] private LineEdit playerPathField;
	[Export] private LineEdit platformPathField;


	public override void _Ready()
	{
	}


	public override void _Process(double delta)
	{
	}


	private void _OnPressed()
	{
		RunPythonScript();
		GetTree().CallDeferred(SceneTree.MethodName.ChangeSceneToFile, "res://scenes/game.tscn");
	}


	public void RunPythonScript()
	{
		string pythonPath = "";
		string scriptPath = "";
		if (Engine.IsEditorHint())
		{
			pythonPath = OS.GetExecutablePath().GetBaseDir().PathJoin("venv/bin/python");
			scriptPath = OS.GetExecutablePath().GetBaseDir().PathJoin("scripts/image_processor.py");
		}
		else
		{
			pythonPath = ProjectSettings.GlobalizePath("res://").PathJoin("venv/bin/python");
			scriptPath = ProjectSettings.GlobalizePath("res://").PathJoin("scripts/img_proc/image_processor.py");
		}

		string arguments = $"{scriptPath} {platformPathField.Text} Platform";

		ProcessStartInfo start = new ProcessStartInfo
		{
			FileName = pythonPath,
			Arguments = arguments,
			UseShellExecute = false,
			RedirectStandardError = true,
			CreateNoWindow = true
		};

		using Process process = Process.Start(start);
		using StreamReader errorReader = process.StandardError;

		string error = errorReader.ReadToEnd();

		process.WaitForExit();

		if (!string.IsNullOrEmpty(error))
		{
			GD.PrintRich($"[color=red]ERROR[/color]: {error}");
		}
		else
		{
			GD.Print("INFO: Image Processor script executed successfully.");
		}
	}
}
