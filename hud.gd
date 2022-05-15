extends Control

# The 3D viewport's scale factor. For instance, 1.0 is full resolution,
# 0.5 is half resolution and 2.0 is double resolution. Higher values look
# sharper but are slower to render. Values above 1 can be used for supersampling
# (SSAA), but filtering must be enabled for supersampling to work.
var scale_factor = 0.125

var warp_factor = 0.5

onready var viewport = $ViewportContainer/Viewport
onready var scale_label = $VBoxContainer/Scale
onready var filter_label = $VBoxContainer/Filter

var v_filter = Texture3D.CONNECT_PERSIST


func _ready():
	viewport.get_texture().flags = v_filter

	viewport.size = get_viewport().size * scale_factor
	scale_label.text = "Scale: %s%%" % str(scale_factor * 100)
	# Required to change the 3D viewport's size when the window is resized.
	# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed", self, "_root_viewport_size_changed")


func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		scale_factor = wrapf(scale_factor + 0.05, 0.1, 2.25)
		viewport.size = get_viewport().size * scale_factor
		scale_label.text = "Scale: %s%%" % str(scale_factor * 100)

	if event.is_action_pressed("ui_down"):
		scale_factor = wrapf(scale_factor - 0.05, 0.1, 2.25)
		viewport.size = get_viewport().size * scale_factor
		scale_label.text = "Scale: %s%%" % str(scale_factor * 100)

	if event.is_action_pressed("toggle_filtering"):
		# Toggle the Filter flag on the ViewportTexture.
		viewport.get_texture().flags ^= v_filter

		var filter_enabled = viewport.get_texture().flags
		filter_label.text = "Filter: %s" % ("Enabled" if filter_enabled else "Disabled")
#
#func _process(delta):
#	warp_factor = rand_range(0.05,1.0)
#	scale_factor = wrapf(warp_factor - 0.05, 0.1, 2.25)
#	viewport.size = get_viewport().size * warp_factor
#	scale_label.text = "Scale: %s%%" % str(warp_factor * 100)

# Called when the root's viewport size changes (i.e. when the window is resized).
# This is done to handle multiple resolutions without losing quality.
func _root_viewport_size_changed():
	# The viewport is resized depending on the window height.
	# To compensate for the larger resolution, the viewport sprite is scaled down.
	viewport.size = get_viewport().size * scale_factor
