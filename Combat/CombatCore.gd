extends Node

enum ChargeType {FIRE, WATER, AIR, EARTH }

var charges = 5
const max_charges = 5
const charges_regeneration_threeshold = 2.0
var charges_regeneration_time = 0.0
const charge_threshold_attack = 0.2
const charge_threshold_block = 0.2
var charge_time_attack = 0.0
var charge_time_block = 0.0
var current_action = ""
var next_action = null
var character_sprite = null

var combat_ui

func setSprite(sprite):
	character_sprite = sprite
	character_sprite.connect("animation_finished", self, "action_finished")
	
func action_finished():
	if current_action:
		current_action = ""

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
	if current_action || next_action:
		if !current_action:
			current_action = next_action
			next_action = null
		if current_action == "light attack":
			light_attack()
		elif current_action == "heavy attack":
			heavy_attack()
		elif current_action == "ranged attack":
			ranged_attack()
		elif current_action == "block":
			block()
		elif current_action == "parry":
			parry()
		else:
			current_action = null

func hold_attack(delta):
	charge_time_attack += delta

func release_attack():
	if !next_action:
		if Input.is_action_pressed("block") && charges > 0:
			next_action = "ranged attack"
			if current_action == "block":
				current_action = null
		elif charge_time_attack > charge_threshold_attack && charges > 0:
			next_action = "heavy attack"
		else:
			next_action = "light attack"
	charge_time_attack = 0.0

func hold_block(delta):
	if current_action == "block" || next_action == "block" || !next_action:
		charge_time_block += delta
		if current_action != "block":
			next_action = "block"

func release_block():
	if current_action == "block":
		current_action = null
	if !next_action || next_action == "block":
		if charge_time_block < charge_threshold_block:
			next_action = "parry"
		else:
			print("blocked for " + str(charge_time_block) + " seconds")
	charge_time_block = 0.0

func light_attack():
	if character_sprite.animation != "LightAttack":
		character_sprite.play("LightAttack")
		print("light attack")

func heavy_attack():
	if character_sprite.animation != "HeavyAttack":
		if charges > 0:
			charges -= 1
			combat_ui.set_charges(charges)
			character_sprite.play("HeavyAttack")
			print("heavy attack")
		else:
			print("not enough charges for heavy attack")

func ranged_attack():
	if character_sprite.animation != "RangedAttack":
		if charges > 0:
			charges -= 1
			combat_ui.set_charges(charges)
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
