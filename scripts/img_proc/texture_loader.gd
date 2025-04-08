extends Node


func _ready() -> void:
	var file_path: String
	if not Engine.is_editor_hint():
		file_path = 'res://assets/' + owner.name + '.png'
	else:
		file_path = OS.get_executable_path().get_base_dir() + '/assets/' + owner.name + '.png'
	
	var image: Image = Image.load_from_file(file_path)
	var texture: Texture2D
	
	if image:
		texture = ImageTexture.new()
		texture.set_image(image)
	else:
		print_rich('[color=red]ERROR[/color]: Could not load image from file: ' + file_path)
	
	if texture:
		var sprite: Sprite2D = Sprite2D.new()
		if owner.is_in_group('player'):
			sprite.centered = true
		else:
			sprite.centered = false
		sprite.texture = texture
		owner.add_child.call_deferred(sprite)
	else:
		print_rich('[color=red]ERROR[/color]: Could not load image from file: ' + file_path)
