extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal pickup(skill)

export var in_platformer = false
var player_skills = {
	right = false,
	up = false,
	down = false,
	left = false,
	grab = false,
	convert = false
}
var player = null
var area = null
var game = null

var checkpoint = null

func pickup(skill):
	
	player_skills[skill] = true
	emit_signal("pickup", skill)
