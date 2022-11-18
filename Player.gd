extends KinematicBody2D
var moveSpeed : int = 250
var defaultSpeed = 250
var vel : Vector2 = Vector2()
var facingDir : Vector2 = Vector2()
onready var rayCast = get_node("RayCast2D")
var canDash = true
var dashing = false

func _physics_process(delta):
	moveSpeed = defaultSpeed
  
	var vel = Vector2()
	  
	  # inputs
	if Input.is_action_pressed("move_up"):
		vel.y -= 1
		facingDir = Vector2(0, -1)

	if Input.is_action_pressed("move_down"):
		vel.y += 1
		facingDir = Vector2(0, 1)

	if Input.is_action_pressed("move_left"):
		vel.x -= 1
		facingDir = Vector2(-1, 0)

	if Input.is_action_pressed("move_right"):
		vel.x += 1
		facingDir = Vector2(1, 0)
	
	if Input.is_action_pressed("dash") and canDash:
		print("Dash")
		vel = facingDir.normalized() *999999999999
		canDash = false
		dashing = true
		yield(get_tree().create_timer(2), "timeout")
		dashing = false
		canDash = true
	vel = vel.normalized()

	# move the player
	move_and_slide(vel * moveSpeed)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		print(collision)
		if(collision.collider.name.begins_with("Platform")):
			print("hello player")


func _on_Platform_area_entered(area):
	print("hello Player")
	pass # Replace with function body.
