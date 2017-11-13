extends "res://Scripts/StateAttackDynamic.gd"

func get_attack_rotation():
	return actor.get_angle_to(actor.viewport.get_mouse_position())