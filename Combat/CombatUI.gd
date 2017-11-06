extends Control

export(Texture) var fire_texture
export(Texture) var water_texture
export(Texture) var air_texture
export(Texture) var earth_texture

onready var CombatCore = preload("res://Combat/CombatCore.gd")

var charge_label
var charge_image

func _ready():
	charge_label = get_node("TextureRect/Label")
	charge_image = get_node("TextureRect")

func set_charges(value):
	charge_label.set_text(str(value))

func set_charge_texure(type):
	if type == CombatCore.ChargeType.FIRE:
		charge_image.texture = fire_texture
	elif type == CombatCore.ChargeType.WATER:
		charge_image.texture = water_texture
	elif type == CombatCore.ChargeType.AIR:
		charge_image.texture = air_texture
	elif type == CombatCore.ChargeType.EARTH:
		charge_image.texture = earth_texture