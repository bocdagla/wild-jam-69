class_name BuildingRecord;
extends Resource;

@export var id: String;
@export var district_id: String;
@export var name: String;

@export_category("Costs")
@export var gold_cost: int;
@export var defense_cost: int;
@export var build_turns: int;

@export_category("Gains")
@export var gold_gain: int;
@export var defense_gain: int;
@export var turn_gold_gain: int;
@export var turn_defense_gain: int;

@export_category("Restrictions")
@export var max_ammount: int;
@export var required_buildings: Array[String];

func _init(
		p_id: String = "", p_district_id: String = "",
		p_name: String = "", p_gold_cost: int = 0, p_defense_cost: int = 0,
		p_build_turns: int = 0,
		p_gold_gain: int = 0, p_defense_gain: int = 0,
		p_turn_gold_gain: int = 0, p_turn_defense_gain: int = 0,
		p_max_ammount: int = 0, p_required_buildings: Array[String] = []) -> void:
	id = p_id;
	district_id = p_district_id;
	name = p_name;
	gold_cost = p_gold_cost;
	defense_cost = p_defense_cost;
	build_turns = p_build_turns;
	gold_gain = p_gold_gain;
	defense_gain = p_defense_gain;
	turn_gold_gain = p_turn_gold_gain;
	turn_defense_gain = p_turn_defense_gain;
	max_ammount = p_max_ammount;
	required_buildings = p_required_buildings;
