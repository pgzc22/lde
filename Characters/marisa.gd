extends CharacterBody2D

#@export var speed : float = 300.0
@export var jump_velocity : float = -400.0
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var previous_direction : Vector2 = Vector2.ZERO
var speed : Vector2 = Vector2(300, 300)
var straight : bool = true
var bullet_scene = preload("res://Projectiles/marisa_bullet.tscn")
var target = position


func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	# Handle Jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
	#	velocity.y = jump_velocity
	
	if Input.is_action_pressed("attack"):
		target = get_global_mouse_position()
		attack()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	# Marisa has an exponentially accelerated velocity and keeps some of it if she keeps moving
	# It should transform horizontal momentum into vertical one and vice versa
	# The issue with that is that the mechanic can be easily abused by pressing up and down quickly while moving laterally
	# This gives a massive speed boost which is not the intended behaviour, because speed goes back to 1500 every time
	# By transforming some horizontal momentum into horizontal momentum in the opposite direction and vice versa
	# we avoid the issue, it might seem it would behave erraticaly but it seems to work quite nicely.
	if direction:
		# If it has changed directions
		if previous_direction.x>=0 && direction.x<0 || previous_direction.x<=0 && direction.x>0:
			if speed.x * 0.9 > 1500:
				speed.x = speed.x * 0.9
			else:
				speed.x = 1500
			velocity.x = 0
		else:
			speed.x += 20
		if previous_direction.y>=0 && direction.y<0 || previous_direction.y<=0 && direction.y>0:
			if speed.y * 0.9 > 1500:
				speed.y = speed.y * 0.9
			else:
				speed.y = 1500
			velocity.y = 0
		else:
			speed.y += 20
		velocity.x += direction.x * speed.x * delta
		velocity.y += direction.y * speed.y * delta
	else:
		#velocity.x = move_toward(velocity.x, 0, speed * delta)
		#velocity.y = move_toward(velocity.y, 0, speed * delta)
		speed.x = 0
		speed.y = 0
		velocity.x = 0
		velocity.y = 0
	previous_direction = (direction)
	
	move_and_slide()
	update_facing_direction()

func attack():
	var bullet = bullet_scene.instantiate()
	bullet.global_position =  $Marker2D.global_position
#	print (position)
#	print (get_global_mouse_position())
#	print (direction)
#	print (global_position)
	bullet.direction.x = get_global_mouse_position().x - position.x
	bullet.direction.y = get_global_mouse_position().y - position.y
	# Enable the _process() function
	bullet.set_process(true)
	# Enable the _physics_process() function
	bullet.set_physics_process(true)
	get_parent().add_child(bullet)
#	bullet.look_at(get_global_mouse_position())
#	get_parent().add_child(new_bullet)
#	new_bullet.start(animated_sprite.global_position, rotation)
#	print(get_global_mouse_position())
#	print(animated_sprite.global_position)
#	print((get_global_mouse_position()-animated_sprite.position).normalized())
#	print((get_global_mouse_position() - animated_sprite.global_position).normalized() * speed)
#	print(speed)
#	new_bullet.bullet_velocity = (get_global_mouse_position() - animated_sprite.global_position).normalized() * speed
#	new_bullet.global_position = animated_sprite.global_position
#	get_parent().add_child(new_bullet)
	
	
func update_animation():
	if velocity == Vector2.ZERO:
		animated_sprite.play("stop")
	else:
		if velocity.y <= 0:
			animated_sprite.play("moving")
			straight = true
		else:
			animated_sprite.play("down")
			straight = false

func update_facing_direction():
	if velocity.x > 0:
		if animated_sprite.flip_h == false:
			animated_sprite.flip_h = true
			switch_animation("direction change")
		else :
			animated_sprite.flip_h = true
	elif velocity.x < 0:
		if animated_sprite.flip_h == true:
			animated_sprite.flip_h = false
			switch_animation("direction change")
		else :
			animated_sprite.flip_h = false
	if velocity.y <= 0:
		if !straight:
			straight = true
			switch_animation("down to up")
	else:
		if straight:
			straight = false
			switch_animation("up to down")
			

func switch_animation(switch) -> void:
	animated_sprite.play(switch)
	await animated_sprite.animation_finished
	update_animation()
	
#func _on_animated_sprite_2d_animation_finished():
#	if(animated_sprite.animation == "direction change"):
#		animation_locked = false
