extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer.get_node("TextureRect").visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass






func _on_quit_pressed():
	print ("game quit")
	get_tree().change_scene("res://menu.tscn")
	pass # Replace with function body.


func _on_retry_pressed():
	print ("fresh start")
	get_tree().change_scene("res://Level1.tscn")
	pass # Replace with function body.

func _on_VideoPlayer_finished():
	$CanvasLayer.get_node("TextureRect").visible = true
