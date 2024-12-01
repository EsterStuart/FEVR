class_name FileNode
extends Control

var file_name = "DefultName"
var file_icon

@onready var file_name_label = $FileVBoxContainer/FileNameLabel

func set_file_name(new_file_name):
	file_name = new_file_name
	file_name_label.text = new_file_name
	
