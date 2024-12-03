class_name FileNode3D
extends Area3D

var file_resource : FileResource 

@onready var node_mesh := $NodeMesh
@onready var file_dialog := $FileDialog
signal on_activated(node : FileNode3D)
@onready var file_name_label = $NodeLabel

func update_label_name() -> void:
	file_name_label.text = file_resource.file_name
	
#
	#var image = Image.new()
	#image.load(new_path)
	#var image_texture = ImageTexture.new()
	#image_texture.set_image(image)
	#var spat_mat = node_mesh.get_surface_override_material(0)
	#spat_mat.set_texture(StandardMaterial3D.TEXTURE_ALBEDO ,image_texture)


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
			on_activated.emit(self)


#
#class_name FileNode3D
#extends Area3D
#
#var file_resource : FileResource 
#
#@onready var node_mesh := $NodeMesh
#@onready var file_dialog := $FileDialog
#signal on_activated(node : FileNode3D)
#@onready var file_name_label = $NodeLabel
#
#
#
#static func create_node(resource : FileResource) -> FileNode3D:
	#var node_scene = load("res://objects/nodes/file_node_3d.tscn")
	#var new_node : FileNode3D = node_scene.instantiate()
	#new_node.file_resource = resource
	#return new_node
#
#func _ready() -> void:
	#update_label_name()
	#
#func update_label_name() -> void:
	#file_name_label.text = file_resource.file_name
	#
##
	##var image = Image.new()
	##image.load(new_path)
	##var image_texture = ImageTexture.new()
	##image_texture.set_image(image)
	##var spat_mat = node_mesh.get_surface_override_material(0)
	##spat_mat.set_texture(StandardMaterial3D.TEXTURE_ALBEDO ,image_texture)
#
#
#func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
			#on_activated.emit(self)
