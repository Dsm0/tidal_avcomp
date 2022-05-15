extends "res://viz/longest_night_assets.gd"

onready var active_cam = cam1
onready var active_light = cam1.get_child(0)
onready var active_light_origin = active_light.transform.origin

onready var active_cam_near_og = active_cam.near
onready var active_cam_far_og = active_cam.far


onready var active_spatial = spatial1
onready var active_spatial_rot_og = spatial1.rotation

#onready var active_focus = cam1.get_child(1)
#onready var active_focus_origin = active_focus.transform.origin
#onready var active_focus_mat_count = active_focus.get_surface_material_count()

onready var fov = 95


onready var active_cam_far_scale = 10

onready var active_tex = all_tex[0]

var idx = 0
var vary = 0.01

var far_min = 1
var near_min = 0.05

var warp_factor = 1
#var min_angle = 1

var hat_count = 0
var core_count = 0

var warp808 = false

onready var hotel_transform = hotel.get_transform()

#	really nice to just have a globle var w/ volume  
onready var curr_vol = 1
var vol_scale = 10

var cam3_trigger = false

func changeIdx(i):
#	print(cams)
	active_cam = cams[i]
	active_cam.make_current()
	active_light = active_cam.get_child(0)
	active_light_origin = active_light.transform.origin
	
#	active_focus = active_cam.get_child(1)
#	active_focus_origin = active_focus.transform.origin
#	active_focus_mat_count = active_focus.get_surface_material_count()
#	active_tex = all_tex[i]

	active_cam.near = 0.05
	
	if i == 4:
		warp_factor = 2
		cam4light.visible = true
	
func warp1(vector):
	return Vector3(vector.x + (randf()-0.5)*vary,vector.y + (randf()-0.5)*vary,vector.z + (randf()-0.5)*vary)

onready var func_ref = funcref(self,"warp1")

func fx(energies,vol):
	var bin = 0

#	for energy in energies:
#		if(energy > 0.0000002):
#			if (bin <= 2):
#				pass
#	#			cubes.cam.set_fov(160 - 80*avg_energy())
#			elif (2 < bin && bin < 4):
#				pass
#			elif (4 <= bin && bin < 6):
##				cam1spotlight.set('spot_angle',min_angle + curr_vol)
#				pass
#	#			cubes.cam.set_translation(cubes.camOrigin + Vector3(0,avg_energy(),0))	
#			elif (bin == 1):
#				pass
#	#			cubes.cafe.material_override.set_emission_energy(10*energy)
#	#	$"VBoxContainer2/OSCPrint".outline_size = energy*20.0
#		bin += 1
		
	curr_vol = vol*vol_scale
	
	if active_cam != cam4:
		active_cam.set('far',far_min + curr_vol*active_cam_far_og)
	active_cam.set('near',near_min + curr_vol*0.5)
	
	if warp808:
		warper.material.set("shader_param/rotation",curr_vol)
	else:
		warper.material.set("shader_param/rotation",0)
#				
#	var huh = vol * 100
#	var huh = pow(10,huh)

#	last_energy.push_front(energy)
#	last_energy.pop_back()

# params is a list of all tidal parameters listed, like "gain" and 
func viz(params):
	var begin = 0.0
	var n = 5
	var cycle = 0
	var delta = 0
	var speed = 1.0
	var far = 80
	var near = 0.05
	var fov = 70
	var spot_angle = 2
	var tex_shuffle = 0
	
	if params.has("begin"):
		begin = float(params["begin"])
	if params.has("delta"):
		delta = float(params["delta"])
	if params.has("speed"):
		speed = float(params["speed"])
	if params.has("n"):
		n = int(params["n"])

	if params.has("cam_fov"):
		fov = float(params["cam_fov"])
		active_cam.set_fov(fov)
		
	if params.has("cam_far"):
		far = float(params["cam_far"])
		active_cam.set('far',far)
		
	if params.has("cam_near"):
		near = float(params["cam_near"])
		active_cam.set('near',near)
		
	if params.has("spot_angle"):
		spot_angle = float(params["spot_angle"])
		cam1spotlight.set('spot_angle',spot_angle)
	
	if params.has("cycle"):
		cycle = float(params["cycle"])

	if params.has("cam"):
#		print(int(params["cam"]))
		changeIdx(int(params["cam"]))

	if params.has("s"):
		match params["s"]:
			"tick":
