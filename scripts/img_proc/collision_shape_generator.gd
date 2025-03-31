extends Node


func _ready() -> void:
	var image: Image = Image.load_from_file('res://assets/' + owner.name + '.png')
	var size: Vector2 = image.get_size()
	var color: Color
	var collision_shape
	var left: int = size.x
	var right: int = 0
	var top: int = size.y
	var bottom: int = 0

	if owner.is_in_group('player'):
		for x in range(size.x):
			for y in range(size.y):
				color = image.get_pixel(x, y)
				if color.a > 0.1:
					if x < left:
						left = x
					if x > right:
						right = x
					if y < top:
						top = y
					if y > bottom:
						bottom = y

		collision_shape = CollisionShape2D.new()
		var capsule_shape = CapsuleShape2D.new()
		capsule_shape.radius = right - left
		capsule_shape.height = bottom - top
		collision_shape.shape = capsule_shape

	else:
		var points: PackedVector2Array
		
		for x in range(size.x):
			for y in range(size.y):
				color = image.get_pixel(x,y)
				if (color.a > 0.1):
					points.append(Vector2(x, y))

		collision_shape = CollisionPolygon2D.new()
		collision_shape.build_mode = CollisionPolygon2D.BUILD_SEGMENTS
		collision_shape.polygon = points
	
	owner.add_child.call_deferred(collision_shape)
