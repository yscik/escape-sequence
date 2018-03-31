extends Node

export var skill = ""
export (int) var visual

func activate():
	State.pickup(skill)

func player_collects(body):
	if State.player_skills[skill]: return
	$SFX.play(1)
	$AnimationPlayer.play("Pickup")
	activate()
	if visual:
		State.game.set_visual(visual)
	yield($AnimationPlayer, "animation_finished")
	yield($SFX, "finished")
	queue_free()
