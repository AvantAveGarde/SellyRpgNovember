extends Node

enum Direction {N, NE, E, SE, S, SW, W, NW}

var dir = Direction.N

export var max_health = 10
export var max_charges = 5
export var block_angle = 45

onready var health = get_max_health()
onready var charges = get_max_charges()
var fireball = preload("res://Combat/Attacks/Fireball.tscn")



func _ready():
	set_process(false)
	set_physics_process(false)
	set_process_input(false)

# Returns the number of slots you can absorb elements into
func get_max_charges():
	return max_charges

# Returns the maximum health points
func get_max_health():
	return max_health

# Returns the angle in which attacks are being blocked or parried
func get_block_angle():
	return block_angle

# Check if we can execute that charged attack
func can_use_charge_attack(charges_required):
	return charges >= charges_required

# Used to actually use up the charges
func consume_charges(charges_count):
	charges -= charges_count
	if charges < 0:
		charges = 0

# Calculates damage on this character
func damage(source, attack):
	health -= attack.get_total_damage()
	if (health <= 0):
		print(str(self) + " died!")
		health = max_health
		pass
		#emit_signal("die")

# Used to check wether or not an attack had been blocked, parried or tanked face on
# Not only does it check the state of this character, but also if the angle is okay
# TODO fix bad function
func get_block_state(attack):
	if is_blocking():
		#if is_facing_attack(attack.position):
			return 1
		#else:
			#return 0
	#elif is_parrying():
		#if is_facing_attack(attack.position):
			#return 2
		#else:
			#return 0
	else:
		return 0

# check if the character is blocking
func is_blocking():
	return false #get_parent().current_state == get_parent().StateID.BLOCK

# check if the character is parrying

# A quick check if the attack is within the block_angle limits
# TODO everything
func is_facing_attack(point):
	var test = get_parent().position.angle_to(point)
	if true:
		return true
	else:
		return false

# ##################################################
# Perform Actions
# ##################################################

# perform a generic light attack
func do_light_attack():
	print("light attack")

# perform a charged melee attack
func do_heavy_attack():
	if can_use_charge_attack(1):
		consume_charges(1)
		
		print("heavy attack")

# perform a charged range attack
func do_ranged_attack():
	if can_use_charge_attack(1):
		consume_charges(1)
		
		print("heavy attack")

# perform a block
# usually it's not needed to overwrite it, unless you want the character to do some special stuff
func do_block():
	print("blocking")

# perform a parry
func do_parry():
	print("parry")

# absorb an attack
func do_absorb():
	print("absorb")