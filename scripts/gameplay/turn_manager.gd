var current_turn := 1

# Función para avanzar al siguiente turno
func next_turn():
	current_turn += 1
	update_game_state()
	print("Turno actual: %s" % current_turn)

# Actualiza el estado del juego al cambiar de turno
func update_game_state():
	# Aquí iría la lógica para actualizar los recursos del jugador, construcciones, etc.
	pass

# Puedes conectar esta función a un botón en tu interfaz de usuario
func _on_TurnButton_pressed():
	next_turn()
