extends Control

var energy_bar

func _ready():
	energy_bar = get_node("EnergyBar")

func set_energy(value):
	energy_bar.value = value
	
func set_max_energy(value):
	energy_bar.max_value = value