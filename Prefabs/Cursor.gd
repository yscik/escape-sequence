extends "res://Prefabs/Movable.gd"

export (Texture) var clicked_texture 
var base_texture
var base_pos
var clicked_pos

var working = true

var target

func _ready():
	offset = true
	base_texture = $Sprite.texture
	base_pos = $Sprite.position
	clicked_pos = base_pos + Vector2(-2, -2)


func off():
	working = false
	pass
	
	
func _input(event):
	if grabbed && event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		click(event.pressed)
		
func click(on):
	$Sprite.texture = clicked_texture if on else base_texture
	$Sprite.position = clicked_pos if on else base_pos
	if on && target:
		target.click()

func on_hover(area):
	target = area

func on_hover_exit(area):
	target = null
