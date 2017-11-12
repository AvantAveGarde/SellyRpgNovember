extends "res://Scripts/StateCore.gd"

export(PackedScene) var attack_scene
export var attack_begin_at_frame = 0
export var attack_end_at_frame = 0
export var attack_duration = 0

var attack_instance

func on_enter():
	if attack_begin_at_frame == 0:
		spawn_attack()

func on_animation_finished():
	actor.change_state("Idle")

func on_frame_changed():
	if actor.sprite.frame == attack_begin_at_frame:
		spawn_attack()
	elif attack_end_at_frame > 0 && actor.sprite.frame == attack_end_at_frame:
		kill_attack()

func spawn_attack():
	if attack_scene:
		attack_instance = attack_scene.instance()
		attack_instance.set_source(actor)
		if (attack_duration > 0):
			attack_instance.set_duration(attack_duration)
		attack_instance.rotate(randi())
		attack_instance.position = actor.position
		get_parent().add_child(attack_instance)

func kill_attack():
	if attack_instance:
		attack_instance.queue_free()