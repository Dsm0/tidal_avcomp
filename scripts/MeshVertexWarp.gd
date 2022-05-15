extends MeshInstance

var mdt = MeshDataTool.new() 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func warp_with(nd,surface,warp_factor,func_ref):

	var m = nd.get_mesh()
	#get surface 0 into mesh data tool
	mdt.create_from_surface(m,surface)
#	print(mdt)
	for vtx in range(mdt.get_vertex_count()):
		var vert=mdt.get_vertex(vtx)
#		print("global vertex: "+str(nd.global_transform.xform(vert)))
#		print(vert)
#		print(func_ref)
		var newVert = warp_factor * func_ref.call_func(vert)
		mdt.set_vertex(vtx,newVert)
	m.surface_remove(surface)
	mdt.commit_to_surface(m)
	pass # Replace with function body


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
