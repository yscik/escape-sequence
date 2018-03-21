extends Area2D

func body_entered(body):
	State.game.kill_player()
