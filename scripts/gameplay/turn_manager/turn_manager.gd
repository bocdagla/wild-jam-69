class_name TurnManager;
extends Node

@export var last_turn := 30
@export var turn_label : Label
@export var end_game_message : Label
var current_turn := 1

signal turn_ended();

func _ready():
	turn_label.text = str(current_turn);
	end_game_message.visible = false

# Función para avanzar al siguiente turno
func next_turn():
	current_turn += 1
	update_game_state()
	print("Turno actual: %s" % current_turn)
	turn_label.text = str(current_turn);
	turn_ended.emit();

# Actualiza el estado del juego al cambiar de turno
func update_game_state():
	if current_turn >= last_turn:
		end_game_message.visible = true

# Puedes conectar esta función a un botón en tu interfaz de usuario
func _on_TurnButton_pressed():
	next_turn()

func _on_building_created(building: Building):
	turn_ended.connect(building.advance_turn);
