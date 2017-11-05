extends Control

var charge_label

func _ready():
	charge_label = get_node("TextureRect/Label")

func set_charges(value):
	charge_label.set_text(str(value))