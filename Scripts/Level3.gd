extends Control

# Reference to invisible walls node in the scene
@onready var invisible_walls = $InvisibleWalls

# Get all spawn points in the scene
@onready var spawn_points = $SpawnPoints.get_children()

# Scene used to spawn collectibles
@export var collectible_scene: PackedScene

# Number of objects to spawn in this level
@export var objects_to_spawn: int = 2

var total_objects = 3

# Reference to the HUD (UI)
@onready var hud = $HUD

# Groups of animals in different zones (top/bottom)
@onready var animals_up = $Animals/AnimalsUp.get_children()
@onready var animals_down = $Animals/AnimalsDown.get_children()

# Additional animal groups in second zone
@onready var animals_up2 = $Animals/AnimalsUp2.get_children()
@onready var animals_down2 = $Animals/AnimalsDown2.get_children()

# Specific animal references
@onready var animal1 = $Animals/AnimalsDown2/Animal3
@onready var animal2 = $Animals/AnimalsDown2/Animal4

# Single animal reference in another area
@onready var animal3 = $Animals/Animal3

# Flags that control if player is inside animal zones
var AnimalZone = false
var AnimalZone2 = false
var AnimalZone3 = false

# Counter for collected objects
var collected = 0


func _ready():
	# Reset hints at the start of the level
	Hint.hints = 1
	
	# Update hints UI
	hud.update_hints(Hint.hints)
	
	# Connect hint used signal
	Signals.hint_used.connect(_on_hint_used)
	
	# Update total objects UI
	hud.set_total_objects(total_objects)
	
	# Hide invisible walls at start
	invisible_walls.hide()
	
	# Connect bark signal
	Signals.bark.connect(_on_bark)
	
	# Flip specific animals horizontally
	animal1.scale.x = -1
	animal2.scale.x = -1
	
	# Initialize random system
	randomize()
	
	# Spawn collectibles in the level
	spawn_collectibles()
	
	# Set object icon in HUD
	hud.set_object_texture(preload("res://Texture/Objects/dog_toy.png"))
	
	# Connect object collected signal
	Signals.object_collected.connect(_on_object_collected)


func spawn_collectibles():
	# Copy spawn points so can remove used ones
	var available_points = spawn_points.duplicate()

	# Spawn required number of objects
	for i in range(objects_to_spawn):
		if available_points.is_empty():
			break

		# Pick a random spawn point
		var index = randi() % available_points.size()
		var point = available_points[index]

		# Create collectible instance
		var obj = collectible_scene.instantiate()
		
		# Set object position
		obj.global_position = point.global_position
		
		# Add object to scene
		add_child(obj)

		# Remove used spawn point
		available_points.remove_at(index)


func _on_object_collected():
	# Increase collected counter
	collected += 1

	# Check if all objects are collected
	if collected == 3:
		# Change to next level
		get_tree().call_deferred("change_scene_to_file", "res://Scene/Levels/Level4.tscn")


func _on_bark():
	# If player is in first animal zone
	if AnimalZone == true:
		# Move all animals in upper group
		for animal in animals_up:
			if is_instance_valid(animal):
				animal.scatter(Vector2.UP)
		
		# Move all animals in lower group
		for animal in animals_down:
			if is_instance_valid(animal):
				animal.scatter(Vector2.DOWN)
	
	# If player is in second animal zone
	if AnimalZone2 == true:
		# Move all animals in upper group 2
		for animal in animals_up2:
			if is_instance_valid(animal):
				animal.scatter(Vector2.UP)
		
		# Move all animals in lower group 2
		for animal in animals_down2:
			if is_instance_valid(animal):
				animal.scatter(Vector2.DOWN)
		
	# If player is in third animal zone
	if AnimalZone3 == true:
		# Move single animal to the right
		animal3.scatter(Vector2.RIGHT)


func _on_animal_zone_body_entered(body):
	# Enable first animal zone
	if body is Player:
		AnimalZone = true


func _on_animal_zone_body_exited(body):
	# Disable first animal zone
	if body is Player:
		AnimalZone = false


func _on_animal_zone_2_body_entered(body):
	# Enable second animal zone
	if body is Player:
		AnimalZone2 = true


func _on_animal_zone_2_body_exited(body):
	# Disable second animal zone
	if body is Player:
		AnimalZone2 = false


func _on_animal_zone_3_body_entered(body):
	# Enable third animal zone
	if body is Player:
		AnimalZone3 = true


func _on_animal_zone_3_body_exited(body):
	# Disable third animal zone
	if body is Player:
		AnimalZone3 = false


func _on_hint_used():
	# Try to use a hint and update UI if successful
	if Hint.use_hint($Player, self):
		$Player.audio.stream = preload("res://Texture/Sounds/Sounds/hint.wav")
		$Player.audio.play()
		hud.update_hints(Hint.hints)
