extends Node

var actor

func _ready():
	actor = get_node("../..")
	set_process(false)
	set_physics_process(false)
	set_process_input(false)

func on_enter():
	pass
	
func on_exit():
	pass
	
func process(delta):
	pass

func on_animation_finished():
	pass

func on_frame_changed():
	pass