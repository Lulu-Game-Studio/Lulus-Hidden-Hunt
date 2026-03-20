extends CharacterBody2D
class_name Player

const WALK_SPEED = 250.0
const RUN_SPEED = 400.0

@onready var player = $Dog
var current_state = "idle"
var movement_state = "idle"
var facing_dir = 1

@onready var audio = $AudioStreamPlayer2D

func _ready():
	player.play("idle")

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var is_running = Input.is_key_pressed(KEY_SHIFT)
	var speed = RUN_SPEED if is_running else WALK_SPEED
	velocity = direction * speed
	move_and_slide()
	
	if current_state == "bark":
		if player.frame == 4:
			audio.stream = preload("res://Texture/Sounds/Sounds/bark.mp3")
			audio.play()
	
	if direction.x != 0:
		facing_dir = 1 if direction.x > 0 else -1
	
	player.scale.x = facing_dir
	
	if direction.length() > 0:
		movement_state = "run" if is_running else "walk"
	else:
		movement_state = "idle"
	
	if Input.is_action_just_pressed("bark"):
		if current_state != "bark":
			current_state = "bark"
			player.play("bark")
	
	if current_state != "bark":
		if movement_state != current_state:
			current_state = movement_state
			player.play(current_state)
	else:
		if movement_state != "idle":
			current_state = movement_state
			player.play(current_state)
	
	if Input.is_action_just_pressed("hint"):
		Signals.hint_used.emit()

func _on_dog_animation_finished():
	if current_state == "bark":
		Signals.bark.emit()
		current_state = movement_state
		player.play(current_state)
