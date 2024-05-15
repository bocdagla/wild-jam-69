class_name BuyBuildingButton;
extends Button;

const BUY_BUILDING_BUTTON_CONTENT = preload("res://prefabs/gameplay/building_creation/buy_building_button_content.tscn")

@onready var _resource_manager: ResourceManager = %ResourceManager;

@export var buildin_record: BuildingRecord;

var _pressed_callables: Array[Callable];

func _ready() -> void:
	assert(_resource_manager);
	assert(buildin_record);
	var pressed_connections = pressed.get_connections();
	for con in pressed_connections:
		_pressed_callables.append(con.callable);
		pressed.disconnect(con.callable);

	_resource_manager.value_changed.connect(_set_available);
	text = buildin_record.name;
	var content = BUY_BUILDING_BUTTON_CONTENT.instantiate() as BuyBuildingButtonContent;
	add_child(content);
	content.setup(buildin_record);


func _pressed() -> void:
	if _resource_manager.is_affordable(buildin_record.gold_cost, buildin_record.defense_cost):
		_resource_manager.purchase(buildin_record.gold_cost);
		for callable in _pressed_callables:
			if callable != null:
				callable.call();

func _set_available(_gold: int, _defense: int) -> void:
	disabled = !_resource_manager.is_affordable(buildin_record.gold_cost, buildin_record.defense_cost);
