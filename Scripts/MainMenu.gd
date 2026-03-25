extends Control

# Called when the Play button is pressed
func _on_play_button_pressed():
	# Change scene to Level 1
	get_tree().change_scene_to_file("res://Scene/Levels/Level1.tscn")


func _on_controls_button_pressed():
	# Change scene to Controls screen
	get_tree().change_scene_to_file("res://Scene/Controls.tscn")


func _on_quit_button_pressed():
	# Quit the game
	get_tree().quit()
