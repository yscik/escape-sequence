extends Node2D

export var skill_right = true
export var skill_left = false
export var skill_up = false
export var skill_down = false
export var skill_grab = false

func _ready():
	if !State.player.attached:
		add_player()
	pass

func enter():
	State.level = self
	State.in_platformer = true

func exit():
	State.level = null
	State.in_platformer = false

	
func add_player():
	State.player.attached = true
	State.player.global_position = $Entry.global_position
	for skill in State.player_skills:
		State.player_skills[skill] = self["skill_"+skill]
		
func respawn_player():
	State.player.die_and_respawn($Entry.global_position)

func enemy_hit(body):
	respawn_player()

func depth_hit(body):
	respawn_player()

