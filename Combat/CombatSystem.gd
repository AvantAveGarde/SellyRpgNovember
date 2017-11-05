extends Node

#enum State {STATE_NORMAL, STATE_HOLDING}

var charges = 1
const heavy_attack_threshold = 0.2
var charge_time = 0.0
var max_charge = 1.0

var combat_ui

func _ready():
	combat_ui = get_node("CombatUI")
	combat_ui.set_energy(0.0)
	combat_ui.set_max_energy(max_charge - heavy_attack_threshold)
	
func release_attack():
	if charge_time > heavy_attack_threshold:
		heavy_attack()
	else:
		attack()
	
func hold(delta):
	if charge_time < max_charge:
		charge_time += delta
		#TODO:  Make a better fix for this
		if charge_time > heavy_attack_threshold:
			combat_ui.set_energy(charge_time - heavy_attack_threshold)
	if charge_time > max_charge:
		charge_time = max_charge
		combat_ui.set_energy(charge_time - heavy_attack_threshold)

func attack():
	charge_time = 0.0
	combat_ui.set_energy(charge_time)
	print("attack")
	
func heavy_attack():
	print("heavy attack at " + str((charge_time/max_charge) * 100.0) + "%")
	charge_time = 0.0
	combat_ui.set_energy(charge_time)
	
func parry():
	charge_time = 0.0
	print("parry")
	
func absorb():
	charge_time = 0.0
	print("absorb")
	
func ranged_attack():
	charge_time = 0.0
	print("ranged attack")
	
