extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

export var entry = true;

func on_player_enter(body):
	set_level_edge_collision(false)

func on_player_leave(body):
	set_level_edge_collision(true)

func set_level_edge_collision(enabled): 
	get_node("../LevelContainer").set_collision_layer_bit(0, enabled)