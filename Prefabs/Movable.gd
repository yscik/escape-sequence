extends CollisionObject2D

var grabbed = false
var offset = null

export var marker_when_inactive = false

var anim
func _ready():
	anim = $Movable/Animation
	if marker_when_inactive:
		anim.play("Fade")

func on():
	grabbed = false
	
	pass

func off():
	grabbed = true
	pass

func seen(on):
	if !marker_when_inactive:
		anim.play("Fade",-1, 1 if on else -1, !on)
	
func in_grab_range(on):
	pass
#	if on:
#		anim.play("Pulse",-1, 1)
#	else:
#		anim.stop()
