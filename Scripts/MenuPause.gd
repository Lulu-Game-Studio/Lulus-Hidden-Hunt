extends CanvasLayer

func _ready():
	visible = false


func _process(delta):
	Esc()

func resume():
	get_tree().paused = false
	visible = false


func pause():
	get_tree().paused = true
	visible = true


func Esc():
	if Input.is_action_just_pressed("pause_menu") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause_menu") and get_tree().paused == true:
		resume()


func _on_resume_button_pressed():
	resume()


func _on_restart_button_pressed():
	resume()
	get_tree().reload_current_scene()


func _on_quit_button_pressed():
	resume()
	get_tree().call_deferred("change_scene_to_file", "res://Scene/MainMenu.tscn")
