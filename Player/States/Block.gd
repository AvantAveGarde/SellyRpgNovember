extends "res://Scripts/StateCore.gd"

func process(delta):
	var flags = actor.get_input()
	#if flags & actor.F_BLOCK_HELD == actor.F_BLOCK_HELD:
		#pass
	if flags & actor.F_BLOCK_RELEASED == actor.F_BLOCK_RELEASED:
		actor.change_state(default_animation_name)

# TODO Check if the attack direction in order to know if the attack had been blocked properly.
func on_damage(attack):
	var damage = attack.get_total_damage()
	var reduction = actor.get_armor() + actor.get_block() - attack.damage_penetration
	if reduction < 0:
		reduction = 0
	actor.health -= damage - reduction
	attack.on_actor_blocked(actor)
	if (actor.health <= 0):
		actor.on_kill()