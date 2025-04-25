using Godot;
using System;
using System.IO;
using System.Diagnostics;


public partial class CaptureButton : TextureButton
{
	[Export] private LineEdit _pathField;


	private void OnPressed()
	{
		Disabled = true;
		RunPythonScript();
		Disabled = false;
	}


	private void RunPythonScript()
	{
		string basePath = Engine.IsEditorHint() 
			? OS.GetExecutablePath().GetBaseDir() 
			: ProjectSettings.GlobalizePath("res://");

        string pythonPath = Path.Join(basePath, "venv", "bin", "python");
        string scriptPath = Path.Join(basePath, "scripts", "img_proc", "image_capture.py");

		try 
		{
			ProcessStartInfo start = new ProcessStartInfo
			{
				FileName = pythonPath,
				Arguments = scriptPath,
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
		}
		catch (Exception error)
		{
			GD.PrintRich($"[color=red]ERROR[/color]: {error.Message}");
		}
	}
}
