extends CanvasLayer

# UI label that shows collected objects
@onready var label = $Container/Objects

# UI sprite that displays an image
@onready var sprite = $Sprite2D

# UI label that shows remaining hints
@onready var hints_label = $Container2/Hints

# Number of collected objects
var objects = 0


func _ready():
	# Connect signal when an object is collected
	Signals.object_collected.connect(_on_object_collected)


func _on_object_collected():
	# Increase collected objects count
	objects += 1
	
	# Update UI text
	label.text = str(objects)


func set_object_texture(texture):
	# Change the UI sprite texture
	sprite.texture = texture


func update_hints(value):
	# Update hints text in UI
	hints_label.text = str(value)
