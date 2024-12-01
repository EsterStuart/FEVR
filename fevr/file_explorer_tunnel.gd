extends Node3D

var file_node_scene = preload("res://3d_file_node.tscn")

@onready var file_node_container := $FileNodeContainer

func get_initial_directories():
	var drives = []
	for drive in range(DirAccess.get_drive_count()):
		drives.append(DirAccess.get_drive_name(drive))
		
	for drive in drives:
		var path = drive + "\\"
		open_directory(path)
			
				
func open_directory(directory_path : String):
	var directories = DirAccess.get_directories_at(directory_path)
	var files = DirAccess.get_files_at(directory_path)
	var all_files = directories + files
	populate_tunnel(all_files)
	
	
func construct_nodes(files : Array, path : String): 
	for file in files:
		var file_node : FileNode3D = FileNode3D.new()
func populate_tunnel(files : Array):
	var previous_node_pos := Vector3.ZERO
	for file in files:
		var file_node: FileNode3D = file_node_scene.instantiate()
		file_node_container.add_child(file_node)
		file_node.set_file_name(file)
		file_node.global_position.x = previous_node_pos.x - 1.5
		previous_node_pos = file_node.global_position
						
func clear_tunnel():
	for node in file_node_container.get_children():
		file_node_container.remove_child(node)
		file_node_container.queue_free()

func _ready() -> void:
	get_initial_directories()
