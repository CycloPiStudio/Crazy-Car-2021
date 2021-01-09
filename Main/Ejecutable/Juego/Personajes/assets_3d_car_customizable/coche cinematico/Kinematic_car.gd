extends KinematicBody

export var maxVelocidad =50
export var maxReversa =30
export var accelerationReversa = 20
export var acceleration = 40
export var fuerzaFreno = 20
var activado = true
export var gravity = Vector3.DOWN * 1000
var speed = 0
export var rot_speed = 0.85
var velocity = Vector3.ZERO
#####################################
  # current acceleration


var drifting = false
#####################################

func _physics_process(delta):
#	velocity += gravity * delta
#	get_input(delta)
#	velocity = move_and_slide_with_snap(velocity, Vector3.DOWN*2, Vector3.UP, true)
#	var n = $RayCast.get_collision_normal()
#	var xform = align_with_y(global_transform, n)
#	global_transform = global_transform.interpolate_with(xform, 0.2)
	#################################
#	print(velocity.length ( ))
	velocity = Vector3.ZERO
	velocity += gravity * delta
	apply_friction(delta)
	
	
	
	
	
	
	velocity += transform.basis.z * speed 
	get_input(delta)
#	velocity = lerp(velocity, Vector3(velocity.x,velocity.z,velocity.z), 0.1)
	velocity = move_and_slide_with_snap(velocity, Vector3.DOWN*2, Vector3.UP, true)
	var n = Vector3( 0, 1, 0 )
	if is_on_floor():
		n = $RayCast.get_collision_normal()
		activado = true
#
#	else:
#		n = Vector3( 0, 1, 0 )
	var xform = align_with_y(global_transform, n)
#	var yform = align_with_x(global_transform, n)
	global_transform = global_transform.interpolate_with(xform, 0.2)

	#################################
func get_input(delta):
	var vy = velocity.y
#	speed = clamp(speed,-maxVelocidad,maxReversa)
#	velocity = Vector3.ZERO
	if Input.is_action_pressed("accelerate") and activado:
#		velocity += -transform.basis.z * speed
		######################################
		
		speed -= acceleration*delta	
#		print("transform.basis.z",transform.basis.z)
#		print("velocity",velocity)
		######################################
	elif Input.is_action_pressed("brake") and activado:
		
		if speed<0:
			speed += fuerzaFreno * delta
		elif speed>=0:
			speed += accelerationReversa*delta
#		
#	else:
#		if speed<0:
#			speed += 10 * delta
#		elif speed>0:
#			speed -= 10
#		else:
#			speed = 0
	if Input.is_action_pressed("steer_right") :
		rotate_y(-rot_speed * delta)
	if Input.is_action_pressed("steer_left") :
		rotate_y(rot_speed * delta)

	
	velocity.y = vy

func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform

func apply_friction(delta):
	if speed<0:
		speed += 10 * delta
	elif speed>0:
		speed -= 10 * delta
	pass

