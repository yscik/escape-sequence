extends CollisionObject2D

var OFFSET = Vector2(32,32)
export var tile = -1
export var hideSprite = true
export var on = true
var content = null

func _ready():
	if(on): on()

func off():
	if content != null: 
		change_map(content)
	if hideSprite:
		$Sprite.visible = true
	
func on():
	content = change_map(tile)
	if hideSprite:
		$Sprite.visible = false
	
func change_map(value):
	
	var tilemap = get_map()
	
	var pos = tilemap.world_to_map(global_position - tilemap.global_position)
	var prev = tilemap.get_cellv(pos)
	
	global_position = tilemap.map_to_world(pos) + tilemap.global_position + OFFSET
	
	tilemap.set_cellv(pos, value)
	tilemap.update_bitmask_area(pos)
	
	return prev
	
func get_map():
	var node = self
	while(node):
		var map = node.find_node("TileMap")
		if map:
			return map
		node = node.get_parent()
		
		
func seen(on):
	find_node("Movable").visible = on

	
