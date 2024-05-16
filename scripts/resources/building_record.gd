class_name BuildingRecord;
extends Resource

@export var name: String;

@export var gold_cost: int;
@export var defense_cost: int;
@export var build_turns: int;

@export var gold_gain: int;
@export var defense_gain: int;
@export var turn_gold_gain: int;
@export var turn_defense_gain: int;

func _init(p_name: String = "", p_gold_cost: int = 0, p_defense_cost: int = 0,
		p_build_turns: int = 0,
	p_gold_gain: int = 0, p_defense_gain: int = 0,
		  p_turn_gold_gain: int = 0, p_turn_defense_gain: int = 0) -> void:
	name = p_name
	gold_cost = p_gold_cost
	defense_cost = p_defense_cost
	build_turns = p_build_turns
	gold_gain = p_gold_gain
	defense_gain = p_defense_gain
	turn_gold_gain = p_turn_gold_gain
	turn_defense_gain = p_turn_defense_gain
