extends TextureRect


func _ready():
	State.connect("pickup", self, "on_pickup")
	pass

func on_pickup(skill):
	$Anim.play("Pop")
	find_node(skill).visible = true