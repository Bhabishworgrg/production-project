extends Node


func _ready() -> void:
	var file_path: String = 'res://assets/' + owner.name + '.png'
	var texture: Texture2D = load(file_path)
	
	if texture:
		var sprite: Sprite2D = Sprite2D.new()
		sprite.centered = false
		sprite.texture = texture
		owner.add_child.call_deferred(sprite)
	else:
		print_rich('[color=red]ERROR[/color]: Could not load image from file: ' + file_path)
