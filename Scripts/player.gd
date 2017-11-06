extends KinematicBody2D

export var moveSpeed = 200
var velocity = Vector2()
var screensize

onready var combat = get_node("CombatSystem")
onready var sprite = get_node("PlayerSprite")

var anim = "Idle"


#Initialization
func _ready():
	set_process(true)
	screensize = get_viewport_rect().size
	


#update
func _process(delta):
	PlayerInput(delta)

func  PlayerInput(delta):

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
	
	velocity = input.normalized() * moveSpeed
	
	#attack
	if Input.is_action_pressed("attack"):
		combat.hold_attack(delta)
		velocity.y = 0
		velocity.x = 0
		
	if Input.is_action_just_released("attack"):
		combat.release_attack()

	#animate
	if  velocity.y != 0:
		anim = "Walk"
	else:
		anim = "Idle"
	
	sprite.play(anim);

	
	#Movement
	move_and_slide(velocity)
