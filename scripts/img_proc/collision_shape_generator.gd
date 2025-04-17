extends Node


@export
var _segment_count: int = 50


func _ready() -> void:
	var color: Color
	var image: Image
	var size: Vector2

	var assets_dir: String
	if Engine.is_editor_hint():
		assets_dir = OS.get_executable_path().get_base_dir().path_join('assets')
	else:
		assets_dir = 'res://assets'
	
	if owner.is_in_group('player'):
		image = Image.load_from_file(assets_dir.path_join('Player.png'))
		size = image.get_size()
		
		var left: float = size.x
		var right: float = 0
		var top: float = size.y
		var bottom: float = 0

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

		var collision_shape: CollisionShape2D = CollisionShape2D.new()
		var capsule_shape: CapsuleShape2D = CapsuleShape2D.new()
		
		capsule_shape.radius = right - left
		capsule_shape.height = bottom - top
		collision_shape.shape = capsule_shape

		owner.add_child.call_deferred(collision_shape)
	else:
		image = Image.load_from_file(assets_dir.path_join('Platform.png'))
		size = image.get_size()
		
		var x_segment: int = int(size.x / _segment_count)
		var y_segment: int = int(size.y / _segment_count)
		var collision_shape: CollisionPolygon2D
		
		for i in range(_segment_count):
			for j in range(_segment_count):
				var points: PackedVector2Array = PackedVector2Array()
				
				var x_start: int = i * x_segment
				var x_end: int = (i + 1) * x_segment
				var y_start: int = j * y_segment
				var y_end: int = (j + 1) * y_segment

				for x in range(x_start, x_end):
					for y in range(y_start, y_end):
						color = image.get_pixel(x, y)
						if color.a > 0.1:
							points.append(Vector2(x, y))

				var hull: PackedVector2Array = Geometry2D.convex_hull(points)
				
				collision_shape = CollisionPolygon2D.new()
				collision_shape.polygon = hull
				
				owner.add_child.call_deferred(collision_shape)
