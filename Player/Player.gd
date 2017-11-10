extends KinematicBody2D

#player components
onready var character = get_node("Character")
onready var combat_system = get_node("CombatCore")
onready var sprite = get_node("PlayerSprite")

#player states
enum StateID {IDLE, MOVING, LIGHT_ATTACK, HEAVY_ATTACK, BLOCK, PARRY}
onready var States = {
	IDLE : get_node("States/Idle"),
	MOVING: get_node("States/Moving"),
	LIGHT_ATTACK: get_node("States/LightAttack"),
	HEAVY_ATTACK: get_node("States/HeavyAttack"),
	BLOCK: get_node("States/Block")
}

enum InputFlags {
	F_LIGHT_ATTACK = 1 << 0,
	F_HEAVY_ATTACK = 1 << 1,
	F_BLOCK = 1 << 2,
	F_PARRY = 1 << 3,
	F_RANGED_ATTACK = 1 << 4,
	F_ABSORB = 1 << 5,
	F_NORTH = 1 << 6,
	F_SOUTH = 1 << 7,
	F_EAST = 1 << 8,
	F_WEST = 1 << 9,
	F_NORTH_EAST = 1 << 10,
	F_NORTH_WEST = 1 << 11,
	F_SOUTH_EAST = 1 << 12,
	F_SOUTH_WEST = 1 << 13,
	F_ATTACK_HELD = 1 << 14
	F_ATTACK_RELEASED = 1 << 15,
	F_BLOCK_HELD = 1 << 16,
	F_BLOCK_RELEASED = 1 << 17
}

var current_state
#var next_action = null

#movement variables
#TODO:  consider making movement variables part of the movement state
export var move_speed = 200
var velocity = Vector2()

#attack variables
#TODO:  Possibly collapse thresholds into a single variable
const charge_threshold_attack = 0.2
const charge_threshold_block = 0.2
var charge_time_attack = 0.0
var charge_time_block = 0.0

#animation constants
#TODO:  Consider moving anim consts into state where they are needed
const north = "North"
const n_east = "NEast"
const east = "East"
const south = "South"
const s_east = "SEast"
const s_west = "SWest"
const west = "West"
const n_west = "NWest"

const idle_anim = "Idle"
const light_attack_anim = "LightAttack"
const heavy_attack_anim = "HeavyAttack"
const ranged_attack_anim = "RangedAttack"
const block_anim = "Block"
const parry_anim = "Parry"


func _ready():
	sprite.connect("animation_finished", self, "on_animation_finished")
	current_state = States[IDLE]

func _process(delta):

	var flags = 0x0

	if Input.is_action_pressed("ui_right"):
		flags |= F_EAST
	elif Input.is_action_pressed("ui_left"):
		flags |= F_WEST

	if Input.is_action_pressed("ui_up"):
		flags |= F_NORTH
	elif Input.is_action_pressed("ui_down"):
		flags |= F_SOUTH

	if Input.is_action_pressed("attack"):
		flags |= F_ATTACK_HELD

	if Input.is_action_just_released("attack"):
		flags |= F_ATTACK_RELEASED

	if Input.is_action_just_pressed("block"):
		flags |= F_BLOCK

	if Input.is_action_pressed("block"):
		flags |= F_BLOCK_HELD

	if Input.is_action_just_released("block"):
		flags |= F_BLOCK_RELEASED

	current_state.process(flags, delta)

func change_state(state_id):

	current_state.on_exit()

	current_state = States[state_id]

	current_state.on_enter()

func on_animation_finished():
	if not current_state.has_method('on_animation_finished'):
		return
	current_state.on_animation_finished()

#func button_hold_attack(delta):
#	charge_time_attack += delta

#func button_release_attack():
	#if next_action == null:
		#if current_action == Action.BLOCK:
		#	charge_time_block = 0.0
		#	character_sprite.play("Idle");
			#if combat_system.can_use_charge_attack(1):
				#next_action = Action.RANGED_ATTACK
			#current_action = Action.NONE
	#if charge_time_attack > charge_threshold_attack && charges > 0:
		#next_action = Action.HEAVY_ATTACK
		#pass
	#else:
		#next_action = Action.LIGHT_ATTACK
		#pass
	#charge_time_attack = 0.0