extends KinematicBody2D

var screensize

onready var movementInput = get_node("MovementInput")
onready var combatInput = get_node("CombatInput")
onready var sprite = get_node("PlayerSprite")
var test = 10

#Initialization
func _ready():
	set_process(true)
	screensize = get_viewport_rect().size
	movementInput.set_kinematic_body(self)
	movementInput.set_sprite(sprite)
	combatInput.set_sprite(sprite)

#update
func _process(delta):
	movementInput.process_input(delta)
	combatInput.process_input(delta)