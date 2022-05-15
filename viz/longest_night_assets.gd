extends "res://viz/init.gd"

onready var hotel = get_node("ViewportContainer/Viewport/SpatialParent/world1/hotel")

onready var hotel_mesh_og = hotel.get_mesh().duplicate()
onready var hotel_mat_count = hotel.get_surface_material_count()

onready var cube2 = get_node("ViewportContainer/Viewport/SpatialParent/Cube2")
onready var cube2Origin = cube2.transform.origin
#

onready var spatial1 = get_node("ViewportContainer/Viewport/SpatialParent/Spatial1")
onready var spatial2 = get_node("ViewportContainer/Viewport/SpatialParent/Spatial1")
onready var spatial3 = get_node("ViewportContainer/Viewport/SpatialParent/Spatial1")

onready var cam1 = get_node("ViewportContainer/Viewport/SpatialParent/Spatial1/Cam1")
onready var cam1Origin = cam1.transform.origin

onready var cam1spotlight = get_node("ViewportContainer/Viewport/SpatialParent/Spatial1/Cam1/SpotLight")


onready var cam2 = get_node("ViewportContainer/Viewport/SpatialParent/Spatial2/Cam2")
onready var cam2Origin = cam2.transform.origin

onready var cam3 = get_node("ViewportContainer/Viewport/SpatialParent/Spatial3/Cam3")
onready var cam3Origin = cam3.transform.origin

onready var cam3spotlight = get_node("ViewportContainer/Viewport/SpatialParent/Spatial3/Cam3/SpotLight")

onready var cam3_ref_point = get_node("ViewportContainer/Viewport/SpatialParent/Spatial3/ref_point")

onready var cam4 = get_node("ViewportContainer/Viewport/SpatialParent/Spatial4/Cam4")
onready var cam4light = get_node("ViewportContainer/Viewport/SpatialParent/Spatial4/Cam4/OmniLight")

onready var metroid_map = get_node("ViewportContainer/Viewport/SpatialParent/Spatial3/Cam3/MMAP")
onready var metroid_map_og = metroid_map.get_mesh().duplicate()
onready var metroid_map_mat_count = metroid_map.get_surface_material_count()

onready var warper = get_node("ViewportContainer/warper")


onready var cams = [null,cam1,cam2,cam3,cam4]

#onready var miscTex = get_paths.get_paths("res://assets/tex/metroid_prime_hologram")

onready var blinding_light = get_node("ViewportContainer/Viewport/SpatialParent/world1/hotel/blinding")



#onready var timer = Timer.new()
#timer.set_wait_time(3)
#timer.set_one_shot(true)
##self.add_child(timer)
#timer.start()
#yield(t, "timeout")

var miscTex = [
 "res://assets/tex/miscTex/0509 - Custom Robo GX (J)(Eurasia)-0.png"
,"res://assets/tex/miscTex/0509 - Custom Robo GX (J)(Eurasia)-1.png"
,"res://assets/tex/miscTex/0509 - Custom Robo GX (J)(Eurasia)-2.png"
,"res://assets/tex/miscTex/ahhh.png"
,"res://assets/tex/miscTex/cr_gx_mem.png"
,"res://assets/tex/miscTex/cr_gx_start.png"
,"res://assets/tex/miscTex/cr_gx_tex.png"
,"res://assets/tex/miscTex/F-Zero 2 - GP Legend # GBA-0.png"
,"res://assets/tex/miscTex/F-Zero 2 - GP Legend # GBA-1.png"
,"res://assets/tex/miscTex/F-Zero 2 - GP Legend # GBA-2.png"
,"res://assets/tex/miscTex/F-Zero 2 - GP Legend # GBA-3.png"
,"res://assets/tex/miscTex/F-Zero 2 - GP Legend # GBA-4.png"
,"res://assets/tex/miscTex/F-Zero 2 - GP Legend # GBA-5.png"
,"res://assets/tex/miscTex/F-Zero 2 - GP Legend # GBA-6.png"
,"res://assets/tex/miscTex/F-Zero 2 - GP Legend # GBA-7.png"
,"res://assets/tex/miscTex/F-Zero 2 - GP Legend # GBA-8.png"
,"res://assets/tex/miscTex/F-Zero 2 - GP Legend # GBA-9.png"
,"res://assets/tex/miscTex/game_and_watch_fire.png"
,"res://assets/tex/miscTex/SMSgoopspec.png"
,"res://assets/tex/miscTex/SMSkoopollution2.png"
]

#onready var cubeTexPathsLength = len(cubeTexPaths)
var all_tex = [[],[],[],[],[]]
var casinoTex = []

var hotel_tex = []


func _ready():
	cam3.look_at(cam3_ref_point.translation,Vector3(0,1,0))
#	var ahhhhhhhhhhhhhhhhh = load("res://assets/tex/ryuta/black_mat.png")
#	assert(null != ahhhhhhhhhhhhhhhhh, "FUCK")
	for tex in miscTex:
		var hhhh = load(tex)
#		print(tex,hhhh)
		hotel_tex.append(hhhh)

		
#	print(ryutaTex)
#	assert(all_tex[0] != [], "no tex again :[")
	
	pass # Replace with function body.
