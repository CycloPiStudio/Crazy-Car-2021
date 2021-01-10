extends KinematicBody
var gravedad = Vector3.DOWN * 1000
var velocidad = Vector3.ZERO
var aceleracion = 20
var n = Vector3.UP
var rot_speed = 1
var speed = 0
var controles = true
var max_speed = 15
var min_speed = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input(delta)
	aplicar_friccion(delta)
	velocidad += gravedad*delta
	velocidad += transform.basis.z * speed 
	velocidad = move_and_slide(velocidad,Vector3.UP,true)
	if $RayCast.is_colliding():
		n = $RayCast.get_collision_normal()
		gravedad = -transform.basis.y * 1000
		controles = true
	else:
		gravedad = Vector3.DOWN * 1000
		controles = false
	velocidad = Vector3.ZERO
	
	
	
	
	var xform = alinear_con_y(global_transform, n)
	
	global_transform = global_transform.interpolate_with(xform, 0.2)

func get_input(delta):
	speed = clamp(speed,-max_speed,min_speed)
	if Input.is_action_pressed("acelerar") and controles:
		speed -= aceleracion*delta	
	elif Input.is_action_pressed("frenar") and controles:
		speed += aceleracion*delta	
	if Input.is_action_pressed("derecha") and controles:
#		rotate_y(-rot_speed * delta)
		rotate_object_local(Vector3.DOWN, 0.05)
#		transform.basis = transform.basis.rotated(Vector3.DOWN, 0.01)
	elif Input.is_action_pressed("izquierda") and controles:
#		rotate_y(rot_speed * delta)
		rotate_object_local(Vector3.UP, 0.05)
#		transform.basis = transform.basis.rotated(Vector3.UP, 0.01)
func alinear_con_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform

func aplicar_friccion(delta):
	if speed<0:
		speed += 10 * delta
	elif speed>0:
		speed -= 10 * delta
	else:
		pass
