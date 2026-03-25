extends Area2D
class_name Collectible

func _ready():
	# Add this object to the "collectibles" group
	add_to_group("collectibles")
	
	# Connect signal when a body enters the area
	body_entered.connect(_on_body_entered)
	
	var anim_sprite = get_node_or_null("AnimatedSprite2D")
	
	if anim_sprite:
		anim_sprite.play("idle")


func _on_body_entered(body):
	# Check if the body is a Player
	if body is Player:
		collect(body)


func collect(player):
	# Emit signal when object is collected
	Signals.object_collected.emit()
	
	# Remove the collectible from the scene
	queue_free()
