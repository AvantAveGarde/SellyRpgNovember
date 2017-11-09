extends Node

export var moveSpeed = 200
var velocity = Vector2()

var anim = IDLE
var sprite
var kinematic_body
signal move

enum ANIM_STATE{
	N, NE, E, SE, S, SW, W, NW, IDLE
	}
#onready var combat = get_node("CombatCore")
func set_kinematic_body(body):
	kinematic_body = body

func set_sprite(new_sprite):
	sprite = new_sprite

func process_input(delta):
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
	process_movement(input)

func process_movement(input):
	velocity = input.normalized() * moveSpeed
	#animate

	if velocity.x != 0:
		if velocity.x > 0:
			anim = E
		else:
			anim = W
	if  velocity.y != 0:
		if velocity.y > 0:
			anim = S
			if velocity.x > 0:
				#anim = SE
				pass
			else:
				#anim = SW
				pass
		else:
			anim = N
			if velocity.x > 0:
				#anim = NE
				pass
			else:
				#anim = NW
				pass
		
	elif anim != IDLE:
		if  velocity.y == 0  && velocity.x == 0:
			anim = IDLE
	#Movement
	kinematic_body.move_and_slide(velocity)
	draw_animation()
	emit_signal("move")

func draw_animation():
	if(anim == ANIM_STATE.N):
		sprite.play("North")
	elif(anim == ANIM_STATE.NE):
		sprite.play("NEast")
	elif(anim == ANIM_STATE.E):
		sprite.play("East")
	elif(anim == ANIM_STATE.S):
		sprite.play("South")
	elif(anim == ANIM_STATE.SE):
		sprite.play("SEast")
	elif(anim == ANIM_STATE.SW):
		sprite.play("SWest")
	elif(anim == ANIM_STATE.W):
		sprite.play("West")
	elif(anim == ANIM_STATE.NW):
		sprite.play("West")
	
	

	