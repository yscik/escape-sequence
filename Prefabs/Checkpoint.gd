extends Area2D

export var skill_right = true
export var skill_left = false
export var skill_up = false
export var skill_down = false
export var skill_grab = false

func set_spawn(body):
	State.checkpoint = self
