extends Control



func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main menu/main_menu.gd")  # returns back to the main menu scene
