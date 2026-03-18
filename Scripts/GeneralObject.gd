extends Area2D
class_name Collectible

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is Player:
		collect(body)

func collect(player):
	Signals.object_collected.emit()
	queue_free()
