extends "res://Combat/CombatCore.gd"

var next_action = Action.NONE
onready var combat_ui = get_node("CombatUI")

#TODO:  Remove regen later
const charges_regeneration_threeshold = 2.0
var charges_regeneration_time = 0.0

func _ready():
	combat_ui = get_node("CombatUI")
	combat_ui.set_charges(charges)

func _process(delta):
	regen_charges(delta)
	if current_action != Action.NONE || next_action != Action.NONE:
		if current_action == Action.NONE:
			current_action = next_action
			next_action = Action.NONE
		._process(delta)

func regen_charges(delta):
	if charges < charges_max:
		charges_regeneration_time += delta
		if charges_regeneration_time >= charges_regeneration_threeshold:
			charges += 1
			combat_ui.set_charges(charges)
			if charges >= charges_max:
				charges_regeneration_time = 0.0
			else:
				charges_regeneration_time -= charges_regeneration_threeshold
			print("Charge Regenerated")

func process_input(delta):
	if Input.is_action_pressed("attack"):
		hold_attack(delta)
		
	if Input.is_action_just_released("attack"):
		release_attack()
		
	if Input.is_action_pressed("block"):
		hold_block(delta)
		
	if Input.is_action_just_released("block"):
		release_block()

func hold_attack(delta):
	charge_time_attack += delta

func release_attack():
	if next_action == Action.NONE:
		if current_action == Action.BLOCK:
			charge_time_block = 0.0
			character_sprite.play("Idle");
			if can_use_charge_attack(1):
				next_action = Action.RANGED_ATTACK
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
	if next_action == Action.BLOCK:
		next_action = Action.NONE
	if current_action == Action.BLOCK:
		character_sprite.play("Idle")
		if charge_time_block < charge_threshold_block:
			next_action = Action.PARRY
		current_action = Action.NONE
		print("blocked for " + str(charge_time_block) + " seconds")
	charge_time_block = 0.0

func consume_charges(charges_count):
	.consume_charges(charges_count)
	combat_ui.set_charges(charges)