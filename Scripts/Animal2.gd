extends StaticBody2D

var speed = 180
var direction = Vector2.ZERO
var active = false
var distance = 0
var max_distance = 280

@onready var animal = $AnimatedSprite2D

func _ready():
	animal.play("idle")

func _physics_process(delta):
	if not active:
		return
	
	var move = direction * speed * delta
	animal.play("run")
	position += move
	distance += move.length()
	
	if distance >= max_distance:
		queue_free()

func scatter(dir: Vector2):
	direction = dir
	active = true
