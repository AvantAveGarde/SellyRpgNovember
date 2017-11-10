extends "res://Player/State.gd"

func on_enter():
	player.sprite.play(player.block_anim)
	
func on_exit():
	pass

func process(flags, delta):
	if flags & player.F_BLOCK_HELD == player.F_BLOCK_HELD:
		player.combat_system.do_block()
		
	if flags & player.F_BLOCK_RELEASED == player.F_BLOCK_RELEASED:
		player.change_state(player.IDLE)