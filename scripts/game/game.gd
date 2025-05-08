extends Node2D


func _ready() -> void:
	var background = GlobalState.get_value("background", "texture")
	var music = GlobalState.get_value("music", "audio_stream")
	
	if background:
		$Background.texture = load(background)
	
	if music:
		$MusicPlayer.stream = load(music)
		$MusicPlayer.play()