#				fov = fmod(fov + randf(),fov+1)
#				cube2.set_rotation(Vector3(fmod(cycle,360.0),fmod(0.25*cycle,360.0),fmod(0.5*cycle,360.0)))
				blinding_light.light_negative = true
			"808bd","808":
				active_spatial.rotate_y(0.03)
				
				if n==4:
#					will be bassy, 
#					TODO: add some warping shader here
					warp808 = true
					pass
				else:
					warper.material.set("shader_param/rotation",0)

				pass
			"ginseng_kicks":
				active_spatial.rotate_y(0.07)
				warp808 = false
				pass
			"ginseng_808":
				active_spatial.rotate_y(0.2)
				pass
			"ginseng_hats","ginseng_crashes_cymbals":
				warp_with.warp_with(hotel, hat_count % hotel_mat_count,warp_factor,func_ref)
				hat_count += 1
				pass
			"reset_warp":
				hotel.set_mesh(hotel_mesh_og.duplicate())
				pass
			"reset_rot":
				active_spatial.rotation = active_spatial_rot_og
				pass
			"reset_matrix_transform":
				hotel.set_transform(Transform(
					Basis(
						Vector3(1,0,0),
						Vector3(0,1,0),
						Vector3(0,0,1)
					),
					Vector3(0,0,0)
				))
#				likely for use w/ cam 4
				pass
			"cam3_trigger":
				cam3_trigger = true
				hotel.scale = Vector3(1,1,500)
				cam3.fov = 70
				cam3.far = 70
				cam3.near = 0.05
				cam3.translation = Vector3(2.1,0.25,2500)
				warp_factor = 1.05
				hotel.set_transform(Transform(
					Basis(
						Vector3(1,0,0),
						Vector3(0,1,0),
						Vector3(0,0,1)
					),
					Vector3(0,0,0)
				))
				pass
			"blinding_dark","ginseng_snares_claps":
				blinding_light.light_negative = false
				pass
			"blinding_toggle":
				blinding_light.visible = !blinding_light.visible
				pass
			"tex_shuffle":
				shuffle_tex.shuffle_tex(hotel,hotel_tex)
				pass
			"feel":
				if speed == 2:
					blinding_light.light_negative = false
				pass
			"ghost_cuts":
#				TODO: randomly matrix transform the hotel
				hotel.set_transform(Transform(
					Basis(
						Vector3(3*randf(),0,0),
						Vector3(0,3*randf(),0),
						Vector3(0,0,3*randf())
					),
					Vector3(0,0,0)
				))
				active_cam.fov = 40 + 40*randf()
				cam3spotlight.light_negative = !cam3spotlight.light_negative
				pass
			"fa_chirp":
				shuffle_tex.shuffle_tex(hotel,hotel_tex)
				warp_with.warp_with(hotel,int(cycle) % hotel_mat_count,4 ,func_ref)
#				shuffle_tex.shuffle_tex(active_focus,active_tex)
				pass
			"ryanjamescarr":
				cam4light.translate_object_local(Vector3(0,0,(fmod(curr_vol,15) - 10)))
				pass
			"breakcore_evenmorebreaks":
				warp_with.warp_with(metroid_map, core_count % metroid_map_mat_count,warp_factor,func_ref)
			_:
				cam3spotlight.light_negative = !cam3spotlight.light_negative
				core_count += 1
				pass
			# cube.material_override.albedo_texture = cubeTex[int(params["n"]) % cubeTexPathsLength]
#	active_cam.set_fov(fov)
	
		last_ss.push_front(params["s"])
		last_ss.pop_back()
	$"VBoxContainer2/OSCPrint".text = str(params)
	
func _process(delta):
	if cam3_trigger:
		cam3.translation.z -= 1
		metroid_map.rotate_x(randf()*0.01)
		metroid_map.rotate_y(randf()*0.01)
		metroid_map.rotate_z(randf()*0.01)
		pass
#	$"ViewportContainer/Viewport/Spatial/Camera1/c_robo_icon".transform.looking_at(active_cam.transform.origin,Vector3.UP)
#	$"ViewportContainer/Viewport/Spatial/Camera2/c_robo_icon2".transform.looking_at(active_cam.transform.origin,Vector3.UP)
#	$"ViewportContainer/Viewport/Spatial/Camera3/c_robo_icon3".transform.looking_at(active_cam.transform.origin,Vector3.UP)
#	$"ViewportContainer/Viewport/Spatial/Camera4/c_robo_icon4".transform.looking_at(active_cam.transform.origin,Vector3.UP)
#	$"ViewportContainer/Viewport/Spatial/Camera5/c_robo_icon5".transform.looking_at(active_cam.transform.origin,Vector3.UP)
#


