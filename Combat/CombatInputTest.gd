extends Node

var combat

func _ready():
	combat = get_node("CombatSystem")

func _process(delta):
	if Input.is_action_pressed("attack"):
		combat.hold(delta)
		
	if Input.is_action_just_released("attack"):
		combat.release_attack()

#func _input(event):
#	if event.is_action_pressed("attack"):
#		combat.attack()