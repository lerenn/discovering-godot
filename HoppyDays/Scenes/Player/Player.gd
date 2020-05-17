extends KinematicBody2D

var motion = Vector2(0,0)

const SPEED = 1000
const GRAVITY = 500
const UP = Vector2(0,-1)
const JUMP_SPEED = 3000

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	move_and_slide(motion, UP)

func apply_gravity():
	if is_on_floor():
		motion.y = 0
	else:
		motion.y += GRAVITY

func move():
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	if left and !right:
		motion.x = -SPEED
	elif right and !left:
		motion.x = SPEED
	else:
		motion.x = 0

func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= JUMP_SPEED
