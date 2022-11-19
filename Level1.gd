extends Node2D

const Player = preload("Player.gd")
const AreaGrid = preload("AreaGrid.gd")

onready var _area_grid: AreaGrid = $AreaGrid


func _ready() -> void:
	_area_grid.connect("body_entered", self, "_on_AreaGrid_body_entered")
	

func _on_AreaGrid_body_entered(body: PhysicsBody2D, coord: Vector2) -> void:
	if body is Player:
		_area_grid.get_cell(coord.x, coord.y).modulate = Color.red
		
