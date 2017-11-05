extends Control

var energyBar

func _ready():
	energyBar = get_node("EnergyBar")

func set_energy(value):
	energyBar.value = value