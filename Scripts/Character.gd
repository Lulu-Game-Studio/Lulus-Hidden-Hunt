extends CharacterBody2D

@onready var character = $AnimatedSprite2D

func _ready():
	character.play("idle")
