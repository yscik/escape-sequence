extends KinematicBody2D

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

var v = Vector2()
export var UP = Vector2(0, -1)

func _physics_process(delta):
	
	platform_movement()
	drive_anim()
		
	move_and_slide(v, UP)
	pass
	
func platform_movement():
	
	v.y += 10
	
	if Input.is_key_pressed(KEY_LEFT):
		v.x = -100
	elif Input.is_key_pressed(KEY_RIGHT):
		v.x = 100
	else:
		v.x = 0
	if Input.is_key_pressed(KEY_UP):
		v.y = -200

func drive_anim():
	
	$AnimatedSprite.flip_h = v.x < -1
	
	var anim = "Idle";
	if(v.x != 0):
		anim = "Walk"
	
	$AnimatedSprite.play(anim)