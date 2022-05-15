extends Node

const VU_COUNT = 3
const VU_MAX = 12
const FREQ_MAX = 11050.0

const MIN_DB = 60

const FFT_SIZE = 24

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

func fx(energies,vol):
	pass
	
	
#	var fov
#	for i in ern
#	if [0,1,2,3,4,5,6,7,8,9,10,11].has(i):
#		energy = get_avg_energy(energy)
#		if energy > 0.00001:
#			fov = 120 - 30*smoothstep(0,0.5,energy)
##			$Spatial3.translate(Vector3(0,fov,0))
##			$"../../../VBoxContainer/Energy".text = "fov: %s, energy: %s" % [fov, energy]

func audio_process(_delta):
		#warning-ignore:integer_division
	var vol: float = 1
	var prev_hz = 0
#	var audioData = "(max_freq,energy): "
	var energies = []
	for i in range(0, VU_MAX):
		var hz = i * FREQ_MAX / VU_COUNT;
		var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		
		
		var energy = clamp((MIN_DB + linear2db(magnitude)) / MIN_DB, 0, 1)
#		var vol_energy = clamp((MIN_DB + linear2db(vol)) / MIN_DB, 0, 1)
		energies.append(energy)
		prev_hz = hz
#		vol = capture.get_buffer(FRAME_COUNT).sum()/FRAME_COUNT
	vol= spectrum.get_magnitude_for_frequency_range(20,20,000).x
	
	fx(energies,vol)

func audio_ready():
	energies.resize(AVG_WINDOW)
	for i in range(energies.size()):
		energies[i] = 0
	spectrum = AudioServer.get_bus_effect_instance(0,0)

var oscrcv
var sky

func tidal_ready():
	oscrcv = load("res://addons/gdosc/gdoscreceiver.gdns").new()
	oscrcv.max_queue( 20 ) 			# maximum number of messages in the buffer, default is 100
	oscrcv.avoid_duplicate( true )	# receiver will only keeps the "latest" message for each address
	oscrcv.setup( 14000 )			# listening to port 14000
	oscrcv.start()					# starting the reception of messages

var params = {}

func parse_args(args,arg_num):
	for i in range(0,arg_num,2):
		params[args[i]] = args[i+1]
	return params

func viz(x):
	pass

func tidal_process(delta):
	while( oscrcv.has_message() ): 	# check if there are pending messages
		var msg = oscrcv.get_next()	# retrieval of the messages as a dictionary
		# using message data
		var args = msg["args"]
		var arg_num = msg["arg_num"]
		viz(parse_args(args,arg_num))
	pass
	
func tidal_exit_tree():
	oscrcv.stop()					# stops listening to port, highly recommended!

func _ready():
	audio_ready()
	tidal_ready()
	
func _process(_delta):
	audio_process(_delta)
	tidal_process(_delta)

func _exit_tree():
	tidal_exit_tree()
