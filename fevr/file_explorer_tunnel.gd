extends Node3D

var file_node_scene = preload("res://objects/nodes/file_node_3d.tscn")
@onready var file_node_container := $FileNodeContainer

var semaphore : Semaphore = Semaphore.new()
var thread : Thread = Thread.new()

var sub_tunnel : Node3D

func create_directory(directory_path : String):
	open_directory(directory_path)

func open_directory(directory_path : String):
		var directories = DirAccess.get_directories_at(directory_path)
		var files = DirAccess.get_files_at(directory_path)
		var resources := build_resource_array(directories, files, directory_path)
		
		populate_tunnel(resources)
		print("finished_OD")
		
func build_resource_array(directories, files, directory_path : String) -> Array:
	var resource_array: Array = []
	for directory in directories:
		var directory_resource : FileResource = FileResource.new()
		directory_resource.file_name = directory
		directory_resource.path = directory_path + directory + "\\"
		directory_resource.is_directory = true
		resource_array.append(directory_resource)
	
	for file in files:
		var file_resource : FileResource = FileResource.new()
		file_resource.file_name = file
		file_resource.path = directory_path + file
		file_resource.is_directory = false
		resource_array.append(file_resource)
	
	return resource_array
	
	
func populate_tunnel(files : Array):
	var previous_node_pos := Vector3.ZERO
	var target_translate : Vector3 = Vector3.ZERO 
	for resource in files:
		if resource is FileResource:
			var file_node: FileNode3D = file_node_scene.instantiate()
			file_node_container.add_child(file_node)
#			
			file_node.file_resource = resource
			file_node.call_deferred("update_label_name")
			
			target_translate = Vector3(previous_node_pos.x - 1.5, previous_node_pos.y, previous_node_pos.z)
			file_node.call_deferred("translate", previous_node_pos)
			
			previous_node_pos = Vector3(previous_node_pos.x - 1.5, previous_node_pos.y, previous_node_pos.z)
			file_node.on_activated.connect(node_selected)
			$Timer.start()
			await $Timer.timeout

	print("Finished_PT")
	
func _on_timer_timeout() -> void:
	pass # Replace with function body.

	
func clear_tunnel():
	for node in file_node_container.get_children():
		file_node_container.remove_child(node)
		
		
func get_initial_directories():
	var drives = []
	for drive in range(DirAccess.get_drive_count()):
		drives.append(DirAccess.get_drive_name(drive))
		
	for drive in drives:
		var path = drive + "\\"
		create_directory(path)



func collapse_tunnel():
	self.clear_tunnel()
	if is_instance_valid(sub_tunnel):
		sub_tunnel.collapse_tunnel()
	self.queue_free()


func node_selected(node : FileNode3D):
	var tunnel_path = load("res://objects/tunnel/file_explorer_tunnel.tscn")
	if node.file_resource.is_directory:
		if is_instance_valid(sub_tunnel):
			sub_tunnel.collapse_tunnel()
			
		var tunnel_node : Node3D = tunnel_path.instantiate()
		self.add_child(tunnel_node)
		sub_tunnel = tunnel_node
		tunnel_node.global_position = node.global_position + Vector3(0,0,-5)
		tunnel_node.create_directory(node.file_resource.path)
		#open_directory(node.file_resource.path)
		#create_directory(node.file_resource.path)
		
	if node.file_resource.is_directory == false:
		print(node.file_resource.file_name)

#
#
#extends Node3D
#
#var file_node_scene = load("res://objects/nodes/file_node_3d.tscn")
#@onready var file_node_container := $FileNodeContainer
#
#var semaphore : Semaphore = Semaphore.new()
#var thread : Thread = Thread.new()
#var thread_2 : Thread = Thread.new()
#var thread_3 : Thread = Thread.new()
#
#@onready var thread_array : Array = [thread, thread_2, thread_3]
#
#func create_directory(directory_path : String):
	#semaphore.post()
