extends Node

export var spawn = 0

func _ready():
	State.game = self
	find_node("Level-%s" % spawn).get_node("Checkpoint").spawn_player()
	
	if OS.has_feature("web"):
		OS.window_maximized = true