extends 'res://Player/States/State.gd'

func process(delta):
	var flags = actor.get_input()
	actor.emit_signal("move")
	#Input
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
	
	#movement animation
	#Horizontal
	if actor.velocity.x != 0 && actor.velocity.y == 0:
		if actor.velocity.x > 0:
			actor.sprite.play(actor.east)
			actor.facing_direction = "east"
		else:
			actor.sprite.play(actor.west)
			actor.facing_direction = "west"
	#Vertical
	if  actor.velocity.y != 0 && actor.velocity.x == 0:
		if actor.velocity.y > 0:
			actor.sprite.play(actor.south)
			actor.facing_direction = "south"
		else:
			actor.sprite.play(actor.north)
			actor.facing_direction = "north"
	#Diagonal
	if actor.velocity.y != 0 && actor.velocity.x != 0:
		if actor.velocity.x > 0 && actor.velocity.y > 0:
			actor.sprite.play(actor.s_east)
			actor.facing_direction = "s_east"
		elif actor.velocity.x < 0 && actor.velocity.y > 0:
			actor.sprite.play(actor.s_west)
			actor.facing_direction = "s_west"
		elif actor.velocity.x > 0 && actor.velocity.y < 0:
			actor.sprite.play(actor.n_east)
			actor.facing_direction = "n_east"
		elif actor.velocity.x < 0 && actor.velocity.y < 0:
			actor.sprite.play(actor.n_west)
			actor.facing_direction = "n_west"
	#TODO:  Consider acceleration based movement rather than constant speed
	actor.velocity = input.normalized() * actor.move_speed
	actor.move_and_slide(actor.velocity)
	if actor.velocity == Vector2():
		actor.change_state(actor.IDLE)