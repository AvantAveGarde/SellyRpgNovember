extends Node

var combat

func _ready():
	combat = get_node("CombatSystem")

func _process(delta):
	if Input.is_action_pressed("attack"):
		combat.hold_attack(delta)
		
	if Input.is_action_just_released("attack"):
		combat.release_attack()
		
	if Input.is_action_pressed("block"):
		combat.hold_block(delta)
		
	if Input.is_action_just_released("block"):
		combat.release_block()

#func _input(event):
#	if event.is_action_pressed("attack"):
#		combat.attack()