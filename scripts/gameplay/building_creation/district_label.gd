class_name DistrictLabel;
extends Label

@export var district: String;
@export var building_manager: BuildingManager;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_text();
	building_manager.registry_updated.connect(_on_registry_updated);

func _on_registry_updated():
	_update_text();

func _update_text():
	if Db.districts.has(district):
		text = Db.districts[district];
	var space_left = building_manager.get_district_space(district);
	if not space_left.is_empty():
		text += " (%d of %d)" % [space_left[0], space_left[1]];
