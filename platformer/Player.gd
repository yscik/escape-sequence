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

func die_and_respawn():
	movement.enabled = false
	$Animations.play("Death")
	yield($Animations, "animation_finished")
	spawn(State.checkpoint.global_position)
	$Animations.play("Death", -1, -2, true)
	movement.enabled = true
	pass