extends "res://Combat/Attacks/AttackCore.gd"

export var move_speed = 200

func _process(delta):
	._process(delta)
	update_movement(delta)

func update_movement(delta):
	var velocity = Vector2(1, 0)
	velocity = velocity.rotated(global_rotation)
	velocity = velocity.normalized() * move_speed
	move_and_slide(velocity)