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

@export_category("UI show")
@export var _gold_label : Label;
@export var _defense_label : Label;

@export_category("Test Utils")
@export var _ignore_cost : bool = false;

signal value_changed(gold: int, defense: int);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	force_update_labels();

func is_affordable(gold_cost: int, defense_cost: int) -> bool:
	return (gold_cost <= _gold && defense_cost <= _defense) || _ignore_cost;

func purchase(gold_cost: int) -> void:
	_gold -= gold_cost;

func force_update_labels() -> void:
	_gold = _gold;
	_defense = _defense;

func add_gold(ammount: int) -> void:
	_gold += ammount;

func add_defense(ammount: int) -> void:
	_defense += ammount;

func register_building_for_tax_collection(building: Building):
	building.send_resources.connect(collect_taxes);

func collect_taxes(p_gold: int, p_defense: int):
	if p_gold != 0:
		add_gold(p_gold);
	if p_defense != 0:
		add_defense(p_defense);
