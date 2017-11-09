extends Node

enum Action {NONE, LIGHT_ATTACK, HEAVY_ATTACK, RANGED_ATTACK, BLOCK, PARRY}
enum Direction {N, NE, E, SE, S, SW, W, NW}

const idle_anim = "Idle"
const light_attack_anim = "LightAttack"
const heavy_attack_anim = "HeavyAttack"
const ranged_attack_anim = "RangedAttack"
const block_anim = "Block"
const parry_anim = "Parry"

var current_action = Action.NONE
var character_sprite
var dir = Direction.N

#export(NodePath) var character
onready var character = get_node("Character")
onready var charges = get_max_charges()

#enum Anims {IDLE = "Idle", LIGHTATTACK = "LightAttack", HEAVYATTACK = "HeavyAttack", RANGEDATTACK = "RangedAttack", BLOCK = "Block", PARRY = "Parry"}

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

func do_block():
	if character_sprite.animation != block_anim:
		character_sprite.play(block_anim)

func do_parry():
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
		if is_facing_position(attack.position):
			return 1
		else:
			return 0
	elif is_parrying():
		if is_facing_position(attack.position):
			return 2
		else:
			return 0
	else:
		return 0

func is_facing_position(point):
	var test = get_parent().position.angle_to(point)
	if true:
		return true
	else:
		return false

func get_max_charges():
	return 0