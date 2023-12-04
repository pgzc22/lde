extends CharacterBody2D


@export var jump_velocity : float = -700.0
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var previous_direction : Vector2 = Vector2.ZERO
var speed : Vector2 = Vector2(50000, 50000)
var straight : bool = true


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity.x = direction.x * speed.x * delta
	else:
		velocity.x = move_toward(velocity.x, 0, speed.x * delta)

	move_and_slide()
	animated_sprite.flip_h = true
	update_animation()

func update_animation():
	if velocity == Vector2.ZERO:
		animated_sprite.play("stand")
	else:
		if not is_on_floor():
			if velocity.y <0:
				animated_sprite.play("jump")
			elif velocity.y >= 0:
				animated_sprite.play("fall")
		else:
			if direction.x > 0:
				animated_sprite.play("dash")
				straight = true
			elif direction.x < 0:
				animated_sprite.play("back_dash")
				straight = false

#func update_facing_direction():
#	if velocity.x > 0:
#		if animated_sprite.flip_h == false:
#			animated_sprite.flip_h = true
#			switch_animation("direction change")
#		else :
#			animated_sprite.flip_h = true
#	elif velocity.x < 0:
#		if animated_sprite.flip_h == true:
#			animated_sprite.flip_h = false
#			switch_animation("direction change")
#		else :
#			animated_sprite.flip_h = false
#	if velocity.y <= 0:
#		if !straight:
#			straight = true
#			switch_animation("down to up")
#	else:
#		if straight:
#			straight = false
#			switch_animation("up to down")
#
#
#func switch_animation(switch) -> void:
#	animated_sprite.play(switch)
#	await animated_sprite.animation_finished
#	update_animation()
