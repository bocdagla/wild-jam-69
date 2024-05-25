class_name BuyBuildingButtonContent
extends MarginContainer

@onready var _gold_label: Label = $VBoxContainer/CostRow/GoldLabel
@onready var _defense_icon: TextureRect = $VBoxContainer/CostRow/DefenseIcon
@onready var _defense_label: Label = $VBoxContainer/CostRow/DefenseLabel
@onready var _benefit = $VBoxContainer/BenefitRow/Benefit
@onready var _benefit_gold_icon = $VBoxContainer/BenefitRow/BenefitGoldIcon
@onready var _benefit_gold = $VBoxContainer/BenefitRow/BenefitGold
@onready var _benefit_defense_icon = $VBoxContainer/BenefitRow/BenefitDefenseIcon
@onready var _benefit_defense = $VBoxContainer/BenefitRow/BenefitDefense
@onready var _benefit_turn = $VBoxContainer/TurnRow/BenefitTurn
@onready var _benefit_turn_gold_icon = $VBoxContainer/TurnRow/BenefitTurnGoldIcon
@onready var _benefit_turn_gold = $VBoxContainer/TurnRow/BenefitTurnGold
@onready var _benefit_turn_defense_icon = $VBoxContainer/TurnRow/BenefitTurnDefenseIcon
@onready var _benefit_turn_defense = $VBoxContainer/TurnRow/BenefitTurnDefense
@onready var _building_name: Label = $VBoxContainer/Name
@onready var _required_buildings: VBoxContainer = $VBoxContainer/RequiredBuildings
@onready var _resource_manager: ResourceManager = %ResourceManager
@onready var _building_manager: BuildingManager = %BuildingManager
@onready var _turn_manager: TurnManager = %TurnManager
@onready var _build_button: Button = $VBoxContainer/Build

var current_selection: BuildingRecord = null

func _ready() -> void:
	visible = false
	_turn_manager.turn_started.connect(_on_turn_started)
	_resource_manager.value_changed.connect(_on_value_changed)
	_build_button.pressed.connect(_build)
	_building_manager.registry_updated.connect(_on_registry_updated)

func setup(building_record: BuildingRecord) -> void:
	current_selection = building_record
	_building_name.text = "%s (%d turns to build)" % [current_selection.name, current_selection.build_turns]
	_gold_label.text = str(building_record.gold_cost)
	_defense_label.text = str(building_record.defense_cost)
	_defense_label.visible = building_record.defense_cost != 0
	_defense_icon.visible = building_record.defense_cost != 0

	_setup_benefit(
		building_record.gold_gain,
		building_record.defense_gain,
		_benefit,
		_benefit_gold,
		_benefit_gold_icon,
		_benefit_defense,
		_benefit_defense_icon
	)

	_setup_benefit(
		building_record.turn_gold_gain,
		building_record.turn_defense_gain,
		_benefit_turn,
		_benefit_turn_gold,
		_benefit_turn_gold_icon,
		_benefit_turn_defense,
		_benefit_turn_defense_icon
	)

	_enable_build()
	visible = true

func _setup_benefit(gain_gold: int, gain_defense: int, container: Control, gold_label: Label, gold_icon: Control, defense_label: Label, defense_icon: Control) -> void:
	container.visible = gain_gold != 0 or gain_defense != 0
	gold_label.text = str(gain_gold)
	gold_label.visible = gain_gold != 0
	gold_icon.visible = gain_gold != 0
	defense_label.text = str(gain_defense)
	defense_label.visible = gain_defense != 0
	defense_icon.visible = gain_defense != 0

func clear_required_buildings() -> void:
	for child in _required_buildings.get_children():
		_required_buildings.remove_child(child)
		child.queue_free()

func add_required_buildings(requirements: Array[String]) -> void:
	if requirements.is_empty():
		return

	var req_label = Label.new()
	req_label.text = "Required Buildings"
	_required_buildings.add_child(req_label)
	_required_buildings.add_child(HSeparator.new())

	for requirement in requirements:
		if !Db.buildings.has(requirement):
			continue;
		req_label = Label.new()
		req_label.text = Db.buildings[requirement].name
		_required_buildings.add_child(req_label)

func _build() -> void:
	if _build_enabled():
		_resource_manager.purchase(current_selection.gold_cost)
		_building_manager.build(current_selection)

func _build_enabled() -> bool:
	return current_selection != null && _resource_manager.is_affordable(current_selection.gold_cost, current_selection.defense_cost) and _building_manager.can_build(current_selection)

func _on_turn_started(_next_turn: int) -> void:
	_enable_build()

func _on_value_changed(_gold: int, _defense: int) -> void:
	_enable_build()

func _on_registry_updated() -> void:
	_enable_build()

func _enable_build() -> void:
	var enabled = _build_enabled()
	_build_button.disabled = not enabled
	clear_required_buildings()
	if not enabled:
		var required_buildings = _building_manager.has_required_buildings_built(current_selection)
		add_required_buildings(required_buildings)
