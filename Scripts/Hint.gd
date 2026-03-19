extends Node

# Number of hints available to the player
var hints = 1

# Preloaded arrow scene used to point
var hint_arrow_scene = preload("res://Assets/Arrow.tscn")


func get_closest_object(player):
	# Get all collectible objects in the scene
	var objects = get_tree().get_nodes_in_group("collectibles")

	var closest = null
	var min_dist = INF

	# Loop through all collectibles to find the closest one
	for obj in objects:
		# Skip invalid objects
		if not is_instance_valid(obj):
			continue

		# Calculate distance from player to object
		var dist = player.global_position.distance_to(obj.global_position)

		# Store the closest object found
		if dist < min_dist:
			min_dist = dist
			closest = obj

	return closest


func use_hint(player, parent_node):
	# Check if player has hints available
	if hints <= 0:
		return false

	# Consume one hint
	hints -= 1

	# Get nearest collectible object
	var target = get_closest_object(player)
	if target == null:
		return false

	# Create arrow instance
	var arrow = hint_arrow_scene.instantiate()
	parent_node.add_child(arrow)

	# Set arrow starting position at player's arrow point
	var arrow_point = player.get_node("ArrowPoint")
	arrow.global_position = arrow_point.global_position

	# Assign target to arrow
	arrow.setup(target)

	return true


func reset_hints():
	# Reset hints back to default value
	hints = 1
