extends KinematicBody2D

export(NodePath) var sprite
export(NodePath) var animation_states_node
export(String) var default_state = "Idle"

var AnimationStates = { }

var current_state
export(int, 1000) var move_speed = 200
export(int, 100) var max_health = 10
onready var health = get_max_health()
export(int, 10) var armor = 0
export(int, 10) var max_charges = 5
onready var charges = get_max_charges()
export(int, 180) var block_angle = 45

const n_west = "NorthWest"
const north = "North"
const n_east = "NorthEast"
const south = "South"
const s_east = "SouthEast"
const s_west = "SouthWest"
const west = "West"
const east = "East"

#animation constants
var facing_direction = south
var velocity = Vector2()

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

func on_damage(attack):
	health -= attack.get_total_damage()
	if (health <= 0):
		on_kill()
		#emit_signal("die")

func on_kill():
	self.queue_free()

func on_absorb(attack):
	pass

func get_max_health():
	return max_health

# Returns the number of slots you can absorb elements into
func get_max_charges():
	return max_charges

# Check if we can execute that charged attack
func can_use_charge_attack(charges_required):
	return charges >= charges_required

# Used to actually use up the charges
func consume_charges(charges_count):
	charges -= charges_count
	if charges < 0:
		charges = 0