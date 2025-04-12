using Godot;
using System.Diagnostics;
using System.IO;


public partial class GenerateButton : Button
{
	[Export] private LineEdit playerPathField;
	[Export] private LineEdit platformPathField;


	public override void _Ready()
	{
		RunPythonScript();
	}


	public override void _Process(double delta)
	{
	}


	public void RunPythonScript()
	{
		GD.Print();
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
			RedirectStandardOutput = true,
			RedirectStandardError = true,
			CreateNoWindow = true
		};

		using Process process = Process.Start(start);
		using StreamReader errorReader = process.StandardError;

		string error = errorReader.ReadToEnd();

		process.WaitForExit();

		if (!string.IsNullOrEmpty(error))
		{
			GD.Print($"ERROR: {error}");
		}
	}
}
