extends Node2D

export var powered = false
export var activated = true
func _ready():
	power_set()
	pass

var MOD_ON = Color(1,1,1)
var MOD_OFF = Color(0.3, 0.3, 0.3)

func power_set():
	if (activated && powered) || (!activated && !powered):
		return
		
	activated = powered
	if powered: 
		power_on()
	else:
		power_off()
	power_things(powered)

func power_on():
	modulate = MOD_ON
	
func power_off():
	modulate = MOD_OFF

func power_things(on):
	propagate_call("power_switch", [on])
	
func on_connect(area):
	var platform = area.get_node("../Platformer")
	var hasPower = area.name == "PowerOut" && (!platform || platform.powered)
	
	powered = hasPower
	if !$"..".grabbed:
		power_set()

func on_disconnect(area):
	powered = false
	power_set()
	
