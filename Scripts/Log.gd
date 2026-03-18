extends Area2D

var total = 0

func _on_body_entered(body):
	if body is Player:
		get_parent().total += 1
		queue_free()
