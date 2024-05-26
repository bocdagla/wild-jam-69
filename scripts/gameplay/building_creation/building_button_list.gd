class_name BuildingButtonList
extends VBoxContainer

@onready var buy_building_button_content: BuyBuildingButtonContent = %BuyBuildingButtonContent
@onready var turn_manager: TurnManager = %TurnManager
@onready var resource_manager: ResourceManager = %ResourceManager;
@onready var building_manager: BuildingManager = %BuildingManager
@export var districts: Array[String];
@export var container_columns: int = 2;
@export var button_min_size: Vector2 = Vector2(0, 100);

func _ready() -> void:
	call_deferred("_create_buttons");

func _create_buttons() -> void:
	if districts.is_empty():
		return;

	for district in districts:
		var lbl = DistrictLabel.new();
		lbl.building_manager = building_manager;
		lbl.district = district;
		add_child(lbl);

		add_child(HSeparator.new());

		var container = DistricBuyButtonsContainer.new();
		container.district = district;
		container.columns = container_columns;
		container.min_size = button_min_size;
		container.building_manager = building_manager;
		container.buy_building_button_content = buy_building_button_content;
		container.turn_manager = turn_manager;
		container.resource_manager = resource_manager;
		add_child(container);


