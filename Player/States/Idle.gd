extends 'res://Scripts/StateCore.gd'

func process(delta):
	#Getting our facing angle via mouse position
	var angle = actor.position.angle_to_point(actor.viewport.get_mouse_position())
	
	var flags = actor.get_input()
	var input = Vector2(0, 0)
	
	#Movement Input
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
	
	#Keeping momentum the moment we let go of the move key. aka deceleration
	if input == Vector2():
		actor.move_speed -= actor.deceleration * delta
	actor.move_speed = clamp(actor.move_speed, 0, actor.max_speed)
	var velocity = actor.previous_direction.normalized() * actor.move_speed
	actor.move_and_slide(velocity)
	
	#Idle Direction
	if input == Vector2():
		if angle > 3 * PI/8 and angle <= 5 * PI/8:
			actor.facing_direction = actor.DIRECTIONS.N
		elif angle >  5 * PI/8 and angle <= 7 * PI/8:
			actor.facing_direction = actor.DIRECTIONS.NE
		elif (angle > 7 * PI/8 and angle <= PI) or (angle > -PI and angle <= -7 *PI/8):
			actor.facing_direction = actor.DIRECTIONS.E
		elif angle > -7 * PI/8 and angle <= -5 * PI/8:
			actor.facing_direction = actor.DIRECTIONS.SE
		elif angle > -5 * PI/8 and angle <= -3 * PI/8:
			actor.facing_direction = actor.DIRECTIONS.S
		elif (angle > -3 * PI/8 and angle <= -PI/8):
			actor.facing_direction = actor.DIRECTIONS.SW
		elif (angle > -PI/8 and angle <= 0) or (angle >= 0 and angle <= PI/8):
			actor.facing_direction = actor.DIRECTIONS.W
		elif (angle > PI/8 and angle <= 3 * PI/8):
			actor.facing_direction = actor.DIRECTIONS.NW
		update_animation()

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