tool
extends Node2D

signal body_entered(body, cell_coord)

export var grid_size: Vector2 setget set_grid_size
export var cell_size: Vector2 setget set_cell_size

func _draw() -> void:
	if Engine.editor_hint:
		for x in grid_size.x:
			for y in grid_size.y:
				var cell_pos := Vector2(x * cell_size.x, y * cell_size.y)
				draw_rect(Rect2(cell_pos, cell_size), Color(randf(), randf(), randf(), .5))


func _ready() -> void:
	if not Engine.editor_hint:
		for x in grid_size.x:
			for y in grid_size.y:
				var area := Area2D.new()
				var collision := CollisionShape2D.new()
				var shape := RectangleShape2D.new()

				shape.extents = cell_size
				collision.shape = shape
				area.position = Vector2(x * cell_size.x, y * cell_size.y)

				add_child(area)
				area.add_child(collision)
				area.connect("body_entered", self, "_on_Area_body_entered", [Vector2(x, y)])
				


func set_grid_size(value: Vector2) -> void:
	grid_size.x = value.x
	grid_size.y = value.y
	update()


func set_cell_size(value: Vector2) -> void:
	cell_size = value
	update()
	

func _on_Area_body_entered(body: PhysicsBody2D, cell_coord: Vector2) -> void:
	emit_signal("body_entered", body, cell_coord)
