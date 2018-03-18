extends AnimationPlayer

export var animation = "" 
func _ready():
	if animation: 
		play(animation)
	pass
