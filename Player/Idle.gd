extends 'res://Player/State.gd'

func on_enter():
	#TODO:  Directional idle animations?
	player.sprite.play(player.idle_anim)
	
func on_exit():
	pass

func process(delta):
	
	#Movement Input
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
		
	if input != Vector2():
		player.change_state(player.MOVING)
		
	#Attack Input
	
	if Input.is_action_pressed("attack"):
		player.charge_time_attack += delta
		
	if Input.is_action_just_released("attack"):
		if player.charge_time_attack > player.charge_threshold_attack && player.combat_system.charges > 0:
			player.change_state(player.HEAVY_ATTACK)
		else:
			#next_action = Action.LIGHT_ATTACK
			player.change_state(player.LIGHT_ATTACK)
		player.charge_time_attack = 0.0
		
	if Input.is_action_just_pressed("block"):
		player.change_state(player.BLOCK)