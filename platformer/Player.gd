extends KinematicBody2D

var attached = false
var grab
var movement
var skills

func _ready():
	State.player = self
	skills = State.player_skills
	movement = load("res://Player/Movement.gd").new(self)
	pass

func _physics_process(delta):
	
	if(movement):
		movement.update()
	pass

func spawn(pos):
	global_position = pos
	area_update()

func die_and_respawn():
	movement.enabled = false
	$Animations.play("Death")
	yield($Animations, "animation_finished")
	spawn(State.checkpoint.global_position)
	$Animations.play("Death", -1, -2, true)
	movement.enabled = true
	
	pass
	
func enter_platformer(area):
	State.area = area
	State.in_platformer = true
	area_update()

func exit_platformer(area):
	if State.area == area:
		State.in_platformer = false
		area_update()
		
func area_update():
	if State.in_platformer:
		zoom_camera(1)
	else:
		zoom_camera(2.5)

func zoom_camera(scale):
	print("zoom")
	$Camera2D/Tween.interpolate_property($Camera2D, "zoom", $Camera2D.zoom, Vector2(scale, scale), 1, 
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Camera2D/Tween.start()
	pass

func can_see_movable(movable):
	if skills.grab:
		movable.seen(true)

func cant_see_movable(movable):
	if skills.grab:
		movable.seen(false)
