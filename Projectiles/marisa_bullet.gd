extends CharacterBody2D

var bullet_velocity = Vector2.ZERO
var duration = 20
 
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
 
func _physics_process(delta: float) -> void:
	position += bullet_velocity * delta
	
	duration -= delta
	if duration <= 0:
		queue_free() 
 
func _on_body_entered(body):
	# "body" here is the thing that we've hit
	# Here we check if the body is a player, so we know to deal damage to them
	# There are other ways to do this including class names and collision layers
	if body.is_in_group("players"):
		# You need to make sure your player has a "take_damage" function
		body.take_damage(1)
		queue_free()
