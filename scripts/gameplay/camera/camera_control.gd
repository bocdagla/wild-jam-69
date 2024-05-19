extends Camera3D

@export var active: bool = true;
var camera_speed : float = 100.0
var max_x_distance : float = 15;

func _process(delta):
	if not active:
		return;

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
	var clamped = clamp(global_position.x, -max_x_distance, max_x_distance);
	global_position.x = clamped;


