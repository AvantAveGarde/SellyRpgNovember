extends 'res://Scripts/StateCore.gd'

func process(delta):
	var flags = actor.get_input()
	var angle = actor.position.angle_to_point(actor.viewport.get_mouse_position())
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
	
	#movement calculations
	var velocity = input.normalized() * actor.speed
	
	#movement animation
	
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
	
	actor.move_and_slide(velocity)
	
	if velocity == Vector2():
		actor.change_state(default_animation_name)