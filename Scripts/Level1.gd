extends Control

@onready var invisible_walls = $InvisibleWalls
@onready var spawn_points = $SpawnPoints.get_children()

@export var collectible_scene: PackedScene
@export var objects_to_spawn: int = 3

@onready var hud = $HUD

var collected = 0

func _ready():
	invisible_walls.hide()
	randomize()
	spawn_collectibles()
	hud.set_object_texture(preload("res://Texture/Objects/Ball.png"))
	
	Signals.object_collected.connect(_on_object_collected)

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

	if collected >= objects_to_spawn:
		get_tree().call_deferred("change_scene_to_file", "res://Scene/Levels/Level2.tscn")
