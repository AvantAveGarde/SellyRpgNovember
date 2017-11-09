extends KinematicBody2D

var screensize

onready var movement_system= get_node("MovementInput")
onready var combat_system = get_node("CombatInput")
onready var sprite = get_node("PlayerSprite")

#Initialization
func _ready():
	set_process(true)
	screensize = get_viewport_rect().size
	movement_system.set_kinematic_body(self)
	movement_system.set_sprite(sprite)
	combat_system.set_sprite(sprite)

#update
func _process(delta):
	movement_system.process_input(delta)
	combat_system.process_input(delta)