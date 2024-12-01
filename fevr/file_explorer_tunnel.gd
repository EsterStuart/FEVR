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
	print(directory_path)
	var directories = DirAccess.get_directories_at(directory_path)
	var files = DirAccess.get_files_at(directory_path)
	var resources := build_directory_resources(directories, directory_path)
	
	var file_resources := build_file_resources(files, directory_path)
	resources.append_array(file_resources)
	populate_tunnel(resources)
	
func build_directory_resources(directories, path) -> Array:
	var resoure_array : Array = []
	for directory in directories:
		var directory_resource : FileResource = FileResource.new()
		directory_resource.file_name = directory
		directory_resource.path = path + directory + "\\"
		directory_resource.is_directory = true
		resoure_array.append(directory_resource)
	return resoure_array
	
func build_file_resources(files, path) -> Array:
	var resource_array : Array = []
	for file in files:
			var file_resource : FileResource = FileResource.new()
			file_resource.file_name = file
			file_resource.path = path + file
			file_resource.is_directory = false
			resource_array.append(file_resource)
	return resource_array
		
func populate_tunnel(files : Array):
	var previous_node_pos := Vector3.ZERO
	for resource in files:
		if resource is FileResource:
			var file_node: FileNode3D = file_node_scene.instantiate()
			file_node_container.add_child(file_node)
			file_node.set_file_name(resource.file_name)
			file_node.path = resource.path
			file_node.global_position.x = previous_node_pos.x - 1.5
			file_node.on_activated.connect(node_selected)
			file_node.is_directory = resource.is_directory
			previous_node_pos = file_node.global_position
			
							
func clear_tunnel():
	for node in file_node_container.get_children():
		file_node_container.remove_child(node)

func _ready() -> void:
	get_initial_directories()

func node_selected(node : FileNode3D):
	if node.is_directory:
		clear_tunnel()
		open_directory(node.path)
		
