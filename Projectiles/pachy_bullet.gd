extends Area2D

@export var speed = 300
#var direction = Vector2.RIGHT
var dmg = 1

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_body_entered(body):
	if body.is_in_group("players"):
	# You need to make sure your player has a "take_damage" function
		body.take_damage(dmg)
		queue_free()
	elif body.is_in_group("objects"):
		queue_free()

func _on_timer_timeout():
	queue_free()


#extends CharacterBody2D
#
#var speed = 100000
#var direction = Vector2.ZERO
#var duration = 3
#var dmg = 1
#var rotation_speed = 0.1
#
#
#func _ready():
#	set_process(true)
#	set_physics_process(true)
#	connect("body_entered", Callable(self, "_on_body_entered"))
#
#
#func _physics_process(delta):
#	# Holy shit it fucking moves now after all fuck this crap, that was like what, 5 fucking days worth of work?
##	direction = Vector2.RIGHT.rotated(rotation_speed)
#	rotation_speed += 0.1
##	velocity.x = direction.x * speed * delta
##	velocity.y = direction.y * speed * delta
#	print(Vector2.RIGHT.rotated(rotation_speed))
#	velocity=Vector2(-50000*delta,50000*delta)
#	duration -= delta
#	if duration <= 0:
#		queue_free()
#	move_and_slide()


