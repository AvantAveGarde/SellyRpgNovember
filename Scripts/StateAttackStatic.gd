extends "res://Scripts/StateCore.gd"

export(PackedScene) var attack_scene
export var attack_begin_at_frame = 0
export var attack_end_at_frame = 0

var attack_instance

func on_enter():
	.on_enter()
	if attack_begin_at_frame == 0:
		spawn_attack()

# kill the attack if it still exist.
# This might be the case if either the variable hasnt been properly set,
# or if the animation had been interrupted by a state change (e.g. stun)
func on_exit():
	kill_attack()

func on_animation_finished():
	actor.change_state(default_animation_name)

func on_frame_changed():
	if actor.sprite.frame == attack_begin_at_frame:
		spawn_attack()
	elif actor.sprite.frame == attack_end_at_frame:
		kill_attack()

func spawn_attack():
	if attack_scene:
		attack_instance = attack_scene.instance()
		attack_instance.set_source(actor)
		attack_instance.position = actor.position
		attack_instance.rotation = actor.rotation
		get_parent().add_child(attack_instance)

func kill_attack():
	if attack_instance:
		attack_instance.queue_free()