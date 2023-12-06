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
		dmg = 2
	else:
		dmg = 3
		duration = 1.7
		speed = 40000

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
