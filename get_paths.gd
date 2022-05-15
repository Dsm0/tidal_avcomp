extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func get_paths(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.ends_with(".import"):
			pass
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files
