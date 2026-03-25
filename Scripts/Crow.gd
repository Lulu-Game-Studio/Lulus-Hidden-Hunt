extends Area2D

@onready var crow_sprite: AnimatedSprite2D = $AnimatedSprite2D

var animations: Array[String] = ["anim1", "anim2", "anim3"]
var last_animation: String = ""

func _ready():
	_play_random_animation()

func _play_random_animation() -> void:
	var next_anim: String = animations.pick_random()
	
	while next_anim == last_animation:
		next_anim = animations.pick_random()
	
	last_animation = next_anim
	crow_sprite.play(next_anim)

func _on_body_entered(body):
	if body is Player:
		queue_free()

func _on_animated_sprite_2d_animation_finished():
	_play_random_animation()
