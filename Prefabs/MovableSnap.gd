extends StaticBody2D

func _ready():
	on()
	pass

func on():
	toggleCollisions(true)
	set_position(Vector2(stepify(position.x, 64), stepify(position.y, 64)))

func toggleCollisions(enabled):
	for node in get_tree().get_nodes_in_group("Physics"):
		if enabled:
			node.set_collision_mask_bit(4, true)
		else: 
			node.set_collision_mask_bit(4, false)
			print("adding exception for %s" % node.name)
	pass
	
func off():
	toggleCollisions(false)
	pass