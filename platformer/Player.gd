extends KinematicBody2D

onready var skills = State.player_skills

var attached = false

func _ready():
	State.player = self
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

var v = Vector2()
export var GRAVITY = Vector2(0, 10)

func _physics_process(delta):
	
	if State.in_platformer:
		platform_movement()
		
	drive_anim()
		
	move_and_slide(v, GRAVITY * -1)
	pass
	
func platform_movement():
	
	if skills.left && Input.is_key_pressed(KEY_LEFT):
		v.x = -200
	elif skills.right && Input.is_key_pressed(KEY_RIGHT):
		v.x = 200
	else:
		v.x = 0
	
	if is_on_floor():		
		if skills.up && Input.is_key_pressed(KEY_UP):
			v.y = -400
#		else:
#			v.y = 0
	else:
		v = v + GRAVITY 

func drive_anim():
	
	$AnimatedSprite.flip_h = v.x < -1
	
	var anim = "Idle";
	if(v.x != 0):
		anim = "Walk"
	if(v.y < 0):
		anim = "Jump"
	if(!is_on_floor() && v.y > GRAVITY.y):
		anim = "Fall"
	
	$AnimatedSprite.play(anim)
	
func die_and_respawn(spawn_pos):
	$Animations.play("Death")
	yield($Animations, "animation_finished")
	global_position = spawn_pos
	$Animations.play("Death", -1, -2, true)
	pass