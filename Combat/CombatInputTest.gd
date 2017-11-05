extends Node

var combat

func _ready():
	combat = get_node("CombatSystem")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	if event.is_action_pressed("attack"):
		combat.attack()
		