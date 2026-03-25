extends Control

# Reference to invisible walls node in the scene
@onready var invisible_walls = $InvisibleWalls

# Reference to a single invisible wall node
@onready var invisible_wall = $InvisibleWall

# Get all spawn points in the scene
@onready var spawn_points = $SpawnPoints.get_children()

# Reference to log objects in the scene
@onready var log1 = $Log1
@onready var log2 = $Log2
@onready var log3 = $Log3

# Reference to bridge object and trigger zone
@onready var bridge = $Bridge
@onready var bridge_zone = $BridgeZone

# Scene used to spawn collectibles
@export var collectible_scene: PackedScene

# Number of objects to spawn in this level
@export var objects_to_spawn: int = 2

var total_objects = 3

# Reference to the HUD (UI)
@onready var hud = $HUD

# Counter for collected objects
var collected = 0

# Total progress value used for unlocking the bridge
var total = 0

# Required amount to unlock the bridge
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
	
	# Hide bridge at start
	bridge.hide()
	
	# Hide invisible walls at start
	invisible_walls.hide()
	
	# Initialize random system
	randomize()
	
	# Spawn collectibles in the level
	spawn_collectibles()
	
	# Set object icon in HUD
	hud.set_object_texture(preload("res://Texture/Objects/Bone.png"))
	
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
	# Check if the body is the player
	if body is Player:
		# Check if required total is reached
		if total == TOTAL_NEEDED:
			# Remove blocking wall
			invisible_wall.queue_free()
			
			# Remove bridge trigger zone
			bridge_zone.queue_free()
			
			# Show bridge
			bridge.show()


func _on_object_collected():
	# Increase collected counter
	collected += 1

	# Check if all objects are collected
	if collected == 3:
		# Change to next level
		get_tree().call_deferred("change_scene_to_file", "res://Scene/Levels/Level3.tscn")


func _on_hint_used():
	# Try to use a hint and update UI if successful
	if Hint.use_hint($Player, self):
		$Player.audio.stream = preload("res://Texture/Sounds/hint.wav")
		$Player.audio.play()
		hud.update_hints(Hint.hints)
