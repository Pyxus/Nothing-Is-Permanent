tool
extends Node2D

signal body_entered(body, cell_coord)

export var texture: Texture
export var grid_size: Vector2 setget set_grid_size
export var cell_size: Vector2 setget set_cell_size
export(Array,Texture) var TEXTURE_VARIATIONS_ARRAY: Array = [
	preload("res://FloorTextures/000.png"),
	preload("res://FloorTextures/001.png"),
	preload("res://FloorTextures/002.png"),
	preload("res://FloorTextures/003.png"),
	preload("res://FloorTextures/004.png"),
	preload("res://FloorTextures/005.png"),
	preload("res://FloorTextures/006.png"),
	preload("res://FloorTextures/007.png"),
	preload("res://FloorTextures/008.png"),
	preload("res://FloorTextures/009.png"),
	preload("res://FloorTextures/010.png"),
	preload("res://FloorTextures/011.png"),
	preload("res://FloorTextures/012.png"),
	preload("res://FloorTextures/013.png"),
	preload("res://FloorTextures/014.png"),
	preload("res://FloorTextures/015.png"),
	preload("res://FloorTextures/016.png"),
	preload("res://FloorTextures/017.png"),
	preload("res://FloorTextures/018.png"),
	preload("res://FloorTextures/019.png"),
	preload("res://FloorTextures/020.png"),
	preload("res://FloorTextures/021.png"),
	preload("res://FloorTextures/022.png"),
	preload("res://FloorTextures/023.png"),
	preload("res://FloorTextures/024.png"),
	preload("res://FloorTextures/025.png"),
	preload("res://FloorTextures/026.png"),
	preload("res://FloorTextures/027.png"),
	preload("res://FloorTextures/028.png"),
	preload("res://FloorTextures/029.png"),
	preload("res://FloorTextures/030.png"),
	preload("res://FloorTextures/031.png"),
	preload("res://FloorTextures/033.png"),
	preload("res://FloorTextures/034.png"),
	preload("res://FloorTextures/035.png"),
	preload("res://FloorTextures/036.png"),
	preload("res://FloorTextures/037.png"),
	preload("res://FloorTextures/038.png"),
	preload("res://FloorTextures/039.png"),
]
func _draw() -> void:
	if Engine.editor_hint:
		for y in grid_size.y:
			for x in grid_size.x:
				var cell_pos := Vector2(x * cell_size.x, y * cell_size.y)
				draw_rect(Rect2(cell_pos, cell_size), Color(randf(), randf(), randf(), .5))

func get_grid_size():
	return grid_size
func no_remaining_spawns():
	for x in grid_size.x:
		var currCell = get_cell(x,0)
		print(currCell)
		if(not is_dead_cell(currCell)):
			return false
	return true
func spawn_rose_bushes():
	for y in grid_size.y:
		for x in grid_size.x:
			var currCell = get_cell(x,y)
			if is_dying_cell(currCell):
				kill_cell(currCell)


func set_dying(cell):
	get_parent().get_node("Sizzle").play()
	set_cell_texture(cell, preload("res://FloorTextures/dyingCell.png"))
	
func kill_cell(cell):
	set_cell_texture(cell, preload("res://FloorTextures/deadCell.png"))			

static func is_dead_cell(cell):
	if(cell.get_node("TextureRect").texture == preload("res://FloorTextures/deadCell.png")):
		return true
	return false

func set_cell_as_grass(cell):
	cell.get_node("TextureRect").texture = get_random_ground_texture()
	
	
func is_dying_cell(cell):
	if(not cell or cell.get_node("TextureRect").texture == preload("res://FloorTextures/dyingCell.png")):
		return true
	return false

func is_spawn_cell(cell):
	if(is_dying_cell(cell) or is_dead_cell(cell)):
		return false
	return true
	
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
				
				texture_rect.name = "TextureRect"
				texture_rect.texture = get_random_ground_texture()
				texture_rect.expand = true
				shape.extents = cell_size / 2
				collision.shape = shape
				collision.position = cell_size / 2
				area.position = Vector2(x * cell_size.x, y * cell_size.y)
				texture_rect.rect_size = cell_size


func set_cell_texture(cell, texture: Texture) -> void:
	cell.get_node("TextureRect").texture = texture
	
	
func get_random_ground_texture():
	if TEXTURE_VARIATIONS_ARRAY.size() >1:
		var texture_id: int = randi() % TEXTURE_VARIATIONS_ARRAY.size()
		var chosen_texture: Texture = TEXTURE_VARIATIONS_ARRAY[texture_id]
		return chosen_texture

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
