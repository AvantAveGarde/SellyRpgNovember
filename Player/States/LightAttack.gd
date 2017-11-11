extends 'res://Player/States/BaseAttack.gd'

func on_enter():
	actor.sprite.play(actor.light_attack_anim)
	#actor.combat_system.do_light_attack()
	.on_enter()