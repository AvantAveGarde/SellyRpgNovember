extends Node

export var max_health = 10
export var block_reduction = 2
export var move_speed = 200
export var max_charges = 5

onready var health = max_health

signal die

func _ready():
	pass

func damage(sorce, attack):
	health -= attack.get_total_damage()
	if (health <= 0):
		print("player diededed!")
		#emit_signal("die")