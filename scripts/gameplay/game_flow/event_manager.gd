class_name EventManager;
extends Node;

@export var remaining_turns_label: Label;
@export var event_description_label: Label;
@export_multiline var first_event_success;
@export_multiline var first_event_failure;
@export_multiline var second_event_success;
@export_multiline var second_event_failure;
@export_multiline var last_event_success;
@export_multiline var last_event_failure;

@onready var resource_manager: ResourceManager = %ResourceManager
@onready var event_ui: CanvasLayer = %EventUI

@export var first_attack_turn := 20;
@export var first_attack_defense := 10;
@export var second_attack_turn := 70;
@export var second_attack_defense := 40;
@export var last_attack_turn := 60;
@export var last_attack_defense := 2000;

signal crucial_event_started;
signal final_event_started();
signal crucial_event_resolved(success: bool);

var _current_event_defense_cost: int = 0;
var _turns_until_next_event: int = 20;

func _ready() -> void:
	_turns_until_next_event = first_attack_turn;

func _on_turn_start(turn: int):
	_turns_until_next_event -= 1;
	match turn:
		first_attack_turn:
			_current_event_defense_cost = first_attack_defense;
			_turns_until_next_event = second_attack_turn - first_attack_defense;
			crucial_event_started.emit();

		second_attack_turn:
			_current_event_defense_cost = second_attack_defense;
			_turns_until_next_event = last_attack_turn - second_attack_turn;
			crucial_event_started.emit();

		last_attack_turn:
			_current_event_defense_cost = last_attack_defense;
			final_event_started.emit();

func _on_crucial_event_continue():
	if resource_manager.is_affordable(0, _current_event_defense_cost):
		crucial_event_resolved.emit(true);
	else:
		crucial_event_resolved.emit(false);
