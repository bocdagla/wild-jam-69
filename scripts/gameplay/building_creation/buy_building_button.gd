class_name BuyBuildingButton;
extends Button;

static var building_names: Dictionary;

@export var buy_building_button_content: BuyBuildingButtonContent ;
@export var turn_manager: TurnManager ;
@export var resource_manager: ResourceManager;
@export var building_manager: BuildingManager;
@export var record: BuildingRecord:
	set(value):
		record = value;
		name = record.name;

func _ready() -> void:
	if Engine.is_editor_hint():
		return;

	assert(resource_manager);
	assert(building_manager);
	assert(record);

	turn_manager.turn_started.connect(_on_turn_started);
	resource_manager.value_changed.connect(_on_value_changed);
	building_manager.registry_updated.connect(_on_registry_updated);

	building_names[record.id] = record.name;
	call_deferred("_set_available");


func _pressed() -> void:
	buy_building_button_content.setup(record);

func _on_turn_started(_next_turn: int) -> void:
	_set_available();

func _on_value_changed(_gold:int,_defense:int):
	_set_available();

func _on_registry_updated() -> void:
	_set_available();

func _set_available() -> void:
	var requried_buildings = building_manager.has_required_buildings_built(record);
	add_theme_color_override("font_color", Color.PALE_VIOLET_RED);
	text = record.name;
	if !building_manager.has_district_space(record):
		text +="\nNO SPACE IN DISTRICT";
	elif !building_manager.has_enough_constructions_left(record):
		text += "\nMAX BUILDING AMMOUNT REACHED";
	elif !requried_buildings.is_empty():
		text += "\nREQUIRED BUILDINGS";
	elif !resource_manager.is_affordable(record.gold_cost, record.defense_cost):
		text += "\nNOT AFFORDABLE";
	else:
		add_theme_color_override("font_color", Color.SKY_BLUE);
		text = record.name;
