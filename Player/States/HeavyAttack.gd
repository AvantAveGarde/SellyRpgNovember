extends 'res://Player/States/BaseAttack.gd'

func on_enter():
	actor.sprite.play(actor.heavy_attack_anim)
	#player.combat_system.do_heavy_attack()
	.on_enter()

func on_animation_finished():
	actor.change_state("Idle")