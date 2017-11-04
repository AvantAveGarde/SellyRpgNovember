extends Area2D

export var moveSpeed = 400
var velocity = Vector2()
var extents
var screensize
func _ready():
	set_process(true)
	screensize = get_viewport_rect().size
	extents = get_node("Sprite").get_texture().get_size() / 2
	translate(screensize / 2)

func _process(delta):
	var input = Vector2(0, 0)

	if Input.is_action_pressed("ui_right"):
		input.x = 1
	elif Input.is_action_pressed("ui_left"):
		input.x = -1
	else:
		input.x = 0
	if Input.is_action_pressed("ui_up"):
		input.y = -1
	elif Input.is_action_pressed("ui_down"):
		input.y = 1
	else:
		input.y = 0
	
	velocity = input.normalized() * moveSpeed
	var pos = get_position() + velocity * delta
	pos.x = clamp(pos.x, 0, screensize.x)
	pos.y = clamp(pos.y, 0, screensize.y)
	set_position(pos)
