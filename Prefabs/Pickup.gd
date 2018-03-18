extends Node

export var skill = ""

func activate():
	get_node("/root/State").player_skills[skill] = true


func player_collects(body):
	$AnimationPlayer.play("Pickup")
	activate()
	yield($AnimationPlayer, "animation_finished")
	queue_free()
