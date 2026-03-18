extends CanvasLayer

@onready var label = $Container/Objects
@onready var sprite = $Sprite2D

var objects = 0
var max_objects = 3

func _ready():
	Signals.object_collected.connect(_on_object_collected)

func _on_object_collected():
	objects += 1
	label.text = str(objects)

func set_object_texture(texture):
	sprite.texture = texture
