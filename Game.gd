extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var spawn = 0

func _ready():
	State.game = self
	State.checkpoint = find_node("Level-%s" % spawn).get_node("Checkpoint")
	State.player.spawn(State.checkpoint.global_position)
	
	for skill in State.player_skills:
		State.player_skills[skill] = State.checkpoint["skill_"+skill]
		
	pass

func kill_player():
	State.player.die_and_respawn(State.checkpoint.global_position)
	pass # replace with function body

