@tool
class_name BuyBuildingButton;
extends Button;

static var building_names: Dictionary;
const BUY_BUILDING_BUTTON_CONTENT = preload("res://prefabs/gameplay/building_creation/buy_building_button_content.tscn")

@onready var _turn_manager: TurnManager = %TurnManager
@onready var _resource_manager: ResourceManager = %ResourceManager;
@onready var _building_manager: BuildingManager = %BuildingManager
@export var record: BuildingRecord:
	set(value):
		record = value;
		name = record.name;

func _ready() -> void:
	assert(_resource_manager);
	assert(_building_manager);
	assert(record);
	var content = BUY_BUILDING_BUTTON_CONTENT.instantiate() as BuyBuildingButtonContent;
	add_child(content);
	content.setup(record);

	_turn_manager.turn_started.connect(_on_turn_started);
	_resource_manager.value_changed.connect(_on_value_changed);
	building_names[record.id] = record.name;
	call_deferred("_set_available");

func _pressed() -> void:
	if _resource_manager.is_affordable(record.gold_cost, record.defense_cost):
		if _build_enabled():
			_resource_manager.purchase(record.gold_cost);
			_building_manager.build(record);

func _on_turn_started(_next_turn: int) -> void:
	_set_available();

func _on_value_changed(_gold:int,_defense:int):
	_set_available();

func _set_available() -> void:
	var requried_buildings = _building_manager.has_required_buildings_built(record);
	if !_building_manager.has_district_space(record):
		text = record.name + "\nNO SPACE IN DISTRICT";
		disabled = true;
	elif !_building_manager.has_enough_buildings(record):
		text = record.name + "\nMAX BUILDING AMMOUNT REACHED";
		disabled = true;
	elif !requried_buildings.is_empty():
		text = record.name + "\nREQUIRED";
		for id in requried_buildings:
			if building_names.has(id):
				text += "\n 1 "+ building_names[id];
		disabled = true;
	elif !_resource_manager.is_affordable(record.gold_cost, record.defense_cost):
		text = record.name + "\nNO RESOURCES";
		disabled = true;
	else:
		text = record.name;
		disabled = false;

func _build_enabled() -> bool:
	return _resource_manager.is_affordable(record.gold_cost, record.defense_cost) && _building_manager.can_build(record);
