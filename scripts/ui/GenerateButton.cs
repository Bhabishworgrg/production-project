using Godot;
using System;
using System.Diagnostics;
using System.IO;


public partial class GenerateButton : Button
{
	[Export] private LineEdit playerPathField;
	[Export] private LineEdit platformPathField;
	
	private string pythonPath;
	private string scriptPath;
	
	private const string GAME_SCENE = "res://scenes/game.tscn";


	private void _OnPressed()
	{
		RunPythonScript();
		GetTree().CallDeferred(SceneTree.MethodName.ChangeSceneToFile, GAME_SCENE);
	}


	private void RunPythonScript()
	{
		string basePath = Engine.IsEditorHint() 
			? OS.GetExecutablePath().GetBaseDir() 
			: ProjectSettings.GlobalizePath("res://");

        pythonPath = Path.Join(basePath, "venv", "bin", "python");
        scriptPath = Path.Join(basePath, "scripts", "img_proc", "image_processor.py");
		
		RunImageProcessor(platformPathField.Text, "Platform");
		RunImageProcessor(playerPathField.Text, "Player");
	}


	private void RunImageProcessor(string assetPath, string assetType)
	{
		try 
		{
			ProcessStartInfo start = new ProcessStartInfo
			{
				FileName = pythonPath,
				Arguments = $"{scriptPath} {assetPath} {assetType}",
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
