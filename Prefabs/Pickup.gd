extends Node

export var skill = ""

func activate():
	State.pickup(skill)

func player_collects(body):
	$AnimationPlayer.play("Pickup")
	activate()
	yield($AnimationPlayer, "animation_finished")
	queue_free()
