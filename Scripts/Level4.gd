extends Control

# Reference to invisible walls node in the scene
@onready var invisible_walls = $InvisibleWalls

# Reference to first invisible wall
@onready var invisible_wall = $InvisibleWall

# Reference to second invisible wall
@onready var invisible_wall2 = $InvisibleWall2

# Get all spawn points in the scene
@onready var spawn_points = $SpawnPoints.get_children()

# Reference to first bridge
@onready var bridge = $Bridges/Bridge4

# Reference to second bridge
@onready var bridge2 = $Bridges/Bridge12

# Reference to first bridge trigger zone
@onready var bridge_zone = $BridgeZone

# Reference to second bridge trigger zone
@onready var bridge_zone2 = $BridgeZone2

# Scene used to spawn collectibles
@export var collectible_scene: PackedScene

# Number of objects to spawn in this level
@export var objects_to_spawn: int = 4

var total_objects = 6

# Reference to the HUD (UI)
@onready var hud = $HUD

# Counter for collected objects
var collected = 0

# Progress counter used for unlocking bridges
var total = 0

# Required amount to unlock bridges
const TOTAL_NEEDED = 3


func _ready():
	# Reset hints at the start of the level
	Hint.hints = 1
	
	# Update hints UI
	hud.update_hints(Hint.hints)
	
	# Update total objects UI
	hud.set_total_objects(total_objects)
	
	# Connect hint used signal
	Signals.hint_used.connect(_on_hint_used)
	
	# Hide bridges at start
	bridge.hide()
	bridge2.hide()
	
	# Hide invisible walls at start
	invisible_walls.hide()
	
	# Initialize random system
	randomize()
	
	# Spawn collectibles in the level
	spawn_collectibles()
	
	# Set object icon in HUD
	hud.set_object_texture(preload("res://Texture/Objects/dog_collar.png"))
	
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


func _on_bridge_zone_body_entered(body):
	# Check if body is player
	if body is Player:
		# Check if required progress is reached
		if total >= TOTAL_NEEDED:
			# Remove blocking wall
			invisible_wall.queue_free()
			
			# Remove trigger zone
			bridge_zone.queue_free()
			
			# Show bridge
			bridge.show()


func _on_bridge_zone_2_body_entered(body):
	# Check if body is player
	if body is Player:
		# Check if required progress is reached
		if total >= TOTAL_NEEDED:
			# Remove second blocking wall
			invisible_wall2.queue_free()
			
			# Remove second trigger zone
			bridge_zone2.queue_free()
			
			# Show second bridge
			bridge2.show()


func _on_object_collected():
	# Increase collected counter
	collected += 1

	# Check if all objects are collected
	if collected == 6:
		# Change to next level
		get_tree().call_deferred("change_scene_to_file", "res://Scene/Levels/Level5.tscn")


func _on_hint_used():
	# Try to use a hint and update UI if successful
	if Hint.use_hint($Player, self):
		$Player.audio.stream = preload("res://Texture/Sounds/Sounds/hint.wav")
		$Player.audio.play()
		hud.update_hints(Hint.hints)
