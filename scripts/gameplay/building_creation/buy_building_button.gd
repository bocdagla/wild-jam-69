class_name BuyBuildingButton;
extends Button;

@onready var _resource_manager: ResourceManager = %ResourceManager;

@export var buildin_record: BuildingRecord;

@export_category("UI")
@onready var _gold_label: Label = $MarginContainer/VBoxContainer/Label/GoldLabel;
@onready var _defense_icon: TextureRect = $MarginContainer/VBoxContainer/Label/DefenseIcon;
@onready var _defense_label: Label = $MarginContainer/VBoxContainer/Label/DefenseLabel;


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
	_gold_label.text = str(buildin_record.gold_cost);
	_defense_label.text = str(buildin_record.defense_cost);
	if buildin_record.defense_cost == 0:
		_defense_label.visible = false;
		_defense_icon.visible = false;


func _pressed() -> void:
	if _resource_manager.is_affordable(buildin_record.gold_cost, buildin_record.defense_cost):
		_resource_manager.purchase(buildin_record.gold_cost);
		for callable in _pressed_callables:
			if callable != null:
				callable.call();

func _set_available(_gold: int, _defense: int) -> void:
	disabled = !_resource_manager.is_affordable(buildin_record.gold_cost, buildin_record.defense_cost);
