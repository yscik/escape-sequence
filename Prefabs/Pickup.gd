extends Node

export var skill = ""

func activate():
	get_node("/root/Game").player_skills[skill] = true


func player_collects(body):
	$AnimationPlayer.play("Pickup")
	activate()
