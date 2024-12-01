extends Node

@onready var file_container := $GridContainer
var file_node_scene = preload("res://file_node.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var drives = []
	for drive in range(DirAccess.get_drive_count()):
		drives.append(DirAccess.get_drive_name(drive))
		
		
		
	for drive in drives:
		var path = drive + "\\"
		var directories = []
		for directory in DirAccess.get_directories_at(path):
			directories.append(directory)
		
		for directory in directories:
			var directory_path = path + directory + "\\"
			var files = DirAccess.get_files_at(directory_path)
			
			if files:
				for file in files:
					var file_node: FileNode = file_node_scene.instantiate()
					file_container.add_child(file_node)
					file_node.set_file_name(file)
					
				
		
