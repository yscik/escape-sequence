extends "res://Prefabs/Movable.gd"

func _ready():
	offset = true
	on()

func on():
	.on()
	toggleCollisions(true)
	set_position(Vector2(stepify(position.x, 64), stepify(position.y, 64)))
	$Platformer.power_set()

func toggleCollisions(enabled):
	for node in get_tree().get_nodes_in_group("Physics"):
		if !is_a_parent_of(node):
			continue
		if enabled:
			node.set_collision_mask_bit(4, true)
		else: 
			node.set_collision_mask_bit(4, false)
			print("adding exception for %s" % node.name)
	pass

func off():
	.off()
	toggleCollisions(false)
	pass