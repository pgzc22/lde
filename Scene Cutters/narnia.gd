extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("players"):
		if get_parent().get_name()=="Stage 2":
			body.next_level(2)
		elif get_parent().get_name()=="Stage 3":
			body.next_level(3)
		else:
			body.next_level(1)
