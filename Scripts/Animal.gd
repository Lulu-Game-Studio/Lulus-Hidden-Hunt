extends StaticBody2D
class_name Animal

var speed = 180
var direction = Vector2.ZERO
var active = false
var distance = 0
var max_distance = 300

@onready var animal = $AnimatedSprite2D


func _ready():
	play_idle()


func _physics_process(delta):
	if not active:
		return
	
	var move = direction * speed * delta
	
	animal.play("run")
	apply_extra()
	
	position += move
	distance += move.length()
	
	if distance >= max_distance:
		queue_free()


func scatter(dir: Vector2):
	direction = dir
	active = true


func play_idle():
	animal.play("idle")

func apply_extra():
	pass
