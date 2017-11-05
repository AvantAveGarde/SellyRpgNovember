extends Node

enum ChargeType {FIRE, WATER, AIR, EARTH }

var charges = 5
const max_charges = 5
const charge_threshold = 0.2
var charge_time = 0.0

var combat_ui

func _ready():
	combat_ui = get_node("CombatUI")
	combat_ui.set_charges(charges)
	
func release_attack():
	if charge_time > charge_threshold:
		if charges > 0:
			heavy_attack()
		else:
			attack()
	else:
		attack()
	
func hold(delta):
	charge_time += delta

func attack():
	charge_time = 0.0
	print("attack")
	
func heavy_attack():
	charge_time = 0.0
	charges -= 1
	combat_ui.set_charges(charges)
	print("heavy attack")
	
func parry():
	print("parry")
	
func absorb():
	print("absorb")
	
func ranged_attack():
	print("ranged attack")
	
