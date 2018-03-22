extends TileMap

var map
var phase = 1

func _ready():
	map = get_used_cells()
	
	for cell in map:
		if $BuildOrder.get_cellv(cell) != 0:
			set_cellv(cell, -1)
			update_bitmask_area(cell)


func get_target():
	var phaseMap = $BuildOrder.get_used_cells_by_id(phase)
	match phaseMap.size():
		1:
			phase += 1
		0:
			return
	
	var cell = phaseMap.pop_front()
	
	return cell
	
func add(cell):	
	set_cellv(cell, 0)
	$BuildOrder.set_cellv(cell, -1)
	update_bitmask_area(cell)
	