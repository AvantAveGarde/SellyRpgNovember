extends "res://Scripts/ActorCore.gd"

enum InputFlags {
	F_NORTH = 1 << 1,
	F_SOUTH = 1 << 2,
	F_EAST = 1 << 3,
	F_WEST = 1 << 4,
	F_ATTACK_HELD = 1 << 5,
	F_ATTACK_RELEASED = 1 << 6,
	F_BLOCK_HELD = 1 << 7,
	F_BLOCK_RELEASED = 1 << 8
}

signal move

const light_attack_anim = "LightAttack"
const heavy_attack_anim = "HeavyAttack"
const ranged_attack_anim = "RangedAttack"
const block_anim = "Block"

var charge_time_attack = 0.0
var charge_threshold_attack = 1.0

func _process(delta):
	current_state.process(delta)

func get_input():
	var flags = 0x0
	#movement
	if Input.is_action_pressed("ui_right"):
		flags |= F_EAST
	elif Input.is_action_pressed("ui_left"):
		flags |= F_WEST
	if Input.is_action_pressed("ui_up"):
		flags |= F_NORTH
	elif Input.is_action_pressed("ui_down"):
		flags |= F_SOUTH
	#attacks
	if Input.is_action_pressed("attack"):
		flags |= F_ATTACK_HELD
	elif Input.is_action_just_released("attack"):
		flags |= F_ATTACK_RELEASED
	#if Input.is_action_just_pressed("block"):
	#	flags |= F_BLOCK
	if Input.is_action_pressed("block"):
		flags |= F_BLOCK_HELD
	if Input.is_action_just_released("block"):
		flags |= F_BLOCK_RELEASED
	return flags

func on_kill():
	health = get_max_health()
	print("You diededed!")