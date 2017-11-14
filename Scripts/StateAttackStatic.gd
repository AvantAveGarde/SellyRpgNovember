extends "res://Scripts/StateAttackCore.gd"

export var attack_end_at_frame = 0

# kill the attack if it still exist.
# This might be the case if either the variable hasnt been properly set,
# or if the animation had been interrupted by a state change (e.g. stun)
func on_exit():
	kill_attack()

# Also kill the attack when the animation finishes.
#In case the state plays multiple animations.
func on_animation_finished():
	.on_animation_finished()
	kill_attack()

# Now it also checks if the attack should be deleted on a certain frame
func on_frame_changed():
	if actor.sprite.frame == attack_begin_at_frame:
		spawn_attack()
	elif actor.sprite.frame == attack_end_at_frame:
		kill_attack()