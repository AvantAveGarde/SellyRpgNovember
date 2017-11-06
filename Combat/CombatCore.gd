extends Node

enum ChargeType {FIRE, WATER, AIR, EARTH }
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

func set_sprite(sprite):
	character_sprite = sprite
	character_sprite.connect("animation_finished", self, "action_finished")

func action_finished():
	print("animation finished")
	character_sprite.play("Idle")
	current_action = Action.NONE

func _process(delta):
	if current_action != Action.NONE:
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

func light_attack():
	print(character_sprite.animation)
	if character_sprite.animation != "LightAttack":
		character_sprite.play("LightAttack")
		#print("light attack")

func heavy_attack():
	if character_sprite.animation != "HeavyAttack":
		if can_use_charge_attack(1):
			consume_charges(1)
			character_sprite.play("HeavyAttack")
			print("heavy attack")
		else:
			print("not enough charges for heavy attack")
			
func can_use_charge_attack(charges_required):
	return charges > charges_required

func consume_charges(charges_count):
	charges -= charges_count
	if charges < 0:
		charges = 0

func ranged_attack():
	if character_sprite.animation != "RangedAttack":
		if can_use_charge_attack(1):
			consume_charges(1)
			character_sprite.play("RangedAttack")
			print("ranged attack")
		else:
			print("not enough charges for ranged attack")

func block():
	if character_sprite.animation != "Block":
		character_sprite.play("Block")

func parry():
	if character_sprite.animation != "Block":
		character_sprite.play("Parry")
		print("parry")

func on_Damage(source, attack):
	pass

func absorb():
	print("absorb")
