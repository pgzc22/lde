extends AnimatableBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	$AnimationPlayer.play("pong")
#	var direction = target_pos - position
#	if direction.length() > speed * delta:
#		var velocity = direction.normalized() * speed * delta
#	else:
#		if target_pos == Vector2(103, 466):
#			target_pos = Vector2(649, 929)
#		elif target_pos == Vector2(649, 929):
#			target_pos = Vector2(103, 466)
#	move_and_slide()
#	# Calculate the direction vector from the current position to the target position
#	var direction = global_position.direction_to(target_pos)
#	# Multiply the direction vector by the speed and delta time to get the velocity vector
#	var velocity = direction * speed * delta
#	# Move the Area by adding its velocity to its position
#	position += velocity
#	direction = target_pos - position
#	if direction.length() > speed * delta:
#		velocity = direction.normalized() * speed * delta
#	else:
#		position = target_pos
	
