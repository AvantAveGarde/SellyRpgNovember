extends CollisionObject2D

export(int, "None", "Fire", "Water", "Earth", "Wind") var element_main
export var is_ranged_attack = false
export var is_magic_attack = false
export var is_charged_atack = false
export var is_parryable = false

export(NodePath) var sprite
export(NodePath) var collision_shape
export(NodePath) var damage_shape

var element_sub = []
var source

export var move_speed = 200
export var life_duration = 5.0
export var base_damage = 1
export var elemental_damage = 1
export var penetration = 1

func _ready():
	sprite = get_node(sprite)
	collision_shape = get_node(collision_shape)
	damage_shape = get_node(damage_shape)
	
	#add_collision_exception_with(KinematicBody2d)
	damage_shape.connect("body_entered", self, "on_collide_with_body")
	pass
	
func _process(delta):
	check_lifetime(delta)
	update_movement(delta)

func check_lifetime(delta):
	life_duration -= delta
	if life_duration <= 0:
		kill()

func update_movement(delta):
	var velocity = Vector2(0, -1)
	velocity = velocity.rotated(global_rotation)
	velocity = velocity.normalized() * move_speed
	
	move_and_slide(velocity)
	#var collider = move_and_collide(velocity)
	#if collider:

func on_collide_with_body(body):
	if body: #TODO: check what body it is, and if its enemy
		var response = body.combat_system.get_block_state(self)
		if response == 0: # actor damaged
			on_actor_damaged(body)
		elif response == 1: # actor blocked
			on_actor_blocked(body)
		elif response == 2: # actor parried
			on_actor_parried(body)
		else: # e.g. going trough the body.
			on_actor_special(body, response)

func on_actor_damaged(body):
	body.combat_system.damage(source, self)
	kill()

func on_actor_blocked(body):
	kill()

func on_actor_parried(body):
	kill()
	
func on_actor_special(body, response):
	pass

func on_damage(source, damage):
	#character.damage(damage)
	pass
	
func kill():
	self.queue_free()

func get_total_damage():
	var damage = 0
	if !is_magic_attack:
		damage += base_damage
	if element_main:
		damage += elemental_damage
	damage += elemental_damage * element_sub.size()
	return damage