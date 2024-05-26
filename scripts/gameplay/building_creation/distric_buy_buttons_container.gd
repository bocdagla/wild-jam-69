class_name DistricBuyButtonsContainer;
extends GridContainer

@export var district: String;
@export var min_size: Vector2 = Vector2(0, 100);
@export var buy_building_button_content: BuyBuildingButtonContent
@export var turn_manager: TurnManager
@export var resource_manager: ResourceManager
@export var building_manager: BuildingManager

func _ready() -> void:
	for record in Db.buildings.values():
		if record.district_id == district:
			var button = BuyBuildingButton.new();
			button.record = record;
			button.custom_minimum_size = min_size;
			button.size_flags_horizontal = Control.SIZE_EXPAND_FILL;
			button.building_manager = building_manager;
			button.buy_building_button_content = buy_building_button_content;
			button.turn_manager = turn_manager;
			button.resource_manager = resource_manager;
			add_child(button);
