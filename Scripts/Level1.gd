extends Control

# Reference to invisible walls node in the scene
@onready var invisible_walls = $InvisibleWalls

# Get all spawn points in the scene
@onready var spawn_points = $SpawnPoints.get_children()

# Scene used to spawn collectibles
@export var collectible_scene: PackedScene

# Number of objects to spawn in this level
@export var objects_to_spawn: int = 3

# Reference to the HUD (UI)
@onready var hud = $HUD

# Counter for collected objects
var collected = 0


func _ready():
	# Reset hints at the start of the level
	Hint.hints = 1
	
	# Update hints UI
	hud.update_hints(Hint.hints)
	
	# Connect hint used signal
	Signals.hint_used.connect(_on_hint_used)
	
	# Hide invisible walls at start
	invisible_walls.hide()
	
	# Initialize random system
	randomize()
	
	# Spawn collectibles in the level
	spawn_collectibles()
	
	# Set object icon in HUD
	hud.set_object_texture(preload("res://Texture/Objects/Ball.png"))
	
	# Connect object collected signal
	Signals.object_collected.connect(_on_object_collected)


func spawn_collectibles():
	# Copy spawn points so we can remove used ones
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
	if collected >= objects_to_spawn:
		# Change to next level
		get_tree().call_deferred("change_scene_to_file", "res://Scene/Levels/Level2.tscn")


func _on_hint_used():
	# Try to use a hint and update UI if successful
	if Hint.use_hint($Player, self):
		hud.update_hints(Hint.hints)
