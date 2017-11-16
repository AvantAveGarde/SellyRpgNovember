extends "res://Scripts/ActorCore.gd"

const ranged_enemy_speed = 125

func _ready():
	set_process(true)
	
func _process(delta):
	var body = get_node("AggroRange").get_overlapping_bodies()
	var velocity = Vector2()
	if(body.size() != 0):
		for object in body:
			if(object.is_in_group("Player")):
				if(object.position.x > self.position.x):
					velocity += Vector2(-1, 0)
				else:
					velocity += Vector2(1, 0)
				if(object.position.y > self.position.y):
					velocity += Vector2(0, -1)
				else:
					velocity += Vector2(0, 1)
	velocity = velocity.normalized() * ranged_enemy_speed
	move_and_slide(velocity)