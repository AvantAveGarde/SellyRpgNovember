extends VBoxContainer

func _on_NewGame_pressed():
	get_tree().change_scene("res://Stages/stage_world.tscn")
	pass

func _on_LoadGame_pressed():
	#TODO: Load Functions
	pass

func _on_Credits_pressed():
	get_node("../CreditsPanel").show()
	pass

func _on_Exit_pressed():
	get_tree().quit()
	pass
