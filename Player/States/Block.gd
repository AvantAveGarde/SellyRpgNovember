extends "res://Scripts/StateCore.gd"

func on_enter():
	actor.sprite.play(actor.block_anim)
	.on_enter()

func process(delta):
	var flags = actor.get_input()
	#if flags & actor.F_BLOCK_HELD == actor.F_BLOCK_HELD:
		#pass
	if flags & actor.F_BLOCK_RELEASED == actor.F_BLOCK_RELEASED:
		actor.change_state("Idle")