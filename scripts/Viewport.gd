extends Viewport


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var scale_factor = 0.125

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().connect("size_changed", self, "_root_viewport_size_changed")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _root_viewport_size_changed():
	# The viewport is resized depending on the window height.
	# To compensate for the larger resolution, the viewport sprite is scaled down.
	self.size = get_viewport().size * scale_factor


func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_SPACE:
		get_tree().reload_current_scene()
