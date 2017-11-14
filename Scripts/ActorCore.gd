extends PhysicsBody2D

const state_object = preload("res://Scripts/StateCore.gd")

export(NodePath) var sprite = NodePath("Sprite")
export(NodePath) var states_node = NodePath("States")
export(String) var default_state = "Idle"

var states = { }

var current_state
export(int, 100) var max_health = 10
onready var health = get_max_health()
export(int, 10) var max_charges = 5
onready var charges = 0 #max_charges

export(int, "Player", "Ally", "Enemy") var faction = 2

export(int, 1000) var move_speed = 0
var previous_direction = Vector2(0, 0)

export(int, 10) var armor = 0
export(int, 10) var block = 3
export(int, 180) var block_angle = 45

const DIRECTIONS = {
	N = "N",
	NE = "NE",
	E = "E",
	SE = "SE",
	S = "S",
	SW = "SW",
	W = "W",
	NW = "NW"
}

#animation constants
var facing_direction = DIRECTIONS.S

func _ready():
	if sprite:
		sprite = get_node(sprite)
		if sprite:
			sprite.connect("animation_finished", self, "on_animation_finished")
			sprite.connect("frame_changed", self, "on_frame_changed")
	if states_node:
		states_node = get_node(states_node)
		if states_node:
			var children = states_node.get_children()
			for child in children:
				if child is state_object:
					states[child.get_name()] = child
			current_state = states[default_state]

func _process(delta):
	if current_state:
		current_state.process(delta)

func get_max_health():
	return max_health

func get_move_speed():
	return move_speed

func get_armor():
	return armor

func get_block():
	return block

func change_state(state_name):
	if current_state:
		current_state.on_exit()
	current_state = states[state_name]
	if !current_state:
		current_state = states[default_state]
	if current_state:
		current_state.on_enter()

func on_animation_finished():
	if current_state:
		current_state.on_animation_finished()

func on_frame_changed():
	if current_state:
		current_state.on_frame_changed()

func on_damage(attack):
	if current_state:
		current_state.on_damage(attack)

func on_collide(target):
	if current_state:
		current_state.on_collide(target)

func on_kill():
	#emit_signal("die")
	self.queue_free()

func on_absorb(attack):
	if charges < max_charges:
		charges = charges + 1

# Check if we can execute that charged attack
func can_use_charge_attack(charges_required):
	return charges >= charges_required

# Used to actually use up the charges
func consume_charges(charges_count):
	charges -= charges_count
	if charges < 0:
		charges = 0