#
	##var error = thread.start(open_directory.bind(directory_path))
	#open_directory(directory_path)
	##var error = thread.start(hello)
#
#
	#print("finished_CD")
#
#
#func open_directory(directory_path : String):
		#var directories = DirAccess.get_directories_at(directory_path)
		#var files = DirAccess.get_files_at(directory_path)
		#var resources := build_resource_array(directories, files, directory_path)
		#
		#populate_tunnel(resources)
		#
		#thread.wait_to_finish()
		#print("finished_OD")
		#
	#
 #
#func build_resource_array(directories, files, directory_path : String) -> Array:
	#var resource_array: Array = []
	#for directory in directories:
		#var directory_resource : FileResource = FileResource.new()
		#directory_resource.file_name = directory
		#directory_resource.path = directory_path + directory + "\\"
		#directory_resource.is_directory = true
		#resource_array.append(directory_resource)
	#
	#for file in files:
		#var file_resource : FileResource = FileResource.new()
		#file_resource.file_name = file
		#file_resource.path = directory_path + file
		#file_resource.is_directory = false
		#resource_array.append(file_resource)
	#
	#return resource_array
	#
#func create_node(resource : FileResource):
	##var file_node: FileNode3D = file_node_scene.instantiate()
	##var file_node: FileNode3D = file_node_scene.call_deferred("instantiate")
	#var file_node : FileNode3D = FileNode3D.create_node(resource)
	#print(file_node)
	#file_node_container.call_deferred("add_child", file_node)
	##file_node_container.add_child(file_node)
	#
	##file_node.file_resource = resource
	##file_node.call_deferred("update_label_name")
	#
	##var target_translate = Vector3(previous_node_pos.x - 1.5, previous_node_pos.y, previous_node_pos.z)
	##file_node.call_deferred("translate", previous_node_pos)
	###file_node.translate(previous_node_pos)
	##
	##previous_node_pos = Vector3(previous_node_pos.x - 1.5, previous_node_pos.y, previous_node_pos.z)
	#file_node.on_activated.connect(node_selected)
	#semaphore.post()
	#
#func populate_tunnel(files : Array):
	#var previous_node_pos := Vector3.ZERO
	#for resource in files:
		#if resource is FileResource:
			#semaphore.wait()
			#thread.start(create_node.bind(resource))
			##var file_node: FileNode3D = file_node_scene.instantiate()
			###var file_node: FileNode3D = file_node_scene.call_deferred("instantiate")
			##
			##file_node_container.call_deferred("add_child", file_node)
			###file_node_container.add_child(file_node)
			##
			##file_node.file_resource = resource
			##file_node.call_deferred("update_label_name")
			###file_node.update_label_name()
			##
			###var target_translate = Vector3(previous_node_pos.x - 1.5, previous_node_pos.y, previous_node_pos.z)
			###file_node.call_deferred("translate", previous_node_pos)
			####file_node.translate(previous_node_pos)
			###
			###previous_node_pos = Vector3(previous_node_pos.x - 1.5, previous_node_pos.y, previous_node_pos.z)
			###file_node.on_activated.connect(node_selected)
	#
	#print("Finished_PT")
	#
							#
#func clear_tunnel():
	#for node in file_node_container.get_children():
		#file_node_container.remove_child(node)
		#
		#
#func get_initial_directories():
	#var drives = []
	#for drive in range(DirAccess.get_drive_count()):
		#drives.append(DirAccess.get_drive_name(drive))
		#
	#for drive in drives:
		#var path = drive + "\\"
		#create_directory(path)
#
#
#func _ready() -> void:
	#get_initial_directories()
#
#
#
#func node_selected(node : FileNode3D):
	#if node.file_resource.is_directory:
		#clear_tunnel()
		##open_directory(node.file_resource.path)
		#create_directory(node.file_resource.path)
	#if node.file_resource.is_directory == false:
		#print(node.file_resource.file_name)


func _on_destroy_tunnel_button_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
			collapse_tunnel()
