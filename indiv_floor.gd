extends Area2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func set_texture(texture):
	$TextureRect.texture = texture

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if(is_within_Area2D(get_parent().get_parent().get_node("Player").position)):
		set_dying()
		
func set_dying():
	var texture = $TextureRect.texture
	if(texture != preload("res://Assets/FloorTextures/dyingCell.png")):
		texture = preload("res://Assets/FloorTextures/dyingCell.png")

func is_within_Area2D(pos):
	if(name == "Floor2"):
		print("========================")
		print(pos.x)
		print(pos.y)
		
		print("++++++++++++++++++++++++++++")
		print(position.x)
		print(position.y)
	var x = position.x
	var y = position.y
	
	var player_x = pos.x
	var player_y = pos.y
	if(x-100<player_x and player_x < x):
		return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
