extends Animal

func _ready():
	speed = 350
	max_distance = 4000
	play_idle()

func apply_extra():
	animal.scale.x = -6.288
