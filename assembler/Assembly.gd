extends Node2D

func _ready():
	build()


func build():
	
	var cell = $TileMap.get_target()
	
	if !cell: return
	
	$Builder.build_block($TileMap.map_to_world(cell) + $TileMap.global_position + Vector2(32,32))
	yield($Builder, "built")
	$TileMap.add(cell)
	
	#yield(get_tree().create_timer(0.5), "timeout")
	build()