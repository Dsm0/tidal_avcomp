extends "res://audio_tidal_receiver.gd"

const GetPaths = preload("res://get_paths.gd")
onready var get_paths = GetPaths.new()

func get_origin(model):
	return model.transform.origin

onready var MeshVertexWarp = preload("res://scripts/MeshVertexWarp.gd")
onready var warp_with = MeshVertexWarp.new()

onready var ShuffleTex = preload("res://scripts/shuffle_tex.gd")
onready var shuffle_tex = ShuffleTex.new()

var last_ss = [0,0,0]

var last_energy = [0,0,0,0,0,0,0]
var last_energy_len

func _ready():
	var i = 0
#	print(cubeTexPaths)
	last_energy_len = last_energy.size()

func fmod(x,y):
	return x - y * floor(x / y)


func avg_energy():
	var sum = 0.0
	for element in last_energy:
		sum += element
	return sum/last_energy_len
