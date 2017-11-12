extends KinematicBody2D

export(NodePath) var sprite
export(NodePath) var animation_states_node
export(String) var default_state

var AnimationStates = { }

var current_state
export var move_speed = 200
export var health = 10
export var armor = 0

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

func _ready():
	sprite = get_node(sprite)
	sprite.connect("animation_finished", self, "on_animation_finished")
	sprite.connect("frame_changed", self, "on_frame_changed")
	animation_states_node = get_node(animation_states_node)
	var children = animation_states_node.get_children()
	for child in children:
		AnimationStates[child.get_name()] = child
	current_state = AnimationStates[default_state]

func _process(delta):
	current_state.process(delta)

func change_state(state_name):
	current_state.on_exit()
	current_state = AnimationStates[state_name]
	current_state.on_enter()

func on_animation_finished():
	current_state.on_animation_finished()

func on_frame_changed():
	current_state.on_frame_changed()