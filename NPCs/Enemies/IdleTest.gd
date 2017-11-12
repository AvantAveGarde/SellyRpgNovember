extends "res://Scripts/StateCore.gd"

func on_enter():
	actor.sprite.play(actor.idle_south)
	.on_enter()