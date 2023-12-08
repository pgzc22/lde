extends Control




func _on_play_pressed():
	get_tree().change_scene_to_file("res://Levels/stage_1.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Levels/settings.tscn")
