extends Node2D


func _ready() -> void:
	$Background.texture = GlobalState.get_value("background", "texture")
	$MusicPlayer.stream = load(GlobalState.get_value("music", "audio_stream"))
	$MusicPlayer.play()
