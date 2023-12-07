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
var min_pos = Vector2(731, 246) # Top left corner of the area
var max_pos = Vector2(1542, 538) # Bottom right corner of the area
var target_pos = Vector2()
var speed = 500 # Speed of the character
#var wait_time = 5.0 # Time to wait at each point # Not needed anymore as all the movement is scripted
var timer = 0.0
var phase = 0
var last_phase = 0
var health = 100
var phase_change : bool = false

func _ready():
	randomize()
	target_pos = Vector2(1512,575)

func _physics_process(delta):
	animated_sprite.play("idle")
	direction = target_pos - position
	if direction.length() > speed * delta:
		velocity = direction.normalized() * speed
	else:
		position = target_pos
		velocity=Vector2.ZERO
		timer += delta
		if timer >= last_phase+10:
			last_phase=last_phase+10
			phase+=1
		match phase:
			0:
				target_pos = Vector2(1512,575)
			1:
				target_pos = Vector2(1327,90)
			2:
				target_pos = Vector2(1592,862)
			3:
				target_pos = Vector2(1301,733)
			4:
				target_pos = Vector2(1397,414)
			5:
				target_pos = Vector2(1519,258)
			6:
				target_pos = Vector2(1730,155)
			7:
				target_pos = Vector2(1833,455)
			8:
				target_pos = Vector2(1454,189)
			9:
				target_pos = Vector2(1798,876)
			10:
				target_pos = Vector2(1300,791)
			11:
				target_pos = Vector2(1425,318)
			12:
				target_pos = Vector2(1638,349)
			13:
				target_pos = Vector2(1171,243)
			14:
				target_pos = Vector2(1697,295)
			15:
				target_pos = Vector2(994,166)
			16:
				target_pos = Vector2(509,169)
			17:
				target_pos = Vector2(817,578)
			18:
				target_pos = Vector2(1512,575)
				timer = 0
				last_phase=0
				phase=0
		print(phase_change)
		phase_change = phase_switcher(phase, phase_change, target_pos, position)
		speed = randi_range(250,300)
	move_and_slide()

func get_random_position():
	return Vector2(randf_range(min_pos.x, max_pos.x), randf_range(min_pos.y, max_pos.y))

func take_damage(dmg):
	health-=dmg
	if health<=0:
		queue_free()
		
func phase_switcher(phase, phase_change, target_pos, position):
	if phase == 0 or phase % 2 == 0:
		if !phase_change:
			if position == target_pos:
				Spawning.spawn({"position": Vector2(target_pos.x-65, target_pos.y), "rotation":0}, str(phase+1), "0")
				return !phase_change
	else:
		if phase_change:
			if position == target_pos:
				Spawning.spawn({"position": Vector2(target_pos.x-65, target_pos.y), "rotation":0}, str(phase+1), "0")
				return !phase_change
	return phase_change

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
