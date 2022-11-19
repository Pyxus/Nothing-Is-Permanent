tool
extends Node2D

signal body_entered(body, cell_coord)

export var texture: Texture
export var grid_size: Vector2 setget set_grid_size
export var cell_size: Vector2 setget set_cell_size

func _draw() -> void:
	if Engine.editor_hint:
		for y in grid_size.y:
			for x in grid_size.x:
				var cell_pos := Vector2(x * cell_size.x, y * cell_size.y)
				draw_rect(Rect2(cell_pos, cell_size), Color(randf(), randf(), randf(), .5))


func _ready() -> void:
	if not Engine.editor_hint:
		for y in grid_size.y:
			for x in grid_size.x:
				var area := Area2D.new()
				var collision := CollisionShape2D.new()
				var shape := RectangleShape2D.new()
				var texture_rect := TextureRect.new()
				
				add_child(area)
				area.add_child(texture_rect)
				area.add_child(collision)
				area.connect("body_entered", self, "_on_Area_body_entered", [Vector2(x, y)])
				
				texture_rect.texture = texture
				texture_rect.expand = true
				shape.extents = cell_size / 2
				collision.shape = shape
				collision.position = cell_size / 2
				area.position = Vector2(x * cell_size.x, y * cell_size.y)
				texture_rect.rect_size = cell_size


func get_cell(cell_x: int, cell_y: int) -> Area2D:
	var x := 0
	var y := 0
	
	for child in get_children():
		if cell_x == x and cell_y == y:
			return child
		
		x += 1
		if x % int(grid_size.x) == 0:
			y += 1
			x = 0

	return null


func set_grid_size(value: Vector2) -> void:
	grid_size.x = value.x
	grid_size.y = value.y
	update()


func set_cell_size(value: Vector2) -> void:
	cell_size = value
	update()
	

func _on_Area_body_entered(body: PhysicsBody2D, cell_coord: Vector2) -> void:
	emit_signal("body_entered", body, cell_coord)
