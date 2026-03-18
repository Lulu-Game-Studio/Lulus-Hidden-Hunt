extends Control

@onready var invisible_walls = $InvisibleWalls
@onready var invisible_wall = $InvisibleWall
@onready var spawn_points = $SpawnPoints.get_children()

@onready var log1 = $Log1
@onready var log2 = $Log2
@onready var log3 = $Log3
@onready var bridge = $Bridge
@onready var bridge_zone = $BridgeZone

@export var collectible_scene: PackedScene
@export var objects_to_spawn: int = 2

@onready var hud = $HUD

var total = 0
const TOTAL_NEEDED = 3

func _ready():
	bridge.hide()
	invisible_walls.hide()
	
	randomize()
	spawn_collectibles()
	hud.set_object_texture(preload("res://Texture/Objects/Bone.png"))


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
		if total == TOTAL_NEEDED:
			invisible_wall.queue_free()
			bridge_zone.queue_free()
			bridge.show()
