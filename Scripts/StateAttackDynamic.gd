extends "res://Scripts/StateCore.gd"

export(PackedScene) var attack_scene
export var attack_begin_at_frame = 0
var attack_instance

func on_enter():
	.on_enter()
	if attack_begin_at_frame == 0:
		spawn_attack()

func on_animation_finished():
	actor.change_state(default_animation_name)

func on_frame_changed():
	if actor.sprite.frame == attack_begin_at_frame:
		spawn_attack()

# TODO: Fix the direction
# For some reason its off by 90°, but I dunno why.
func spawn_attack():
	if attack_scene:
		attack_instance = attack_scene.instance()
		attack_instance.set_source(actor)
		attack_instance.position = actor.position
		attack_instance.rotate(get_attack_rotation())
		get_parent().add_child(attack_instance)

# TODO proper rotation calculation
func get_attack_rotation():
	return actor.rotation