extends Node

class_name TextureLoader 


var _parent: Node
var _image: Image
var _texture: Texture2D


func _ready() -> void:
	_parent = get_parent()

	var file_path: String
	if not Engine.is_editor_hint():
		file_path = 'res://assets/' + _parent.name + '.png'
	else:
		file_path = OS.get_executable_path().get_base_dir() + '/assets/' + _parent.name + '.png'
	
	_image = Image.load_from_file(file_path)
	if _image:
		_texture = ImageTexture.new()
		_texture.set_image(_image)
	else:
		print_rich('[color=red]ERROR[/color]: Could not load image from file: ' + file_path)
	
	if _texture:
		var sprite: Sprite2D = Sprite2D.new()
		if _parent.is_in_group('player'):
			sprite.centered = true
		else:
			sprite.centered = false
		sprite.texture = _texture
		_parent.add_child.call_deferred(sprite)
	else:
		print_rich('[color=red]ERROR[/color]: Could not load image from file: ' + file_path)
