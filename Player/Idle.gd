extends 'res://Player/State.gd'

func on_enter():
	#TODO:  Directional idle animations?
<<<<<<< HEAD
	#player.sprite.play(player.idle_anim)
	if(player.facing_direction == "north"):
		player.sprite.play(player.idle_north)
	elif(player.facing_direction == "n_east"):
		player.sprite.play(player.idle_north_east)
	elif(player.facing_direction == "east"):
		player.sprite.play(player.idle_east)
	elif(player.facing_direction == "s_east"):
		player.sprite.play(player.idle_south_east)
	elif(player.facing_direction == "south"):
		player.sprite.play(player.idle_south)
	elif(player.facing_direction == "s_west"):
		player.sprite.play(player.idle_south_west)
	elif(player.facing_direction == "west"):
		player.sprite.play(player.idle_west)
	elif(player.facing_direction == "n_west"):
		player.sprite.play(player.idle_north_west)
	else:
		player.sprite.play(player.idle_south)
		
	#print(player.facing_direction)
	
=======
	player.sprite.play(player.idle_anim)

>>>>>>> fe94359060dcd6358d83fa6a5c805e39cd524e17
func on_exit():
	pass

func process(flags, delta):

	#Movement Input
	var input = Vector2(0, 0)
	if flags & player.F_EAST == player.F_EAST:
		input.x = 1
	elif flags & player.F_WEST == player.F_WEST:
		input.x = -1
	else:
		input.x = 0
	if flags & player.F_NORTH == player.F_NORTH:
		input.y = -1
	elif flags & player.F_SOUTH == player.F_SOUTH:
		input.y = 1
	else:
		input.y = 0

	if input != Vector2():
		player.change_state(player.MOVING)

	#Attack Input

	if flags & player.F_ATTACK_HELD == player.F_ATTACK_HELD:
		player.charge_time_attack += delta

	if flags & player.F_ATTACK_RELEASED == player.F_ATTACK_RELEASED:
		if player.charge_time_attack > player.charge_threshold_attack && player.combat_system.charges > 0:
			player.change_state(player.HEAVY_ATTACK)
		else:
			#next_action = Action.LIGHT_ATTACK
			player.change_state(player.LIGHT_ATTACK)
		player.charge_time_attack = 0.0

	if flags & player.F_BLOCK == player.F_BLOCK:
		player.change_state(player.BLOCK)