extends "res://NPCs/Enemies/StateCore.gd"

func on_enter():
	actor.sprite.play(actor.idle_south)
	.on_enter()