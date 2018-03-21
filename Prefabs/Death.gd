extends Area2D

func body_entered(body):
	State.player.die_and_respawn()
