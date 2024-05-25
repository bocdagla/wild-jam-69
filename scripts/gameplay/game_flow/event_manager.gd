class_name EventManager
extends Node

@export var remaining_turns_label: Label
@export var required_defense_label: Label
@export var event_description_label: EventWindow
@export var stampede: AnimationPlayer
@export_multiline var first_event_success
@export_multiline var second_event_success
@export_multiline var last_event_success

@onready var resource_manager: ResourceManager = %ResourceManager
@onready var event_ui: CanvasLayer = %EventUI

@export var first_attack_turn: int = 20
@export var first_attack_defense: int = 200
@export var second_attack_turn: int = 40
@export var second_attack_defense: int = 20000
@export var last_attack_turn: int = 60
@export var last_attack_defense: int = 60000

signal crucial_event_started
signal final_event_started
signal crucial_event_resolved(success: bool)

var _current_event_defense_cost: int = 0
var _turns_until_next_event: int = 20
var _next_event_turn: int = 0

func _ready() -> void:
	_next_event_turn = first_attack_turn
	_turns_until_next_event = _next_event_turn-1;
	_current_event_defense_cost = first_attack_defense
	remaining_turns_label.text = str(_turns_until_next_event)
	required_defense_label.text = str(_current_event_defense_cost)

func _on_turn_start(turn: int) -> void:
	_turns_until_next_event = _next_event_turn - turn

	match turn:
		first_attack_turn:
			_handle_event(first_attack_defense, second_attack_turn, second_attack_defense, first_event_success)
			crucial_event_started.emit()

		second_attack_turn:
			_handle_event(second_attack_defense, last_attack_turn, last_attack_defense, second_event_success)
			crucial_event_started.emit()

		last_attack_turn:
			_current_event_defense_cost = last_attack_defense
			event_description_label.description_text = last_event_success
			final_event_started.emit()

	remaining_turns_label.text = str(_turns_until_next_event)

func _handle_event(defense_cost: int, next_turn: int, next_defense_cost: int, description: String) -> void:
	_current_event_defense_cost = defense_cost
	_next_event_turn = next_turn
	required_defense_label.text = str(next_defense_cost)
	event_description_label.description_text = description

func _on_crucial_event_continue() -> void:
	if resource_manager.is_affordable(0, _current_event_defense_cost):
		crucial_event_resolved.emit(true)
	else:
		stampede.stop()
		stampede.play("stampede")
		crucial_event_resolved.emit(false)
