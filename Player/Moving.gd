extends 'res://Player/State.gd'

func on_enter():
	pass
	
func on_exit():
	pass

func process(delta):
	
	#Input
	var input = Vector2(0, 0)
	if Input.is_action_pressed("ui_right"):
		input.x = 1
	elif Input.is_action_pressed("ui_left"):
		input.x = -1
	else:
		input.x = 0
	if Input.is_action_pressed("ui_up"):
		input.y = -1
	elif Input.is_action_pressed("ui_down"):
		input.y = 1
	else:
		input.y = 0
		
	#movement animation
	if player.velocity.x != 0:
		if player.velocity.x > 0:
			player.sprite.play(player.east)
		else:
			player.sprite.play(player.west)
	if  player.velocity.y != 0:
		if player.velocity.y > 0:
			player.sprite.play(player.south)
			if player.velocity.x > 0:
				#anim = SE
				pass
			else:
				#anim = SW
				pass
		else:
			player.sprite.play(player.north)
			if player.velocity.x > 0:
				#anim = NE
				pass
			else:
				#anim = NW
				pass
	
	#TODO:  Consider acceleration based movement rather than constant speed
	player.velocity = input.normalized() * player.move_speed
	player.move_and_slide(player.velocity)
	
	if player.velocity == Vector2():
		player.change_state(player.IDLE)
