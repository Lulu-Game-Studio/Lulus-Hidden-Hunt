extends Control

@export var collectible_scene: PackedScene
@export var objects_to_spawn: int = 10
var total_objects = 10

@export var crow_scene: PackedScene
@onready var crow_points = $CrowPoints.get_children()

@onready var hud = $HUD

@onready var bridges_to_hide = [
	$Bridges/Bridge1, 
	$Bridges/Bridge37, 
	$Bridges/Bridge19, 
	$Bridges/Bridge32, 
	$Bridges/Bridge36
]

var collected = 0


func _ready():
	Hint.hints = 1
	hud.update_hints(Hint.hints)
	hud.set_total_objects(total_objects)
	hud.set_object_texture(preload("res://Texture/Objects/Key.png"))
	
	Signals.hint_used.connect(_on_hint_used)
	Signals.object_collected.connect(_on_object_collected)
	
	randomize()
	spawn_crows()
	
	for bridge in bridges_to_hide:
		if bridge:
			bridge.hide()

func spawn_crows():
	var available_points = crow_points.duplicate()
	
	for i in range(5):
		if available_points.is_empty():
			break
			
		var index = randi() % available_points.size()
		var point = available_points[index]
		
		var crow_instance = crow_scene.instantiate()
		crow_instance.global_position = point.global_position
		add_child(crow_instance)
		
		available_points.remove_at(index)


func _on_object_collected():
	collected += 1


func _on_hint_used():
	if Hint.use_hint($Player, self):
		$Player.audio.stream = preload("res://Texture/Sounds/hint.wav")
		$Player.audio.play()
		hud.update_hints(Hint.hints)
