extends CharacterBody2D


@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
#var speed = 50000 # The base speed of the character
#var target = null # The target character
#var min_x_velocity = -400 # The minimum random x velocity
#var max_x_velocity = 5000 # The maximum random x velocity
#var min_y_position = 0 # The minimum random y position
#var max_y_position = 6000 # The maximum random y position

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = Vector2.ZERO
var min_pos = Vector2(1150, 29) # Top left corner of the area
var max_pos = Vector2(1815, 635) # Bottom right corner of the area
var target_pos = Vector2()
var speed = 500 # Speed of the character
var wait_time = 5.0 # Time to wait at each point
var timer = 0.0

func _ready():
	randomize()
	target_pos = get_random_position()

func _physics_process(delta):
	animated_sprite.play("idle")
	direction = target_pos - position
	if direction.length() > speed * delta:
		velocity = direction.normalized() * speed
	else:
		position = target_pos
		velocity=Vector2.ZERO
		timer += delta
		if timer >= wait_time:
			timer = 0
			target_pos = get_random_position()
			speed = randi_range(100,1000)
	move_and_slide()

func get_random_position():
	return Vector2(randf_range(min_pos.x, max_pos.x), randf_range(min_pos.y, max_pos.y))


#func _physics_process(delta):
#	if get_parent().current_character == get_parent().reimu:
#		target = get_parent().reimu
#	elif get_parent().current_character == get_parent().marisa:
#		target = get_parent().marisa
#	speed = randi_range(25000, 75000)
#	velocity.x = speed * delta
##	var direction = 1 if position.x < target.position.x else -1
##	var distance = abs(position.x - target.position.x)
##	var x_velocity = rand_range(min_x_velocity, max_x_velocity)
##	var y_position = rand_range(min_y_position, max_y_position)
##	var velocity = Vector2(direction * (speed + x_velocity * distance), y_position - position.y).normalized() * speed
##	position += velocity * delta
#	animated_sprite.play("idle") # Replace with the name of your walking animation

	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)


	move_and_slide()
	
#	animated_sprite.position = get_parent().current_character.position + own_movement
