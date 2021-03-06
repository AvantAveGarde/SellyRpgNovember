extends "res://Scripts/ActorCore.gd"

# class member variables go here, for example:
onready var timer = get_node("Timer")
var fireball = preload("res://Combat/Attacks/Fireball.tscn")

func _ready():
	._ready()
	timer.connect("timeout", self, "spawn_fireball")
	timer.start()

func spawn_fireball():
	var new_fireball = fireball.instance()
	#new_fireball.rotate(randi())
	#new_fireball.position = self.position
	new_fireball.set_source(self)
	add_child(new_fireball)