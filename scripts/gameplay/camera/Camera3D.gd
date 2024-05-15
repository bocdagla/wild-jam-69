extends Camera3D

var camera_speed : float = 100.0

func _process(delta):
	var camera_movement = Vector3.ZERO
	if Input.is_action_pressed("left"):
		print("estoy pulsando izquierda")
		camera_movement.x -= 1
	if Input.is_action_pressed("right"):
		print("estoy pulsando derecha")
		camera_movement.x += 1

	# Normaliza el movimiento para que no se mueva más rápido en diagonal
	if camera_movement.length() > 0:
		camera_movement = camera_movement.normalized() * camera_speed * delta

	# Aplica el movimiento a la posición de la cámara
	translate(camera_movement)


