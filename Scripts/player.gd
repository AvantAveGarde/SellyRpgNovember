extends KinematicBody2D

export var moveSpeed = 200
var velocity = Vector2()
var screensize

onready var combat = get_node("CombatInput/CombatCore")
onready var sprite = get_node("PlayerSprite")

var anim = "Idle"


#Initialization
func _ready():
	set_process(true)
	screensize = get_viewport_rect().size
	combat.setSprite(sprite)

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

	#animate
	if !sprite.is_playing():
		if  velocity.y != 0:
			anim = "Walk"
		else:
			anim = "Idle"
	
	sprite.play(anim);

	
	#Movement
	move_and_slide(velocity)
