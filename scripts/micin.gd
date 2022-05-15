# Declare member variables here. Examples:
# var a = 2
# var b = "text"
extends Node


# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

const VU_COUNT = 3
const VU_MAX = 12
const FREQ_MAX = 11050.0

const WIDTH = 400
const HEIGHT = 100

const MIN_DB = 60

var spectrum
var iter = 0
const AVG_WINDOW = 8
var energies = []

const WEIGHT_REDUCTION = 1


func iterate_array_values():
	var sum = 0.0
	for i in range(0,AVG_WINDOW):
		sum += energies[i]
		energies[i] *= WEIGHT_REDUCTION
	return sum / AVG_WINDOW

func get_avg_energy(energy):
	energies[iter] = energy
	iter = (iter + 1) % AVG_WINDOW
	return iterate_array_values();

func fx(energy,i):
	var fov
	if [0,1,2,3].has(i):
		energy = get_avg_energy(energy)
		if energy > 0.00001:
			fov = 120 - 30*smoothstep(0,0.5,energy)
			$Spatial3.translate(Vector3(0,fov,0))
			$"../../../VBoxContainer/Energy".text = "fov: %s, energy: %s" % [fov, energy]

func _process(_delta):
	$Camera3D.rotate_x(_delta)
	$Camera3D.rotate_y(_delta*2)
	$Camera3D.rotate_z(_delta*0.5)
		#warning-ignore:integer_division
	var prev_hz = 0
#	var audioData = "(max_freq,energy): "
	for i in range(0, VU_MAX):
		var hz = i * FREQ_MAX / VU_COUNT;
		var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		var energy = clamp((MIN_DB + linear2db(magnitude)) / MIN_DB, 0, 1)
#		draw_rect(Rect2(w * i, HEIGHT - height, w, height), Color.white)
		prev_hz = hz
		fx(energy,i)
		

func _ready():
	energies.resize(AVG_WINDOW)
	for i in range(energies.size()):
		energies[i] = 0
	spectrum = AudioServer.get_bus_effect_instance(0,0)
