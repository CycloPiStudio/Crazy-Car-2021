extends "res://Ejecutable/Juego/Personajes/coche cinematico/car_base.gd"

func get_input():
	var turn = Input.get_action_strength("steer_left")
	turn -= Input.get_action_strength("steer_right")
	steer_angle = turn * deg2rad(steering_limit)
	$tmpParent/ambulance/wheel_frontRight.rotation.y = steer_angle*2
	$tmpParent/ambulance/wheel_frontLeft.rotation.y = steer_angle*2
	acceleration = Vector3.ZERO
	if Input.is_action_pressed("accelerate"):
		acceleration = -transform.basis.z * engine_power
	if Input.is_action_pressed("brake"):
		acceleration = -transform.basis.z * braking

