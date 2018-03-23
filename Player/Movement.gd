
var player
var skills
var animator
var character
var enabled = true
onready var in_platformer = State.in_platformer

func _init(player):
	self.player = player
	skills = player.skills
	animator = player.get_node("Character/AnimatedSprite")
	character = player.get_node("Character")

var v = Vector2()
var GRAVITY = Vector2(0, 10)
var flipped = false

var input = {
	left = false,
	right = false,
	up = false,
	down = false,
}
var keyMap = {
	left = [KEY_LEFT, KEY_A],
	right = [KEY_RIGHT, KEY_D],
	up = [KEY_UP, KEY_W],
	down = [KEY_DOWN, KEY_S],
}

func update_input():
	for skill in input:
		set_input(skill, keyMap[skill])

func set_input(skill, keys):
	input[skill] = skills[skill] && (Input.is_key_pressed(keys[0]) || Input.is_key_pressed(keys[1]))
	
func update():	
	
	if !enabled: return
	
	update_input()
	
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
	
	if input.left:
		v.x = -200
	elif input.right:
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
		
	player.move_and_slide(v.rotated(State.area.global_rotation), GRAVITY.rotated(State.area.global_rotation) * -1)

func platform_anim():
	
	var anim = "Idle"
	
	if v.x < -1 && !flipped || v.x > 1 && flipped:
		flipped = !flipped
		flip()
	
	if(v.x != 0):
		anim = "Walk"
	if(v.y < 0):
		anim = "Jump"
	if(!player.is_on_floor() && v.y > GRAVITY.y):
		anim = "Fall"
	
	animator.play(anim)
	player.global_rotation = State.area.global_rotation
	
func platform_exit():
	if flipped:
		flip()
	
	flipped = false

func flip():
	character.apply_scale(Vector2(-1, 1))
	
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
