extends KinematicBody

# Car behavior parameters, adjust as needed
export var gravity = -60.0
export var wheel_base = 0.6  # distance between front/rear axles
export var steering_limit = 1.0  # front wheel max turning angle (deg)
export var engine_power = 100.0
export var braking = -9.0
export var friction = -2.0
export var drag = -2.0
export var max_speed_reverse = 10.0

# Car state properties
var acceleration = Vector3.ZERO  # current acceleration
var velocity = Vector3.ZERO  # current velocity
var steer_angle = 0.1  # current wheel angle

export var slip_speed = 1.0
export var traction_slow = 0.75
export var traction_fast = 0.02

var drifting = false

func _physics_process(delta):
# If either wheel is in the air, align to slope.

	if is_on_floor():
		get_input()
		apply_friction(delta)
		calculate_steering(delta)
	
	acceleration.y = gravity
	velocity += acceleration * delta
	
	if $FrontRay.is_colliding() or $RearRay.is_colliding():
# If one wheel is in air, move it down

		var nf = $FrontRay.get_collision_normal() if $FrontRay.is_colliding() else Vector3.UP
		var nr = $RearRay.get_collision_normal() if $RearRay.is_colliding() else Vector3.UP
		var n = ((nr + nf) / 2.0).normalized()
		var xform = align_with_y(global_transform, n)
		global_transform = global_transform.interpolate_with(xform, 0.1)
	
	velocity = move_and_slide_with_snap(velocity, -transform.basis.y, Vector3.UP, true)

func apply_friction(delta):
	if velocity.length() < 0.2 and acceleration.length() == 0:
		velocity.x = 0
		velocity.z = 0
	var friction_force = velocity * friction * delta
	var drag_force = velocity * velocity.length() * drag * delta
	acceleration += drag_force + friction_force

func calculate_steering(delta):
	var rear_wheel = transform.origin + transform.basis.z * wheel_base / 2.0
	var front_wheel = transform.origin - transform.basis.z * wheel_base / 2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(transform.basis.y, steer_angle) * delta
	var new_heading = rear_wheel.direction_to(front_wheel)
	# traction



	var d = new_heading.dot(velocity.normalized())
	if not drifting and velocity.length() > slip_speed:
		drifting = true
	if drifting and velocity.length() < slip_speed and steer_angle == 0:
		drifting = false
	var traction = traction_fast if drifting else traction_slow
	
	
	if d > 0:
		velocity = lerp(velocity, new_heading * velocity.length(), traction)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	
	
	
	look_at(transform.origin + new_heading, transform.basis.y)
	


func get_input():
	# Override this in inherited scripts for controls
	pass
#
func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform

