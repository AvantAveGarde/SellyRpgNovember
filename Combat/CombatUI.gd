extends Control

#export(Texture) var fire_texture
#export(Texture) var water_texture
#export(Texture) var air_texture
#export(Texture) var earth_texture

var player
var charge_label
var mouse_cursor
var viewport
#var charge_image

func _ready():
	charge_label = get_node("TextureRect/Label")
	mouse_cursor = get_node("Cursor")
	#charge_image = get_node("TextureRect")
	player = get_node("../Player")
	viewport = get_viewport()
	
#TODO: Change to use signals.
func _process(delta):
	set_charges(player.charges)
	mouse_cursor.set_position(viewport.get_mouse_position())

func set_charges(value):
	charge_label.set_text(str(value))

#func set_charge_texure(type):
#	match type:
#		GlobalValues.Element.FIRE:
#			charge_image.texture = fire_texture
#		GlobalValues.Element.WATER:
#			charge_image.texture = water_texture
#		GlobalValues.Element.AIR:
#			charge_image.texture = air_texture
#		GlobalValues.Element.EARTH:
#			charge_image.texture = earth_texture