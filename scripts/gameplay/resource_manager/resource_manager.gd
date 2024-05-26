class_name ResourceManager;
extends Node;

@export var _gold : int = 0 :
	set(value):
		_gold = value;
		value_changed.emit(_gold, _defense);
		if _gold_label:
			_gold_label.text = str(value);

@export var _defense : int = 0:
	set(value):
		_defense = value;
		value_changed.emit(_gold, _defense);
		if _defense_label:
			_defense_label.text = str(value);

@export var _next_gold : int = 0 :
	set(value):
		_next_gold = value;
		if _next_gold_label:
			_next_gold_label.text = "+ " + str(value);

@export var _next_defense : int = 0:
	set(value):
		_next_defense = value;
		if _next_defense_label:
			_next_defense_label.text = "+ " + str(value);

@export_category("UI show")
@export var _gold_label : Label;
@export var _defense_label : Label;
@export var _next_gold_label : Label;
@export var _next_defense_label : Label;

@export_category("Test Utils")
@export var _ignore_cost : bool = false;

signal value_changed(gold: int, defense: int);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	force_update_labels();

func is_affordable(gold_cost: int, defense_cost: int) -> bool:
	return (gold_cost <= _gold && defense_cost <= _defense) || _ignore_cost;

func purchase(gold_cost: int, defense_cost: int) -> void:
	_gold -= gold_cost;
	_defense -= defense_cost;

func force_update_labels() -> void:
	_gold = _gold;
	_defense = _defense;

func add_gold(ammount: int) -> void:
	_gold += ammount;

func add_defense(ammount: int) -> void:
	_defense += ammount;

func register_building_for_tax_collection(building: Building):
	building.send_resources.connect(collect_taxes);
	building.send_expected_gold_next_turn.connect(add_next_tax_collection_ammount);

func add_next_tax_collection_ammount(gold: int, defense: int):
	_next_gold += gold;
	_next_defense += defense;

func collect_taxes(p_gold: int, p_defense: int):
	if p_gold != 0:
		add_gold(p_gold);
	if p_defense != 0:
		add_defense(p_defense);

func _on_turn_ended() -> void:
	_next_gold = 0;
	_next_defense = 0;
