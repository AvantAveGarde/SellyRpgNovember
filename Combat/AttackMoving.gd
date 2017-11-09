extends KinematicBody2D

export(int, "None", "Fire", "Water", "Earth", "Wind") var element_main
export var is_ranged_attack = false
export var is_magic_attack = false
export var is_charged_atack = false
export var is_parryable = false

onready var sprite = get_node("Sprite")
onready var hitbox = get_node("Hitbox")
var damage_zone
var element_sub = []

export var move_speed = 200

func _ready():
	#add_collision_exception_with(KinematicBody2d)
	damage_zone = get_node("DamageZone")
	damage_zone.connect("body_entered", self, "on_collide_with_body")
	pass
	
func _process(delta):
	update_movement(delta)

func update_movement(delta):
	var velocity = Vector2(0, -1)
	velocity = velocity.rotated(global_rotation)
	velocity = velocity.normalized() * move_speed
	
	move_and_slide(velocity)
	#var collider = move_and_collide(velocity)
	#if collider:

func on_collide_with_body(body):
	if body: #TODO: check what body it is, and if its enemy
		var response = body.get_block_state(self)
		if response == 0: # actor damaged
			on_actor_damaged(body)
		elif response == 1: # actor blocked
			on_actor_blocked(body)
		elif response == 2: # actor parried
			on_actor_parried(body)
		else: # e.g. going trough the body.
			on_actor_special(body, response)

func on_actor_damaged(body):
	body.damage(self)
	on_kill()

func on_actor_blocked(body):
	on_kill()

func on_actor_parried(body):
	on_kill()
	
func on_actor_special(body, response):
	pass

func on_damage(source, damage):
	#character.damage(damage)
	pass
	
func on_kill():
	self.free()