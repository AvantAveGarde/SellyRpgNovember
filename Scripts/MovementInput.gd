extends Node

export var moveSpeed = 200
var velocity = Vector2()

var anim = "Idle"
var sprite
var kinematic_body

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
	if sprite.animation == "Idle":
		if  velocity.y != 0 || velocity.x != 0:
			anim = "Walk"
			sprite.play(anim)
	elif sprite.animation == "Walk":
		if  velocity.y == 0  && velocity.x == 0:
			anim = "Idle"
			sprite.play(anim)
	#Movement
	kinematic_body.move_and_slide(velocity)