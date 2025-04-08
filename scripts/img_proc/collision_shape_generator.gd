extends Node


func _ready() -> void:
	var color: Color
	print("====" + OS.get_executable_path() + "====")
	print("====" + OS.get_executable_path().get_base_dir() + "====")
	if owner.is_in_group('player'):
		var image: Image
		if not Engine.is_editor_hint():
			image = Image.load_from_file("res://assets/Player.png")
		else:
			var exe_dir = OS.get_executable_path().get_base_dir()
			image = Image.load_from_file(exe_dir.path_join('/assets/Player.png'))
		var size: Vector2 = image.get_size()
		var left: int = size.x
		var right: int = 0
		var top: int = size.y
		var bottom: int = 0
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

		var collision_shape = CollisionShape2D.new()
		var capsule_shape = CapsuleShape2D.new()
		capsule_shape.radius = right - left
		capsule_shape.height = bottom - top
		collision_shape.shape = capsule_shape

		owner.add_child.call_deferred(collision_shape)
	else:
		var image: Image
		if not Engine.is_editor_hint():
			image = Image.load_from_file("res://assets/Platform.png")
		else:
			var exe_dir = OS.get_executable_path().get_base_dir()
			image = Image.load_from_file(exe_dir.path_join("assets/Platform.png"))
		var size: Vector2 = image.get_size()
		
		var segments := 50
			
		var x_segment := size.x / segments
		var y_segment := size.y / segments

		for i in range(segments):
			for j in range(segments):
				var points := PackedVector2Array()
				
				var x_start := int(i * x_segment)
				var x_end := int((i + 1) * x_segment)
				var y_start := int(j * y_segment)
				var y_end := int((j + 1) * y_segment)

				for x in range(x_start, x_end):
					for y in range(y_start, y_end):
						color = image.get_pixel(x, y)
						if color.a > 0.1:
							points.append(Vector2(x, y))

				var hull := Geometry2D.convex_hull(points)
				
				var collision_shape := CollisionPolygon2D.new()
				collision_shape.polygon = hull
				
				owner.call_deferred("add_child", collision_shape)
