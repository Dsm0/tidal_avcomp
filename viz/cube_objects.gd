extends "res://viz/init.gd"

# Called when the node enters the scene tree for the first time.

onready var cube = get_node("ViewportContainer/Viewport/Spatial/Cube")
onready var cubeOrigin = cube.transform.origin
onready var cube2 = get_node("ViewportContainer/Viewport/Spatial/Cube2")
onready var cube2Origin = cube2.transform.origin

onready var cam = get_node("ViewportContainer/Viewport/Spatial/Camera")
onready var camOrigin = cam.transform.origin

onready var cafe = get_node("ViewportContainer/Viewport/Spatial/cafe")
onready var cafeOrigin = cafe.transform.origin
onready var cafeMat = cafe.get_mesh().surface_get_material(0)

onready var cafe2 = get_node("ViewportContainer/Viewport/Spatial/cafe2")
onready var cafe2Origin = cafe2.transform.origin

onready var cubeTexPaths = get_paths.get_paths("res://assets/cube_tex")
# ["res://assets/cube_tex/1.png","res://assets/cube_tex/2.png","res://assets/cube_tex/3.png","res://assets/cube_tex/4.png","res://assets/cube_tex/5.png","res://assets/cube_tex/6.png","res://assets/cube_tex/7.png","res://assets/cube_tex/8.png","res://assets/cube_tex/9.png","res://assets/cube_tex/10.png","res://assets/cube_tex/11.jpg","res://assets/cube_tex/12.png"]
onready var cubeTexPathsLength = len(cubeTexPaths)

var cubeTex = []

func _ready():
	for tex in cubeTexPaths:
		cubeTex.append(load(tex))
	pass # Replace with function body.
