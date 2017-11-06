extends Node

enum ChargeType {FIRE, WATER, AIR, EARTH }
enum Action {NONE, LIGHT_ATTACK, HEAVY_ATTACK, RANGED_ATTACK, BLOCK, PARRY}

var charges = 5
const max_charges = 5

const charges_regeneration_threeshold = 2.0
var charges_regeneration_time = 0.0

const charge_threshold_attack = 0.2
const charge_threshold_block = 0.2
var charge_time_attack = 0.0
var charge_time_block = 0.0
var current_action = Action.NONE
var next_action = Action.NONE

var combat_ui

func _ready():
	combat_ui = get_node("CombatUI")
	combat_ui.set_charges(charges)
	
func _process(delta):
	if charges < max_charges:
		charges_regeneration_time += delta
		if charges_regeneration_time >= charges_regeneration_threeshold:
			charges += 1
			combat_ui.set_charges(charges)
			if charges >= max_charges:
				charges_regeneration_time = 0.0
			else:
				charges_regeneration_time -= charges_regeneration_threeshold
			print("Charge Regenerated")
	if current_action != Action.NONE || next_action != Action.NONE:
		if current_action == Action.NONE:
			current_action = next_action
			next_action = Action.NONE
		if current_action == Action.LIGHT_ATTACK:
			light_attack()
		elif current_action == Action.HEAVY_ATTACK:
			heavy_attack()
		elif current_action == Action.RANGED_ATTACK:
			ranged_attack()
		elif current_action == Action.BLOCK:
			block()
		elif current_action == Action.PARRY:
			parry()
		else:
			current_action = Action.NONE

func hold_attack(delta):
	charge_time_attack += delta

func release_attack():
	if next_action == Action.NONE:
		if Input.is_action_pressed("block") && charges > 0:
			next_action = Action.RANGED_ATTACK
			if current_action == Action.BLOCK:
				current_action = Action.NONE
		elif charge_time_attack > charge_threshold_attack && charges > 0:
			next_action = Action.HEAVY_ATTACK
		else:
			next_action = Action.LIGHT_ATTACK
	charge_time_attack = 0.0

func hold_block(delta):
	if current_action == Action.BLOCK || next_action == Action.BLOCK || next_action == Action.NONE:
		charge_time_block += delta
		if current_action != Action.BLOCK:
			next_action = Action.BLOCK

func release_block():
	if current_action == Action.BLOCK:
		current_action = Action.NONE
		
	if next_action == Action.NONE || next_action == Action.BLOCK:
		if charge_time_block < charge_threshold_block:
			next_action = Action.PARRY
		else:
			print("blocked for " + str(charge_time_block) + " seconds")
	charge_time_block = 0.0

func light_attack():
	current_action = Action.NONE
	print("light attack")

func heavy_attack():
	current_action = Action.NONE
	if charges > 0:
		charges -= 1
		combat_ui.set_charges(charges)
		print("heavy attack")
	else:
		print("not enough charges for heavy attack")

func ranged_attack():
	current_action = Action.NONE
	if charges > 0:
		charges -= 1
		combat_ui.set_charges(charges)
		print("ranged attack")
	else:
		print("not enough charges for ranged attack")

func block():
	pass

func parry():
	current_action = Action.NONE
	print("parry")

func absorb():
	current_action = Action.NONE
	print("absorb")
