extends Control

# Called when the return button is pressed
func _on_return_button_pressed():
	# Change scene back to the main menu
	get_tree().change_scene_to_file("res://Scene/MainMenu.tscn")
