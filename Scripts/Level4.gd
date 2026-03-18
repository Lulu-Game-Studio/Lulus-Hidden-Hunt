extends Control

@onready var invisible_walls = $InvisibleWalls
@onready var invisible_wall = $InvisibleWall
@onready var invisible_wall2 = $InvisibleWall2
@onready var spawn_points = $SpawnPoints.get_children()

@onready var bridge = $Bridges/Bridge4
@onready var bridge2 = $Bridges/Bridge12
@onready var bridge_zone = $BridgeZone
@onready var bridge_zone2 = $BridgeZone2

@export var collectible_scene: PackedScene
@export var objects_to_spawn: int = 4

@onready var hud = $HUD

var collected = 0

var total = 0
const TOTAL_NEEDED = 3

func _ready():
	bridge.hide()
	bridge2.hide()
	invisible_walls.hide()
	
	randomize()
	spawn_collectibles()
	hud.set_object_texture(preload("res://Texture/Objects/dog_collar.png"))

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

func _on_bridge_zone_body_entered(body):
	if body is Player:
		if total >= TOTAL_NEEDED:
			invisible_wall.queue_free()
			bridge_zone.queue_free()
			bridge.show()

func _on_bridge_zone_2_body_entered(body):
	if body is Player:
		if total >= TOTAL_NEEDED:
			invisible_wall2.queue_free()
			bridge_zone2.queue_free()
			bridge2.show()

func _on_object_collected():
	collected += 1

	if collected == 5:
		get_tree().call_deferred("change_scene_to_file", "res://Scene/Levels/Level5.tscn")
