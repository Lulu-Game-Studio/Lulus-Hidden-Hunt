extends DE
class_name DialogueText

@export var speaker_img: Texture
@export var speaker_img_Hframes = 1
@export var speaker_img_rest_frame = 0

@export_multiline var text = ""
@export_range(0.1, 30.0, 0.1) var text_speed = 1.0

@export var camera_position: Vector2 = Vector2(999.999, 999.999)
@export_range(0.05, 10.0, 0.05) var camera_transition_time = 1.0
