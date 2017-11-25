extends 'res://Scripts/StateCore.gd'

func process(delta):
	var flags = actor.get_input()
	var angle = actor.position.angle_to_point(actor.viewport.get_mouse_position())
	actor.emit_signal("move")
	#Input
	var input = Vector2(0, 0)
	
	if flags & actor.F_EAST == actor.F_EAST:
		input.x = 1
		actor.facing_direction = actor.DIRECTIONS.E
	elif flags & actor.F_WEST == actor.F_WEST:
		input.x = -1
		actor.facing_direction = actor.DIRECTIONS.W
	elif flags & actor.F_NORTH == actor.F_NORTH:
		input.y = -1
		actor.facing_direction = actor.DIRECTIONS.N
	elif flags & actor.F_SOUTH == actor.F_SOUTH:
		input.y = 1
		actor.facing_direction = actor.DIRECTIONS.S
	else:
		input.y = 0
		input.x = 0
	
	#movement calculations
	var velocity = input.normalized() * actor.speed
	
	update_animation()
	
	actor.move_and_slide(velocity)
	
	if velocity == Vector2():
		actor.change_state(default_animation_name)