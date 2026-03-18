extends Control

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scene/Levels/Level1.tscn")


func _on_controls_button_pressed():
	get_tree().change_scene_to_file("res://Scene/Controls.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
