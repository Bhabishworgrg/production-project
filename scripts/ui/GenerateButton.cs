using Godot;
using System;
using System.Diagnostics;
using System.IO;


public partial class GenerateButton : Button
{
	[Export] private LineEdit _playerPathField;
	[Export] private LineEdit _platformPathField;
	
	private string _pythonPath;
	private string _scriptPath;
	
	private const string _GameScene = "res://scenes/game.tscn";


	private void OnPressed()
	{
		RunPythonScript();
		GetTree().CallDeferred(SceneTree.MethodName.ChangeSceneToFile, _GameScene);
	}


	private void RunPythonScript()
	{
		string basePath = Engine.IsEditorHint() 
			? OS.GetExecutablePath().GetBaseDir() 
			: ProjectSettings.GlobalizePath("res://");

        _pythonPath = Path.Join(basePath, "venv", "bin", "python");
        _scriptPath = Path.Join(basePath, "scripts", "img_proc", "image_processor.py");
		
		RunImageProcessor(_platformPathField.Text, "Platform");
		RunImageProcessor(_playerPathField.Text, "Player");
	}


	private void RunImageProcessor(string assetPath, string assetType)
	{
		try 
		{
			ProcessStartInfo start = new ProcessStartInfo
			{
				FileName = _pythonPath,
				Arguments = $"{_scriptPath} {assetPath} {assetType}",
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
