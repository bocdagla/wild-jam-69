class_name BuyBuildingButton;
extends Button;

@onready var _resource_manager: ResourceManager = %ResourceManager;

@export var gold_cost: int = 100;
@export var defense_cost: int = 0;

@export_category("UI")
@onready var _gold_label: Label = $MarginContainer/VBoxContainer/Label/GoldLabel;
@onready var _defense_icon: TextureRect = $MarginContainer/VBoxContainer/Label/DefenseIcon;
@onready var _defense_label: Label = $MarginContainer/VBoxContainer/Label/DefenseLabel;


var _pressed_callables: Array[Callable];

func _ready() -> void:
	assert(_resource_manager);
	var pressed_connections = pressed.get_connections();
	for con in pressed_connections:
		_pressed_callables.append(con.callable);
		pressed.disconnect(con.callable);

	_resource_manager.value_changed.connect(_set_available);
	_gold_label.text = str(gold_cost);
	_defense_label.text = str(defense_cost);
	if defense_cost == 0:
		_defense_label.visible = false;
		_defense_icon.visible = false;


func _pressed() -> void:
	if _resource_manager.is_affordable(gold_cost, defense_cost):
		_resource_manager.purchase(gold_cost);
		for callable in _pressed_callables:
			if callable != null:
				callable.call();

func _set_available(_gold: int, _defense: int) -> void:
	disabled = !_resource_manager.is_affordable(gold_cost, defense_cost);
