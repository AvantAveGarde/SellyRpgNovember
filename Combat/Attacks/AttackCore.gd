extends CollisionObject2D

const actor_class = preload("res://Scripts/ActorCore.gd")

export(int, "None", "Fire", "Water", "Earth", "Wind") var element_main = 0
export var is_magic_attack = false

export(NodePath) var damage_shape

var element_sub = []
var source

export(float, 0.1, 30.0) var duration = 5.0
export(int, 1, 10) var damage_base = 1
export(int, 1, 10) var damage_elemental = 1
export(int, 0, 10) var damage_penetration = 1

func _ready():
	if damage_shape:
		damage_shape = get_node(damage_shape)
		damage_shape.connect("body_entered", self, "on_body_enter")
	pass

func _process(delta):
	check_duration(delta)

func set_source(character):
	source = character

func set_duration(time):
	duration = time

func set_base_damage(damage):
	damage_base = damage

func set_elemental_damage(damage):
	damage_elemental = damage

func set_penetration(penetration):
	damage_penetration = penetration

func set_elements(elements):
	element_sub = elements

func add_element(element):
	element_sub.append(element)

func check_duration(delta):
	duration -= delta
	if duration <= 0:
		kill()

func on_body_enter(target):
	if target is actor_class && source is actor_class:
		if target.faction != source.faction:
			actor_damage(target)

func actor_damage(target):
	target.on_damage(self)

func on_actor_damaged(target):
	kill()

func on_actor_blocked(target):
	kill()

func on_actor_absorbed(target):
	kill()

func on_damage(source, damage):
	kill()

func kill():
	self.queue_free()

# TODO split into melee and ranged atacks
func get_total_damage():
	var damage = 0
	if !is_magic_attack:
		damage += damage_base
	if element_main:
		damage += damage_elemental
		damage += damage_elemental * element_sub.size()
	return damage