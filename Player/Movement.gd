
var player
var skills
var animator
var enabled = true
onready var in_platformer = State.in_platformer

func _init(player):
	self.player = player
	skills = player.skills
	animator = player.get_node("AnimatedSprite")

var v = Vector2()
var GRAVITY = Vector2(0, 10)
var flipped = false

func update():	

	if !enabled: return
	
	if State.in_platformer && !in_platformer:
		topdown_exit()
	
	if !State.in_platformer && in_platformer:
		platform_exit()
	
	in_platformer = State.in_platformer
	
	if in_platformer:
		platform_movement()		
		platform_anim()
	else:
		topdown_movement()		
		topdown_anim()
		
	
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
		
	player.move_and_slide(v, GRAVITY * -1)

func platform_anim():
	
	var anim = "Idle"
	
	if v.x < -1 && !flipped || v.x > 1 && flipped:
		flipped = !flipped
		player.scale.x = -1
#		animator.flip_h = flipped
	
	if(v.x != 0):
		anim = "Walk"
	if(v.y < 0):
		anim = "Jump"
	if(!player.is_on_floor() && v.y > GRAVITY.y):
		anim = "Fall"
	
	animator.play(anim)
	
func platform_exit():
	if flipped:
		player.scale.x = -1
	
	flipped = false


func speed(direction, accel):
	v[direction] = min(200, abs(v[direction]) + 4) * accel
	
func topdown_movement():
	
	if skills.left && Input.is_key_pressed(KEY_LEFT):
		speed("x", -1)
	elif skills.right && Input.is_key_pressed(KEY_RIGHT):
		speed("x", 1)
	else:
		v.x = 0
	
	if skills.up && Input.is_key_pressed(KEY_UP):
		speed("y", -1)
	elif skills.down && Input.is_key_pressed(KEY_DOWN):
		speed("y", 1)
	else:
		v.y = 0
		
	player.move_and_slide(v)

func topdown_anim():
	
	var anim = "Topdown"	
	
	if(v.length() > 0):
		player.look_at(player.global_position + v)

	animator.play(anim)
	
func topdown_exit():
	player.look_at(player.global_position + Vector2(1,0))
