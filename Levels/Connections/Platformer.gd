extends Node2D

export var powered = false

func _ready():
	power_set(powered)
	pass

var MOD_ON = Color(1,1,1)
var MOD_OFF = Color(0.3, 0.3, 0.3)

func power_set(value):
	powered = value
	if powered: 
		power_on()
	else:
		power_off()
	power_things(value)

func power_on():
	fade(MOD_ON)
	
	
func power_off():
	fade(MOD_OFF)

func fade(to):
	$TileMap.modulate = to
	$Platformer.modulate = to
	pass

func power_things(on):
	propagate_call("power_switch", [on])
	
func on_connect(area):
	var platform = area.get_node("../Platformer")
	var hasPower = area.name == "PowerOut" && (!platform || platform.powered)
	
	power_set(hasPower)

func on_disconnect(area):
	power_set(false)
	
