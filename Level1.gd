extends Node2D

const Player = preload("Player.gd")
const AreaGrid = preload("AreaGrid.gd")

onready var _area_grid: AreaGrid = $AreaGrid


func _ready() -> void:
	_area_grid.connect("body_entered", self, "_on_AreaGrid_body_entered")

func player_touched_flower():
	var areaGrid = get_node("AreaGrid")
	var spawnCell = null
	var spawnX
	var rng
	while(spawnCell == null):
		rng = RandomNumberGenerator.new()
		rng.randomize()
		spawnX = rng.randf_range(0, areaGrid.get_grid_size().x)
		spawnCell = areaGrid.get_cell(spawnX,0)
		if(not areaGrid.is_spawn_cell(spawnCell)):
			spawnCell = null
	$Player.position = spawnCell.position + Vector2(32,32)
	areaGrid.spawn_rose_bushes()

func _on_AreaGrid_body_entered(body: PhysicsBody2D, coord: Vector2) -> void:
	if body is Player:
		if _area_grid.is_dead_cell(_area_grid.get_cell(coord.x, coord.y)):
			kill_player()
		else:
			_area_grid.set_dying(_area_grid.get_cell(coord.x, coord.y))

func kill_player():
	get_tree().change_scene("res://game over screen.tscn")
	pass
