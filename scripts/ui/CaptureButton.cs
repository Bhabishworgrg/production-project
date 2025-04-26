using Godot;
using System;
using System.IO;
using System.Diagnostics;


public partial class CaptureButton : TextureButton
{
	[Export] private LineEdit _pathField;

	private string _basePath;


	public override void _Ready() {
		_basePath = Engine.IsEditorHint() 
			? OS.GetExecutablePath().GetBaseDir() 
			: ProjectSettings.GlobalizePath("res://");
	}


	private void OnPressed()
	{
		Disabled = true;

		string parentContainer = GetParent().Name;
		if (parentContainer == "PlayerImportContainer")
		{
			RunPythonScript("Player");
			_pathField.Text = Path.Join(_basePath, "assets", "Player.png");
		}
		else if (parentContainer == "PlatformImportContainer")
		{
			RunPythonScript("Platform");
			_pathField.Text = Path.Join(_basePath, "assets", "Platform.png");
		}
		else
		{
			GD.PrintRich("[color=red]ERROR[/color]: Button doesn't have a valid parent.");
		}
		
		Disabled = false;
	}


	private void RunPythonScript(string assetType)
	{
        string pythonPath = Path.Join(_basePath, "venv", "bin", "python");
        string scriptPath = Path.Join(_basePath, "scripts", "img_proc", "image_capture.py");

		try 
		{
			ProcessStartInfo start = new ProcessStartInfo
			{
				FileName = pythonPath,
				Arguments = $"{scriptPath} {assetType}",
				UseShellExecute = false,
				RedirectStandardError = true,
				RedirectStandardOutput = true,
				CreateNoWindow = true
			};
		
			using Process process = Process.Start(start);
			using StreamReader errorReader = process.StandardError;
			using StreamReader outputReader = process.StandardOutput;

			string error = errorReader.ReadToEnd();
			string output = outputReader.ReadToEnd();

			process.WaitForExit();

			if (!string.IsNullOrEmpty(error))
			{
				using var reader = new System.IO.StringReader(error);
				string line;
				while ((line = reader.ReadLine()) != null)
				{
					if (line.Length > 0)
						GD.PrintRich($"[color=red]ERROR[/color]: {line}");
				}
			}

			if (!string.IsNullOrEmpty(output))
			{
				using var reader = new System.IO.StringReader(output);
				string line;
				while ((line = reader.ReadLine()) != null)
				{
					if (line.Length > 0)
					{
						if (line.StartsWith("Image saved"))
						{
							GD.PrintRich($"[color=green]SUCCESS[/color]: {line}");
						}
						else
						{
							GD.Print($"INFO: {line}");
						}	
					}
				}
			}
		}
		catch (Exception error)
		{
			GD.PrintRich($"[color=red]ERROR[/color]: {error.Message}");
		}
	}
}
