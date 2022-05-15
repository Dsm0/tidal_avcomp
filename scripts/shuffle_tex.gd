extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func shuffle_tex(model,textures):
	var mat = SpatialMaterial.new()

	var eh = model.get_surface_material_count()
	var siz = textures.size()
	
	assert(model != null, "null model")
	assert(mat != null, "null mat")
	assert(textures.size() != 0, "no tex")
	
	for i in range(eh):
		var rand = randi() % siz
		var mat2 = mat.duplicate()
		mat2.set_texture(0, textures[rand])
		model.set_surface_material(i, mat2)
#	var eh = model.get_surface_material(0)
#	print(eh)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
