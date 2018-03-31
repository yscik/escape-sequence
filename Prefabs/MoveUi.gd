extends "res://Prefabs/Movable.gd"

func _ready():
#	offset = true
	pass

func on_ui(cursor):
	if cursor.grabbed:
		return
	cursor.working = false
	cursor.grabbed = true
	cursor.get_parent().remove_child(cursor)
	cursor.position = Vector2(-45,-60)
	add_child(cursor)
	$MoveUiMark/Animation.play("Activate")
	State.game.set_visual(4)
