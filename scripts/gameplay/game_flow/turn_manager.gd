class_name TurnManager;
extends Node

@export var turn_label : Label
var current_turn := 1

signal turn_ended();
signal turn_started(turn: int);

func _ready():
	turn_label.text = str(current_turn);

# Función para avanzar al siguiente turno
func next_turn():
	current_turn += 1
	print("Turno actual: %s" % current_turn)
	turn_label.text = str(current_turn);
	turn_ended.emit();
	turn_started.emit(current_turn);

# Puedes conectar esta función a un botón en tu interfaz de usuario
func _on_TurnButton_pressed():
	next_turn()

func _on_building_created(building: Building):
	turn_ended.connect(building.advance_turn);
