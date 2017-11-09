extends "res://Player/State.gd"

func on_enter():
	player.sprite.play(player.block_anim)
	
func on_exit():
	pass

func process(delta):
	if Input.is_action_pressed("block"):
		player.combat_system.do_block()
		
	if Input.is_action_just_released("block"):
		player.change_state(player.IDLE)