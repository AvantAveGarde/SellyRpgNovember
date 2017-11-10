extends Node

var player

func _ready():
	
	player = get_node("../..")
	
	set_process(false)
	set_physics_process(false)
	set_process_input(false)

func on_enter():
	pass
	
func on_exit():
	pass
	
func process(flags, delta):
	pass