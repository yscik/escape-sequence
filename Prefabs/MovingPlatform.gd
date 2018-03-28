extends Node2D

export var delay = 0.0

func _ready():
	if delay:
		yield(get_tree().create_timer(delay), "timeout")
		
	$AnimationPlayer.play("MovePlatform")
	

