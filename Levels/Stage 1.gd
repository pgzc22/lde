extends Node2D


var reimu: CharacterBody2D
var marisa: CharacterBody2D
var current_character: CharacterBody2D
var switch_key: int = KEY_CTRL

# Called when the node enters the scene tree for the first time.
func _ready():
	reimu = $Reimu
	marisa = $Marisa
	current_character = reimu
	marisa.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("character_switch"):
		switch_character()

func switch_character():
	var temp_velocity = current_character.velocity
	if current_character == reimu:
		var marisa_scene = load("res://Characters/marisa.tscn")
		reimu.queue_free()
		marisa = marisa_scene.instantiate()
		current_character = marisa
		current_character.global_position = reimu.global_position
		current_character.velocity = temp_velocity
		self.add_child(current_character)
	elif current_character == marisa:
		var reimu_scene = load("res://Characters/reimu.tscn")
		marisa.queue_free()
		reimu = reimu_scene.instantiate()
		current_character = reimu
		current_character.global_position = marisa.global_position
		current_character.velocity = temp_velocity
		self.add_child(current_character)

# So the camera's fucked, the idea now it's to make the camera follow an independent sprite without controls or hitbox, that moves at (maybe?) constant velocity
# Actually let's just make it follow the boss. Why didn't I think of this sooner?
# Okay so the boss will keep at a distance from the player which fluctuates in a range + it has its own movement
# So the camera won't follow the boss after all, tried it and it just gets too crazy to follow and makes you unable to move properly (because you've got to keep going)
# also, it makes it extremely difficult to balance. Camera will be static and the world will move instead.
# Bullets will belong to the world, not to the characters
