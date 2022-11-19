extends KinematicBody2D
var moveSpeed : int = 250
var defaultSpeed = 250
var vel : Vector2 = Vector2()
var facingDir : Vector2 = Vector2()
var hasKey = false
var hasWaterBucket = false
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
	vel = vel.normalized()

	# move the player
	move_and_slide(vel * moveSpeed)
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.name.begins_with("Wall") and hasKey:
			collision.collider.queue_free()
			hasKey = false
		if collision.collider.name.begins_with("Flower"):
			print("FUCK YOU")

func setKey(haveKey):
	hasKey = haveKey
