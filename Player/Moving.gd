extends 'res://Player/State.gd'

func on_enter():
	pass
	
func on_exit():
	pass

func process(flags, delta):
	
	#Input
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
		
	#movement animation
	
	#Horizontal
	if player.velocity.x != 0 && player.velocity.y == 0:
		if player.velocity.x > 0:
			player.sprite.play(player.east)
			player.facing_direction = "east"
		else:
			player.sprite.play(player.west)
			player.facing_direction = "west"
	
	#Vertical
	if  player.velocity.y != 0 && player.velocity.x == 0:
		if player.velocity.y > 0:
			player.sprite.play(player.south)
			player.facing_direction = "south"
		else:
			player.sprite.play(player.north)
			player.facing_direction = "north"
	
	#Diagonal
	if player.velocity.y != 0 && player.velocity.x != 0:
		if player.velocity.x > 0 && player.velocity.y > 0:
			player.sprite.play(player.s_east)
			player.facing_direction = "s_east"
		elif player.velocity.x < 0 && player.velocity.y > 0:
			player.sprite.play(player.s_west)
			player.facing_direction = "s_west"
		elif player.velocity.x > 0 && player.velocity.y < 0:
			player.sprite.play(player.n_east)
			player.facing_direction = "n_east"
		elif player.velocity.x < 0 && player.velocity.y < 0:
			player.sprite.play(player.n_west)
			player.facing_direction = "n_west"
		
	
	#TODO:  Consider acceleration based movement rather than constant speed
	player.velocity = input.normalized() * player.move_speed
	player.move_and_slide(player.velocity)
	
	if player.velocity == Vector2():
		player.change_state(player.IDLE)
