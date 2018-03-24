extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func click():
	
	$Tween.interpolate_property(self, "rotation", rotation, rotation + deg2rad(90), 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		click()

func _unhandled_key_input(event):
	if event.pressed && event.scancode == KEY_ENTER:
		click()