extends Area2D
	
func player_enter(body):
	State.area = self
	State.in_platformer = true

func player_exit(body):
	State.in_platformer = false
