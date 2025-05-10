extends Node2D


func _ready() -> void:
	var background = GlobalState.get_value("background", "texture")
	var music = GlobalState.get_value("music", "audio_stream")

	if background:
		$Background.texture = load(background)

	if music and FileAccess.file_exists(music):
		var stream = load_external_wav(music)
		if stream:
			$MusicPlayer.stream = stream
			$MusicPlayer.play()
			print("Success: Playing external WAV.")
		else:
			print("Failed to load external WAV.")
	else:
		print("No valid music file found.")


func load_external_wav(path: String) -> AudioStreamWAV:
	var file := FileAccess.open(path, FileAccess.READ)
	if not file:
		push_error("Could not open file: " + path)
		return null

	# Check for RIFF header
	if file.get_8() != 0x52 or file.get_8() != 0x49 or file.get_8() != 0x46 or file.get_8() != 0x46:
		push_error("Not a valid RIFF WAV file.")
		return null

	file.get_32()  # Skip chunk size

	if file.get_8() != 0x57 or file.get_8() != 0x41 or file.get_8() != 0x56 or file.get_8() != 0x45:
		push_error("Not a valid WAVE format.")
		return null

	# Search for "data" chunk
	var data_offset = 0
	while not file.eof_reached():
		var chunk_id = file.get_buffer(4)
		var chunk_size = file.get_32()
		if chunk_id == "data".to_utf8_buffer():
			data_offset = file.get_position()
			break
		else:
			file.seek(file.get_position() + chunk_size)

	if data_offset == 0:
		push_error("Could not find WAV data chunk.")
		return null

	# Read the audio data
	file.seek(data_offset)
	var data = file.get_buffer(file.get_length() - data_offset)

	var stream = AudioStreamWAV.new()
	stream.data = data
	stream.mix_rate = 44100
	stream.stereo = true
	stream.format = AudioStreamWAV.FORMAT_16_BITS

	return stream
