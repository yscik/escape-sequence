extends AnimationPlayer

func _ready():
	pass

func power_switch(on):
	play("Switch", -1, 1 if on else -1, !on)