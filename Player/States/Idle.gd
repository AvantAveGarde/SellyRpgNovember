extends 'res://Scripts/StateCore.gd'

func process(delta):
	var flags = actor.get_input()
	#Movement Input
	var input = Vector2(0, 0)
	if flags & actor.F_EAST == actor.F_EAST:
		input.x = 1
	elif flags & actor.F_WEST == actor.F_WEST:
		input.x = -1
	else:
		input.x = 0
	if flags & actor.F_NORTH == actor.F_NORTH:
		input.y = -1
	elif flags & actor.F_SOUTH == actor.F_SOUTH:
		input.y = 1
	else:
		input.y = 0

	if input != Vector2():
		actor.change_state("Moving")

	#Attack Input
	if flags & actor.F_ATTACK_HELD == actor.F_ATTACK_HELD:
		actor.charge_time_attack += delta
	if flags & actor.F_ATTACK_RELEASED == actor.F_ATTACK_RELEASED:
		if actor.charge_time_attack > actor.charge_threshold_attack && actor.charges > 0:
			actor.change_state("HeavyAttack")
		else:
			#next_action = Action.LIGHT_ATTACK
			actor.change_state("LightAttack")
		actor.charge_time_attack = 0.0
	if flags & actor.F_BLOCK_HELD == actor.F_BLOCK_HELD:
		actor.change_state("Block")