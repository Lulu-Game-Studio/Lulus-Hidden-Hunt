extends Area2D

@onready var label = %Label
@onready var panel = $PanelContainer
@export var text = ""

func _ready():
	label.text = text
	panel.visible = false

func _on_body_entered(body):
	if body is Player:
		panel.visible = true

func _on_body_exited(body):
	if body is Player:
		panel.visible = false
