extends Node

onready var screen_size = get_viewport().get_visible_rect().size
onready var player = get_node("Player")

func _ready():
	update_camera()
	
	
func update_camera():
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = -player.position + screen_size / 2
	get_viewport().set_canvas_transform(canvas_transform)