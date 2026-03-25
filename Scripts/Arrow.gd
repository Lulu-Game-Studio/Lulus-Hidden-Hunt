extends Node2D

# The object this node is pointing to
var target = null

# Reference to the Player node in the parent
@onready var player = get_parent().get_node("Player")

# Reference to the ArrowPoint node inside the player
@onready var arrow_point = player.get_node("ArrowPoint")


func setup(t):
	# Set the target this arrow will follow
	target = t


func _process(delta):
	# If there is no target or it is no longer valid, delete this node
	if target == null or not is_instance_valid(target):
		queue_free()
		return
	
	# Keep this node at the arrow point position
	global_position = arrow_point.global_position
	
	# Calculate direction from arrow to target
	var direction = (target.global_position - global_position).normalized()
	
	# Rotate arrow to face the target direction
	rotation = direction.angle()
