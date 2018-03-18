extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var needed_skills = {
	right = true
}

func _ready():
	if !State.player:
		add_player()
	pass

func enter():
	State.level = self
	State.in_platformer = true

func exit():
	State.level = null
	State.in_platformer = false

	
func add_player():
	var player = load("res://Prefabs/Player.tscn").instance()
	add_child(player)
	respawn_player()
	
	for skill in needed_skills:
		State.player_skills[skill] = needed_skills[skill]
		
func respawn_player():
	State.player.global_position = $Entry.global_position

func enemy_hit(body):
	respawn_player()
	pass # replace with function body
