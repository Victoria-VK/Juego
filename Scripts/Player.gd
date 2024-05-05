extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -350.0
const ACCELERATION = 100
const RADIUS = 23.02 #radio de la colision box
const RADIAL_VELOCITY = 500
const FRICTION = 10

var gravity = 1200.0

var has_another_jump = false
var has_jumped = false

var coyote_time = 0.0
var coyote_maximum_time = 0.3

func _ready():
	$Coyote.set_wait_time(coyote_time)

func _physics_process(delta):
	
	if(Input.is_action_pressed("LEFT")):
		if(is_on_floor()):
			velocity.x += -SPEED/4
		else:
			velocity.x += -SPEED/7
	elif(Input.is_action_pressed("RIGHT")):
		if(is_on_floor()):
			velocity.x += SPEED/4
		else:
			velocity.x += SPEED/7
	
	
	velocity.x -= velocity.x/FRICTION
	#APLICACION DE LA GRAVEDAD
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		coyote_time = 0.0
		has_jumped = false
		has_another_jump = true
	else:
		coyote_time += delta
	
	
	
	if Input.is_action_just_pressed("JUMP"):
		if (coyote_maximum_time > coyote_time) and not has_jumped:
			velocity.y = JUMP_VELOCITY + velocity.y / 2
		elif has_another_jump:
			has_another_jump = false
			if velocity.y < 0:
				velocity.y = JUMP_VELOCITY/1.2 + velocity.y / 2
			else:
				velocity.y = JUMP_VELOCITY/1.2
		has_jumped = false
	
	
	
	#var rotation_speed = 0
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.slide(collision.get_normal())
		#rotation_speed = (velocity.y / RADIUS) / 90 + rotation_speed
	
	
	#rotation_speed = ((velocity.x / RADIUS) / 90)
	#rotation += rotation_speed
	move_and_slide()
	
	print(is_on_floor())
	
func _on_timer_timeout():
	pass
