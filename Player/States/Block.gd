extends "res://Player/States/State.gd"

func on_enter():
	actor.sprite.play(actor.block_anim)
	.on_enter()

func process(delta, flags):
	if flags & actor.F_BLOCK_HELD == actor.F_BLOCK_HELD:
		actor.combat_system.do_block()
		
	if flags & actor.F_BLOCK_RELEASED == actor.F_BLOCK_RELEASED:
		actor.change_state(actor.IDLE)