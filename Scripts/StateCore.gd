extends Node

var actor
export(String) var animation_name = "Idle"
export(String) var default_animation_name = "Idle"

func _ready():
	actor = get_node("../..")
	set_process(false)
	set_physics_process(false)
	set_process_input(false)

func update_animation():
	if actor.sprite.animation != animation_name + actor.facing_direction:
		actor.sprite.play(animation_name + actor.facing_direction)

func on_enter():
	update_animation()
	
func on_exit():
	pass
	
func process(delta):
	pass

func on_animation_finished():
	pass

func on_frame_changed():
	pass

func on_damage(attack):
	var damage = attack.get_total_damage()
	var reduction = actor.get_armor() - attack.damage_penetration
	if reduction < 0:
		reduction = 0
	actor.health -= damage - reduction
	attack.on_actor_damaged(actor)
	if (actor.health <= 0):
		actor.on_kill()

func on_collide(object):
	pass