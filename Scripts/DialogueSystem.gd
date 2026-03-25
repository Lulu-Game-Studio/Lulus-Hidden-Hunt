extends Node2D

@onready var DialogueLabel: RichTextLabel = $HBoxContainer/VBoxContainer/RichTextLabel
@onready var SpeakerSprite: Sprite2D = $HBoxContainer/SpeakerParent/Sprite2D

var dialogue: Array[DE] = []
var current_dialogue_item = 0
var next_item = true

var player_node: CharacterBody2D = null

func _ready():
	visible = false
	player_node = get_tree().get_first_node_in_group("player")

func _process(_delta):
	if current_dialogue_item >= dialogue.size():
		if player_node:
			player_node.can_move = true
		queue_free()
		return
	
	if next_item:
		next_item = false
		var i = dialogue[current_dialogue_item]
		
		if i is DialogueText:
			visible = true
			_text_resource(i)
		else:
			current_dialogue_item += 1
			next_item = true

func _text_resource(i: DialogueText):
	var camera: Camera2D = get_viewport().get_camera_2d()
	if camera and i.camera_position != Vector2(999.999, 999.999):
		var camera_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		camera_tween.tween_property(camera, "global_position", i.camera_position, i.camera_transition_time)
	
	if i.speaker_img:
		$HBoxContainer/SpeakerParent.visible = true
		SpeakerSprite.texture = i.speaker_img
		SpeakerSprite.hframes = i.speaker_img_Hframes
		SpeakerSprite.frame = 0
	else:
		$HBoxContainer/SpeakerParent.visible = false
	
	DialogueLabel.text = i.text
	DialogueLabel.visible_characters = 0
	
	var text_clean = _text_without_square_brackets(i.text)
	var total = text_clean.length()
	
	await get_tree().process_frame
	
	while DialogueLabel.visible_characters < total:
		if Input.is_action_just_pressed("ui_accept"):
			DialogueLabel.visible_characters = total
			break
		DialogueLabel.visible_characters += 1
		await get_tree().process_frame
	
	await get_tree().process_frame
	
	var is_waiting = true
	while is_waiting:
		if Input.is_action_just_pressed("ui_accept"):
			is_waiting = false
		await get_tree().process_frame
	
	current_dialogue_item += 1
	next_item = true

func _text_without_square_brackets(text):
	var result = ""
	var inside_bracket = false
	for c in text:
		if c == "[":
			inside_bracket = true
			continue
		if c == "]":
			inside_bracket = false
			continue
		if not inside_bracket:
			result += c
	return result
