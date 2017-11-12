extends CollisionObject2D

export(int, "None", "Fire", "Water", "Earth", "Wind") var element_main
export var is_ranged_attack = false
export var is_magic_attack = false
export var is_charged_atack = false
export var is_parryable = false

export(NodePath) var damage_shape

var element_sub = []
var source

export var duration = 5.0
export var damage_base = 1
export var damage_elemental = 1
export var damage_penetration = 1

func _ready():
	if damage_shape:
		damage_shape = get_node(damage_shape)
		damage_shape.connect("body_entered", self, "on_collide_with_body")
	pass

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

func _process(delta):
	check_duration(delta)

func check_duration(delta):
	duration -= delta
	if duration <= 0:
		kill()

func on_collide_with_body(body):
	if body != source:
		actor_damage(body)

func actor_damage(body):
	body.on_damage(self)
	kill()

func on_actor_blocked(body):
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