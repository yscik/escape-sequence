extends Node

export var spawn = 0

func _ready():
	State.game = self
	find_node("Level-%s" % spawn).get_node("Checkpoint").spawn_player()
	
	if OS.has_feature("web"):
		OS.window_maximized = true
	
export (Texture) var visual_1
export (Gradient) var bg_1
export (Texture) var visual_2
export (Gradient) var bg_2
export (Texture) var visual_3
export (Gradient) var bg_3
export (Texture) var visual_4
export (Gradient) var bg_4

export (TileSet) var tileset

func next_visual(visual):
	set_visual(visual)
	yield(get_tree().create_timer(5), "timeout")
	visual += 1
	if visual == 5: visual = 1
	next_visual()
	
func set_visual(visual):
	tileset.tile_set_texture(0, self["visual_%s" % visual])
	set_bg(self["bg_%s" % visual])
	
func set_bg(gradient):
	var bg_nodes = get_tree().get_nodes_in_group("PlatformerBackground")
	for bg in bg_nodes:
		bg.get_node("Color").texture.gradient = gradient
	