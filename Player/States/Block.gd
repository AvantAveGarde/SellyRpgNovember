extends "res://Scripts/StateBlock.gd"

func process(delta):
	var flags = actor.get_input()
	#if flags & actor.F_BLOCK_HELD == actor.F_BLOCK_HELD:
		#pass
	if flags & actor.F_BLOCK_RELEASED == actor.F_BLOCK_RELEASED:
		actor.change_state(default_animation_name)