extends Control

@onready var invisible_walls = $InvisibleWalls
@onready var spawn_points = $SpawnPoints.get_children()

@export var collectible_scene: PackedScene
@export var objects_to_spawn: int = 2

@onready var hud = $HUD

@onready var animals_up = $Animals/AnimalsUp.get_children()
@onready var animals_down = $Animals/AnimalsDown.get_children()

@onready var animals_up2 = $Animals/AnimalsUp2.get_children()
@onready var animals_down2 = $Animals/AnimalsDown2.get_children()

@onready var animal1 = $Animals/AnimalsDown2/Animal3
@onready var animal2 = $Animals/AnimalsDown2/Animal4

@onready var animal3 = $Animals/Animal3

var AnimalZone = false
var AnimalZone2 = false
var AnimalZone3 = false

var collected = 0

func _ready():
	invisible_walls.hide()
	Signals.bark.connect(_on_bark)
	
	animal1.scale.x = -1
	animal2.scale.x = -1
	
	randomize()
	spawn_collectibles()
	hud.set_object_texture(preload("res://Texture/Objects/dog_toy.png"))

func spawn_collectibles():
	var available_points = spawn_points.duplicate()

	for i in range(objects_to_spawn):
		if available_points.is_empty():
			break

		var index = randi() % available_points.size()
		var point = available_points[index]

		var obj = collectible_scene.instantiate()
		obj.global_position = point.global_position
		add_child(obj)

		available_points.remove_at(index)

func _on_object_collected():
	collected += 1

	if collected == 3:
		get_tree().call_deferred("change_scene_to_file", "res://Scene/Levels/Level4.tscn")

func _on_bark():
	if AnimalZone == true:
		for animal in animals_up:
			if is_instance_valid(animal):
				animal.scatter(Vector2.UP)
		
		for animal in animals_down:
			if is_instance_valid(animal):
				animal.scatter(Vector2.DOWN)
	
	if AnimalZone2 == true:
		for animal in animals_up2:
			if is_instance_valid(animal):
				animal.scatter(Vector2.UP)
		
		for animal in animals_down2:
			if is_instance_valid(animal):
				animal.scatter(Vector2.DOWN)
		
	if AnimalZone3 == true:
		animal3.scatter(Vector2.RIGHT)


func _on_animal_zone_body_entered(body):
	if body is Player:
		AnimalZone = true


func _on_animal_zone_body_exited(body):
	if body is Player:
		AnimalZone = false


func _on_animal_zone_2_body_entered(body):
	if body is Player:
		AnimalZone2 = true


func _on_animal_zone_2_body_exited(body):
	if body is Player:
		AnimalZone2 = false


func _on_animal_zone_3_body_entered(body):
	if body is Player:
		AnimalZone3 = true


func _on_animal_zone_3_body_exited(body):
	if body is Player:
		AnimalZone3 = false
