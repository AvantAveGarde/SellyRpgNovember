extends 'res://Player/State.gd'

func on_enter():
	player.sprite.play(player.light_attack_anim)
	player.combat_system.do_light_attack()

func on_exit():
	pass

func process(flags, delta):
	pass
	
func on_animation_finished():
	player.change_state(player.IDLE)
