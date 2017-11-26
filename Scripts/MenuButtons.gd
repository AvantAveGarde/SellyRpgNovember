extends VBoxContainer

func _on_NewGame_pressed():
	get_tree().change_scene("res://Stages/stage_world.tscn")
	pass

func _on_LoadGame_pressed():
	#TODO: Load Functions
	pass

func _on_Settings_pressed():
	#TODO: Open Settings Menu
	pass

func _on_Credits_pressed():
	#TODO: Open Credits Menu
	pass

func _on_Exit_pressed():
	get_tree().quit()
	pass
