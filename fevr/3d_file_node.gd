class_name FileNode3D
extends Node3D

var file_name := "DefultName"
var directory_path := ""
var file_path := ""
var file_icon := ""

@onready var file_name_label = $NodeLabel

func set_file_name(new_file_name):
	file_name = new_file_name
	file_name_label.text = new_file_name
	


func _on_node_input_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		print("Hi")
