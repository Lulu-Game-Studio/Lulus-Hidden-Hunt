extends Area2D

# Local variable (not used directly in this script logic)
var total = 0


func _on_body_entered(body):
	# Check if the body entering the area is the Player
	if body is Player:
		# Increase the total value in the parent node
		get_parent().total += 1
		
		# Remove this object from the scene
		queue_free()
