extends 'res://Scripts/StateCore.gd'

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
	
	var velocity = input.normalized() * actor.move_speed
	#movement animation
	#Horizontal
	if velocity.x != 0 && velocity.y == 0:
		if velocity.x > 0:
			actor.facing_direction = actor.DIRECTIONS.E
			update_animation()
		else:
			actor.facing_direction = actor.DIRECTIONS.W
			update_animation()
	#Vertical
	if  velocity.y != 0 && velocity.x == 0:
		if velocity.y > 0:
			actor.facing_direction = actor.DIRECTIONS.S
			update_animation()
		else:
			actor.facing_direction = actor.DIRECTIONS.N
			update_animation()
	#Diagonal
	if velocity.y != 0 && velocity.x != 0:
		if velocity.x > 0 && velocity.y > 0:
			actor.facing_direction = actor.DIRECTIONS.SE
			update_animation()
		elif velocity.x < 0 && velocity.y > 0:
			actor.facing_direction = actor.DIRECTIONS.SW
			update_animation()
		elif velocity.x > 0 && velocity.y < 0:
			actor.facing_direction = actor.DIRECTIONS.NE
			update_animation()
		elif velocity.x < 0 && velocity.y < 0:
			actor.facing_direction = actor.DIRECTIONS.NW
			update_animation()
	#TODO:  Consider acceleration based movement rather than constant speed
	actor.move_and_slide(velocity)
	if velocity == Vector2():
		actor.change_state(default_animation_name)