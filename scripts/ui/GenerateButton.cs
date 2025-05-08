using Godot;
using System;
using System.Diagnostics;
using System.IO;


public partial class GenerateButton : Button
{
	[Export] private LineEdit _playerPathField;
	[Export] private LineEdit _platformPathField;
	[Export] private OptionButton _algorithmOption;
	
	private string _pythonPath;
	private string _scriptPath;

	private const string _EditorScene = "res://scenes/editor/editor.tscn";


	private void OnPressed()
	{
		RunPythonScript();
		GetTree().CallDeferred(SceneTree.MethodName.ChangeSceneToFile, _EditorScene);
	}


	private void RunPythonScript()
	{
		string basePath = Engine.IsEditorHint() 
			? OS.GetExecutablePath().GetBaseDir() 
			: ProjectSettings.GlobalizePath("res://");

        _pythonPath = (OS.GetName() == "Windows")
			? Path.Join(basePath, ".venv", "Scripts", "python.exe")
			: Path.Join(basePath, ".venv", "bin", "python");

        _scriptPath = Path.Join(basePath, "scripts", "img_proc", "image_processor.py");

		string algorithm = string.Empty;
		if (_algorithmOption.GetSelectedId() == 0)
		{
			algorithm = "color_threshold";
		}
		else if (_algorithmOption.GetSelectedId() == 1)
		{
			algorithm = "edge_detection";
		}
		else if (_algorithmOption.GetSelectedId() == 2)
		{
			algorithm = "edge_detection_no_fill";
		}

		RunImageProcessor(_platformPathField.Text, "Platform", algorithm);
		RunImageProcessor(_playerPathField.Text, "Player", algorithm);
	}


	private void RunImageProcessor(string assetPath, string assetType, string algorithm="color_threshold")
	{
		try 
		{
			ProcessStartInfo start = new ProcessStartInfo
			{
				FileName = _pythonPath,
				Arguments = $"{_scriptPath} {assetPath} {assetType} {algorithm}",
				UseShellExecute = false,
				RedirectStandardError = true,
				RedirectStandardOutput = true,
				CreateNoWindow = true
			};
		
			using Process process = Process.Start(start);

			process.OutputDataReceived += (s, e) => {
				if (string.IsNullOrEmpty(e.Data)) return;
				if (e.Data.StartsWith("Image saved"))
					GD.PrintRich($"[color=green]SUCCESS[/color]: {e.Data}");
				else
					GD.Print($"INFO: {e.Data}");
			};

			process.ErrorDataReceived += (s, e) => {
				if (!string.IsNullOrEmpty(e.Data))
					GD.PrintRich($"[color=red]ERROR[/color]: {e.Data}");
			};

			process.BeginOutputReadLine();
			process.BeginErrorReadLine();

			process.WaitForExit();
		}
		catch (Exception error)
		{
			GD.PrintRich($"[color=red]ERROR[/color]: {error.Message}");
		}
	}
}
