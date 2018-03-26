extends Node2D

export var skill_right = true
export var skill_left = true
export var skill_up = true
export var skill_down = true
export var skill_grab = true

func _ready():
	if !State.checkpoint: 
		spawn_player()

func set_spawn(body):
	State.checkpoint = self

func spawn_player():
	State.checkpoint = self
	State.player.spawn(global_position)
	
	for skill in State.player_skills:
		State.player_skills[skill] = self["skill_"+skill]
		
	pass