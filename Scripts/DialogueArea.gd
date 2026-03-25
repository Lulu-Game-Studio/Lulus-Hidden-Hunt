extends Area2D

const DialogueSystemPreload = preload("res://Assets/DialogueSystem.tscn")

@export var activate_instant: bool
@export var only_activate_once: bool
@export var override_dialogue_position: bool
@export var override_position: Vector2
@export var dialogue: Array[DE]

var dialogue_top_pos: Vector2 = Vector2(0, -60) 
var dialogue_bottom_pos: Vector2 = Vector2(0, 65)

var player_body_in = false
var has_activated_already = false
var desired_dialogue_pos: Vector2

var player_node: CharacterBody2D = null

var active_dialogue: Node = null 

func _ready():
	player_node = get_tree().get_first_node_in_group("player")

func _process(_delta):
	if !player_node:
		player_node = get_tree().get_first_node_in_group("player")
		return
	
	if only_activate_once and has_activated_already:
		return
	
	if player_body_in and Input.is_action_just_pressed("ui_accept"):
		_activate_dialogue()

func _activate_dialogue():
	if has_activated_already and only_activate_once:
		return
	
	if is_instance_valid(active_dialogue):
		return
	
	has_activated_already = true
	if player_node:
		player_node.can_move = false
	
	var new_dialogue = DialogueSystemPreload.instantiate()
	active_dialogue = new_dialogue
	new_dialogue.dialogue = dialogue
	
	var camera = get_viewport().get_camera_2d()
	if camera:
		camera.add_child(new_dialogue)
		
		if override_dialogue_position:
			new_dialogue.position = override_position
		else:
			var view_size = get_viewport_rect().size
			
			var bottom_y = (view_size.y / 2) - 80 
			
			new_dialogue.position = Vector2(0, bottom_y)
	else:
		get_tree().current_scene.add_child(new_dialogue)
		new_dialogue.global_position = player_node.global_position

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_body_in = true
		if activate_instant and not has_activated_already:
			_activate_dialogue()

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_body_in = false
