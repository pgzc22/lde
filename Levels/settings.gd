extends Control

var user = "Nanashi"
var onec : bool = false
var save_path = "user://data.json"

func _ready() -> void:
	save_json()
	

func save_json() -> void:
	var data := {
		"user": user,
		"onec": onec,
	}
	var json_data := JSON.stringify(data)
	var file_access := FileAccess.open(save_path, FileAccess.WRITE)
	file_access.store_line(json_data)
	file_access.close()

func _on_back_pressed():
	var data := {
		"user": user,
		"onec": onec,
	}
	var json_data := JSON.stringify(data)
	var file_access := FileAccess.open(save_path, FileAccess.WRITE)
	file_access.store_line(json_data)
	file_access.close()
	get_tree().change_scene_to_file("res://Levels/menu.tscn")

func _on_line_edit_text_submitted(new_text):
	user = new_text

func _on_check_box_toggled(button_pressed):
	onec = button_pressed
