extends Node

var oscrcv
var cube
var sky

func _ready():
	cube = get_node( "cube" )
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

func fx(energy,frequency_bin):
	pass

func viz(x):
	pass

func _process(delta):
	while( oscrcv.has_message() ): 	# check if there are pending messages
		var msg = oscrcv.get_next()	# retrieval of the messages as a dictionary
		# using message data
		var args = msg["args"]
		var arg_num = msg["arg_num"]
		viz(parse_args(args,arg_num))
	pass
	
func _exit_tree():
	oscrcv.stop()					# stops listening to port, highly recommended!

