extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var in_platformer = false
var player_skills = {
	right = false,
	up = false,
	down = false,
	left = false,
	grab = false
}
var player = null
var level = null
var game = null

var checkpoint = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
