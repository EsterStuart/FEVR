class_name FileNode3D
extends Area3D

var file_name := "DefultName"
var path := ""
var is_directory := false

signal on_activated(node : FileNode3D)

@onready var file_name_label = $NodeLabel

func set_file_name(new_file_name):
	file_name = new_file_name
	file_name_label.text = new_file_name
	


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
			on_activated.emit(self)
