extends KinematicBody2D

# The main element of the attack should only be one.
# Need to find a better way to select only a single element.
export(int, FLAGS, "Fire", "Water", "Earth", "Wind") var element_main

export var is_ranged = false
export var is_magic = false
export var is_charged_atack = false
export var parryable = false

onready var sprite = get_node("Sprite")
onready var hitbox = get_node("Hitbox")
var damage_zone
var character
var element_sub = []

func _ready():
	#add_collision_exception_with(KinematicBody2d)
	damage_zone = get_node("DamageZone")
	damage_zone.connect("body_entered", self, "on_collide_with_body")
	character = get_node("Character")
	#character.connect("kill", self, "on_kill")
	pass
	
func _process(delta):
	update_movement(delta)

func update_movement(delta):
	var velocity = Vector2(0, -1)
	velocity = velocity.rotated(global_rotation)
	velocity = velocity.normalized() * character.move_speed
	
	move_and_slide(velocity)
	#var collider = move_and_collide(velocity)
	#if collider:

func on_collide_with_body(body):
	if body: #TODO: check what body it is, and if its enemy
		var response = body.damage(self)
		if response == 0: # actor damaged
			on_actor_damaged(body)
		elif response == 1: # actor blocked
			on_actor_blocked(body)
		elif response == 2: # actor parried
			on_actor_parried(body)

func on_actor_damaged(body):
	on_kill()

func on_actor_blocked(body):
	on_kill()

func on_actor_parried(body):
	on_kill()

func on_damage(source, damage):
	#character.damage(damage)
	pass
	
func on_kill():
	self.free()