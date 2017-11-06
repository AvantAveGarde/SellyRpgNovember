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

const idle_anim = "Idle"
const light_attack_anim = "LightAttack"
const heavy_attack_anim = "HeavyAttack"
const ranged_attack_anim = "RangedAttack"
const block_anim = "Block"
const parry_anim = "Parry"

func set_sprite(sprite):
	character_sprite = sprite
	character_sprite.connect("animation_finished", self, "action_finished")

func action_finished():
	print("animation finished")
	character_sprite.play(idle_anim)
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
	if character_sprite.animation != light_attack_anim:
		character_sprite.play(light_attack_anim)
		#print("light attack")

func heavy_attack():
	if character_sprite.animation != heavy_attack_anim:
		if can_use_charge_attack(1):
			consume_charges(1)
			character_sprite.play(heavy_attack_anim)
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
	if character_sprite.animation != ranged_attack_anim:
		if can_use_charge_attack(1):
			consume_charges(1)
			character_sprite.play(ranged_attack_anim)
			print("ranged attack")
		else:
			print("not enough charges for ranged attack")

func block():
	if character_sprite.animation != block_anim:
		character_sprite.play(block_anim)

func parry():
	if character_sprite.animation != parry_anim:
		character_sprite.play(parry_anim)
		print("parry")

func on_Damage(source, attack):
	pass

func absorb():
	print("absorb")
