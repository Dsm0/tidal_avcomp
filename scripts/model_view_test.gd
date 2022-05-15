extends "res://viz/longest_night_assets.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func tst_func_ref(vector):
	return vector + Vector3(0.5,0.5,0.5)
	pass

onready var func_ref = funcref(self,"tst_func_ref")

# Called when the node enters the scene tree for the first time.
func _ready():
#	print(ryutaTexPaths)
#	var node = ryuta
#	assert(ryuta != null, "null ryuta")
#	assert(ryutaTex[0] != null, "null ryutaTex")
#	shuffle_tex.shuffle_tex(node,ryutaTex)
#	print(ryutaTex)
#	mesh_vertex_warp.warp_with(node,3,func_ref)
	pass # Replace with function body.


#func _input(ev):
#	if (ev is InputEventKey and ev.scancode == KEY_K):
#		shuffle_tex.shuffle_tex(ryuta,ryutaTex)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
