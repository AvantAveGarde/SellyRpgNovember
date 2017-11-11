extends 'res://Player/States/State.gd'

func on_enter():
	#TODO:  Directional idle animations?
	#actor.sprite.play(actor.idle_anim)
	if(actor.facing_direction == "north"):
		actor.sprite.play(actor.idle_north)
	elif(actor.facing_direction == "n_east"):
		actor.sprite.play(actor.idle_north_east)
	elif(actor.facing_direction == "east"):
		actor.sprite.play(actor.idle_east)
	elif(actor.facing_direction == "s_east"):
		actor.sprite.play(actor.idle_south_east)
	elif(actor.facing_direction == "south"):
		actor.sprite.play(actor.idle_south)
	elif(actor.facing_direction == "s_west"):
		actor.sprite.play(actor.idle_south_west)
	elif(actor.facing_direction == "west"):
		actor.sprite.play(actor.idle_west)
	elif(actor.facing_direction == "n_west"):
		actor.sprite.play(actor.idle_north_west)
	else:
		actor.sprite.play(actor.idle_south)
	.on_enter()

func process(delta, flags):
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
		actor.change_state(actor.MOVING)

	#Attack Input
	if flags & actor.F_ATTACK_HELD == actor.F_ATTACK_HELD:
		actor.charge_time_attack += delta
	if flags & actor.F_ATTACK_RELEASED == actor.F_ATTACK_RELEASED:
		if actor.charge_time_attack > actor.charge_threshold_attack && actor.combat_system.charges > 0:
			actor.change_state(actor.HEAVY_ATTACK)
		else:
			#next_action = Action.LIGHT_ATTACK
			actor.change_state(actor.LIGHT_ATTACK)
		actor.charge_time_attack = 0.0
	if flags & actor.F_BLOCK_HELD == actor.F_BLOCK_HELD:
		actor.change_state(actor.BLOCK)