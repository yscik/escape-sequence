extends Area2D
	
func player_enter(body):
	State.player.enter_platformer(self)

func player_exit(body):
	State.player.exit_platformer(self)
