extends Node2D

func _ready():
	pass

func build():
	
	print("build next")
		
	var map = $Level/TileMap
	var cell = map.get_target()
	
	if cell == null: return
	
	$Builder.build_block(map.to_global(map.map_to_world(cell) + Vector2(32,32)))
	yield($Builder, "built")
	map.add(cell)
	
	#yield(get_tree().create_timer(0.5), "timeout")
	build()

func start(area):
	print("starting build")
	build()
