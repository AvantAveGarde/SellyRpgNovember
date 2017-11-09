extends Node

enum Action {NONE, LIGHT_ATTACK, HEAVY_ATTACK, RANGED_ATTACK, BLOCK, PARRY}

var charges = 5
const charges_max = 5

#TODO:  Possibly collapse thresholds into a single variable
const charge_threshold_attack = 0.2
const charge_threshold_block = 0.2
var charge_time_attack = 0.0
var charge_time_block = 0.0

var current_action = Action.NONE

var character_sprite

#export(NodePath) var character
onready var character = get_node("Character")

#enum Anims {IDLE = "Idle", LIGHTATTACK = "LightAttack", HEAVYATTACK = "HeavyAttack", RANGEDATTACK = "RangedAttack", BLOCK = "Block", PARRY = "Parry"}

const idle_anim = "Idle"
const light_attack_anim = "LightAttack"
const heavy_attack_anim = "HeavyAttack"
const ranged_attack_anim = "RangedAttack"
const block_anim = "Block"
const parry_anim = "Parry"

func _ready():
	pass
	#character = get_node(character)

func set_sprite(sprite):
	character_sprite = sprite
	character_sprite.connect("animation_finished", self, "on_action_finished")

func on_action_finished():
	character_sprite.play(idle_anim)
	current_action = Action.NONE

func _process(delta):
	if current_action != Action.NONE:
		if current_action == Action.LIGHT_ATTACK:
			do_light_attack()
		elif current_action == Action.HEAVY_ATTACK:
			do_heavy_attack()
		elif current_action == Action.RANGED_ATTACK:
			do_ranged_attack()
		elif current_action == Action.BLOCK:
			do_block()
		elif current_action == Action.PARRY:
			do_parry()
		else:
			current_action = Action.NONE

func do_light_attack():
	print(character_sprite.animation)
	if character_sprite.animation != light_attack_anim:
		character_sprite.play(light_attack_anim)

func do_heavy_attack():
	if character_sprite.animation != heavy_attack_anim:
		if can_use_charge_attack(1):
			consume_charges(1)
			character_sprite.play(heavy_attack_anim)
		else:
			pass

func do_ranged_attack():
	if character_sprite.animation != ranged_attack_anim:
		if can_use_charge_attack(1):
			consume_charges(1)
			character_sprite.play(ranged_attack_anim)
		else:
			pass

func do_perform_block():
	if character_sprite.animation != block_anim:
		character_sprite.play(block_anim)

func do_perform_parry():
	if character_sprite.animation != parry_anim:
		character_sprite.play(parry_anim)

func do_absorb():
	pass

func can_use_charge_attack(charges_required):
	return charges > charges_required

func consume_charges(charges_count):
	charges -= charges_count
	if charges < 0:
		charges = 0

func on_Damage(source, attack):
	damage(source, attack)

func damage(source, attack):
	character.damage(source, attack)

func is_blocking():
	return current_action == Action.BLOCK

func is_parrying():
	return current_action == Action.PARRY

func get_block_state(attack):
	if is_blocking():
		return 1
	elif is_parrying():
		return 2
	else:
		return 0