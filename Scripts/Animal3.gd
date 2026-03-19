extends StaticBody2D

# Movement speed of the object
var speed = 350

# Direction in which the object will move
var direction = Vector2.ZERO

# Controls if the object is currently moving
var active = false

# Tracks how far the object has moved
var distance = 0

# Maximum distance before the object is deleted
var max_distance = 4000

# Reference to the AnimatedSprite2D node
@onready var animal = $AnimatedSprite2D


func _ready():
	# Start animation in idle state
	animal.play("idle")


func _physics_process(delta):
	# If not active do nothing
	if not active:
		return
	
	# Calculate movement based on direction and speed
	var move = direction * speed * delta
	
	# Play running animation while moving
	animal.play("run")
	
	# Flip/scale sprite on X axis
	animal.scale.x = -6.288
	
	# Move the object
	position += move
	
	# Add traveled distance
	distance += move.length()
	
	# Remove object when it reaches max distance
	if distance >= max_distance:
		queue_free()


func scatter(dir: Vector2):
	# Set movement direction
	direction = dir

	# Activate movement
	active = true
