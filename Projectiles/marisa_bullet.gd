extends CharacterBody2D

var speed = 100000
var direction = Vector2.ZERO
var duration = 1
var dmg = 1


func _ready():
	set_process(true)
	set_physics_process(true)
	$AnimatedSprite2D.set_frame(randi_range(0,6))
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func _process(delta):
	if $AnimatedSprite2D.animation=="shot":
		dmg = 1
	else:
		dmg = 4
		duration = 1.7
		speed = 50000

func _physics_process(delta):
	# Holy shit it fucking moves now after all fuck this crap, that was like what, 5 fucking days worth of work?
	direction = direction.normalized()
	velocity.x = direction.x * speed * delta
	velocity.y = direction.y * speed * delta
	duration -= delta
	if duration <= 0:
		queue_free()
	move_and_slide()
	
func _on_area_2d_body_entered(body):
	# "body" here is the thing that we've hit
	# Here we check if the body is a player, so we know to deal damage to them
	# There are other ways to do this including class names and collision layers
	if body.is_in_group("enemies"):
		# You need to make sure your player has a "take_damage" function
		body.take_damage(dmg)
		queue_free()
#	var collision = move_and_collide(velocity * speed * delta)
#	if collision:
#		velocity = velocity.bounce(collision.get_normal())
#		if collision.get_collider().has_method("hit"):
#			collision.get_collider().hit()

#func _on_VisibilityNotifier2D_screen_exited():
#	# Deletes the bullet when it exits the screen.
#	queue_free()

#func _on_body_entered(body):
#	# "body" here is the thing that we've hit
#	# Here we check if the body is a player, so we know to deal damage to them
#	# There are other ways to do this including class names and collision layers
#	if body.is_in_group("enemies"):
#		# You need to make sure your player has a "take_damage" function
#		body.take_damage(1)
#		queue_free()
		

##var speed = 750
##
##func start(_position, _direction):
##	rotation = _direction
##	position = _position
##	velocity = Vector2(speed, 0).rotated(rotation)
#
#func _physics_process(delta):
#	var collision = move_and_collide(velocity * delta)
#	if collision:
#		velocity = velocity.bounce(collision.get_normal())
#		if collision.get_collider().has_method("hit"):
#			collision.get_collider().hit()
#
#func _on_VisibilityNotifier2D_screen_exited():
#	# Deletes the bullet when it exits the screen.
#	queue_free()
#
#@export var bullet_velocity = Vector2.ZERO
#var duration = 20
#
#func _ready() -> void:
#	connect("body_entered", Callable(self, "_on_body_entered"))
#
#func _physics_process(delta: float) -> void:
#	position += bullet_velocity * delta
#	duration -= delta
#	if duration <= 0:
#		queue_free() 
#
#func _on_body_entered(body):
#	# "body" here is the thing that we've hit
#	# Here we check if the body is a player, so we know to deal damage to them
#	# There are other ways to do this including class names and collision layers
#	if body.is_in_group("players"):
#		# You need to make sure your player has a "take_damage" function
#		body.take_damage(1)
#		queue_free()
#
#func set_bullet_velocity(vel):
#	bullet_velocity = vel
#
#func set_bullet_position(pos):
#	position = pos
