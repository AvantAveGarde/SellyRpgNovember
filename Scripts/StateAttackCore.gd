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

func spawn_attack():
	if attack_scene:
		attack_instance = attack_scene.instance()
		attack_instance.set_source(actor)
		attack_instance.position = actor.position
		attack_instance.rotate(get_attack_rotation())
		get_parent().add_child(attack_instance)

# TODO proper rotation calculation
func get_attack_rotation():
	var degree
	match actor.facing_direction:
		"E": degree = 0
		"SE": degree = 45
		"S": degree = 90
		"SW": degree = 135
		"W": degree = 180
		"NW": degree = 225
		"N": degree = 270
		"NE": degree = 315
	return deg2rad(degree)