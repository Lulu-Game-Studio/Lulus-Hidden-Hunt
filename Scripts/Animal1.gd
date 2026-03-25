extends Animal

func _ready():
	max_distance = 300
	play_idle()

func play_idle():
	animal.play("sleep")
