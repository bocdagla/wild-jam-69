class_name EventManager;
extends Node;

@onready var resource_manager: ResourceManager = %ResourceManager
@onready var event_ui: CanvasLayer = %EventUI

@export var first_attack_turn := 10;
@export var first_attack_defense := 10;
@export var second_attack_turn := 20;
@export var second_attack_defense := 10;
@export var last_attack_turn := 30;
@export var last_attack_defense := 10;

signal crucial_event_started;
signal final_event_started();
signal crucial_event_resolved(success: bool);

var _current_event_defense_cost: int = 0;

func _on_turn_start(turn: int):
	match turn:
		first_attack_turn:
			_current_event_defense_cost = first_attack_defense;
			crucial_event_started.emit();
		second_attack_turn:
			_current_event_defense_cost = second_attack_defense;
			crucial_event_started.emit();
		last_attack_turn:
			_current_event_defense_cost = last_attack_defense;
			final_event_started.emit();

func _on_crucial_event_continue():
	if resource_manager.is_affordable(0, _current_event_defense_cost):
		crucial_event_resolved.emit(true);
	else:
		crucial_event_resolved.emit(false);
