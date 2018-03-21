
var player
var skills
var animator
var enabled = true

func _init(player):
	self.player = player
	skills = player.skills
	animator = player.get_node("AnimatedSprite")

var v = Vector2()
var GRAVITY = Vector2(0, 10)
var flipped = false

func update():	

	if !enabled: return
	
	if State.in_platformer:
		platform_movement()	
	player.move_and_slide(v, GRAVITY * -1)
	drive_anim()
	
func platform_movement():
	
	if skills.left && Input.is_key_pressed(KEY_LEFT):
		v.x = -200
	elif skills.right && Input.is_key_pressed(KEY_RIGHT):
		v.x = 200
	else:
		v.x = 0
	
	if player.is_on_floor():		
		if skills.up && Input.is_key_pressed(KEY_UP):
			v.y = -400
#		else:
#			v.y = 0
	else:
		v = v + GRAVITY 

func drive_anim():
	
	var anim = "Idle"
	
	if v.x < -1 && !flipped || v.x > 1 && flipped:
		flipped = !flipped
		player.scale.x = -1
	
	
	if(v.x != 0):
		anim = "Walk"
	if(v.y < 0):
		anim = "Jump"
	if(!player.is_on_floor() && v.y > GRAVITY.y):
		anim = "Fall"
	
	animator.play(anim)
	