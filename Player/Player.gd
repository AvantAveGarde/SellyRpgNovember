extends KinematicBody2D

#player components
onready var combat_system = get_node("CombatCore")
onready var sprite = get_node("PlayerSprite")

#player states
enum StateID {IDLE, MOVING, LIGHT_ATTACK, HEAVY_ATTACK, BLOCK}
onready var States = {
	IDLE : get_node("States/Idle"),
	MOVING: get_node("States/Moving"),
	LIGHT_ATTACK: get_node("States/LightAttack"),
	HEAVY_ATTACK: get_node("States/HeavyAttack"),
	BLOCK: get_node("States/Block")
}

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

var current_state
#var next_action = null

#movement variables
#TODO:  consider making movement variables part of the movement state
export var move_speed = 200
var velocity = Vector2()
signal move

#attack variables
#TODO:  Possibly collapse thresholds into a single variable
const charge_threshold_attack = 0.2
const charge_threshold_block = 0.2
var charge_time_attack = 0.0
var charge_time_block = 0.0

#animation constants
var facing_direction

const n_west = "NorthWest"
const north = "North"
const n_east = "NorthEast"
const south = "South"
const s_east = "SouthEast"
const s_west = "SouthWest"
const west = "West"
const east = "East"

const idle_north = "IdleNorth"
const idle_north_east = "IdleNorthEast"
const idle_east = "IdleEast"
const idle_south_east = "IdleSouthEast"
const idle_south = "IdleSouth"
const idle_south_west = "IdleSouthWest"
const idle_west = "IdleWest"
const idle_north_west = "IdleNorthWest"

const light_attack_anim = "LightAttack"
const heavy_attack_anim = "HeavyAttack"
const ranged_attack_anim = "RangedAttack"
const block_anim = "Block"


func _ready():
	sprite.connect("animation_finished", self, "on_animation_finished")
	sprite.connect("frame_changed", self, "on_frame_changed")
	current_state = States[IDLE]

func _process(delta):
	#emit_signal("move")
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
	current_state.process(delta, flags)

func change_state(state_id):
	current_state.on_exit()
	current_state = States[state_id]
	current_state.on_enter()

func on_animation_finished():
	current_state.on_animation_finished()

func on_frame_changed():
	current_state.on_frame_changed()