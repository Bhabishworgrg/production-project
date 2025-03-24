extends Node


func _ready() -> void:
	var image: Image = Image.load_from_file('res://assets/player.png')
	var size: Vector2 = image.get_size()
	var points: PackedVector2Array
	var color: Color
	
	for x in range(size.x):
		for y in range(size.y):
			color = image.get_pixel(x,y)
			if (color.a > 0.1):
				points.append(Vector2(x, y))

	var collision_shape: CollisionPolygon2D = CollisionPolygon2D.new()
	collision_shape.build_mode = CollisionPolygon2D.BUILD_SEGMENTS
	collision_shape.polygon = points
	owner.add_child.call_deferred(collision_shape)
