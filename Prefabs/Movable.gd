extends CollisionObject2D

var grabbed = false
var offset = null

var anim
func _ready():
	anim = $Movable/Animation

func on():
	grabbed = false
	pass

func off():
	grabbed = true
	pass

func seen(on):
	anim.play("Fade",-1, 1 if on else -1, !on)
	
func in_grab_range(on):
	pass
#	if on:
#		anim.play("Pulse",-1, 1)
#	else:
#		anim.stop()
