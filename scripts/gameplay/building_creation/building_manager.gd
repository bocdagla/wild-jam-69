class_name BuildingManager;
extends Node;

#region Scene imports
const ARCHERY = preload("res://prefabs/gameplay/buildings/archery.tscn");
const ARCHER_TOWER = preload("res://prefabs/gameplay/buildings/archer_tower.tscn");
const BARRACS = preload("res://prefabs/gameplay/buildings/barracs.tscn");
const CASTLE = preload("res://prefabs/gameplay/buildings/castle.tscn");
const FARM = preload("res://prefabs/gameplay/buildings/farm.tscn");
const FORGE = preload("res://prefabs/gameplay/buildings/forge.tscn");
const HOUSE = preload("res://prefabs/gameplay/buildings/house.tscn");
const HOUSE_BIG = preload("res://prefabs/gameplay/buildings/house_big.tscn");
const LUMBERMILL = preload("res://prefabs/gameplay/buildings/lumbermill.tscn");
const MAGE_TOWER = preload("res://prefabs/gameplay/buildings/mage_tower.tscn");
const MARKET = preload("res://prefabs/gameplay/buildings/market.tscn");
const MILL = preload("res://prefabs/gameplay/buildings/mill.tscn");
const MINE = preload("res://prefabs/gameplay/buildings/mine.tscn");
const QUARRY = preload("res://prefabs/gameplay/buildings/quarry.tscn");
const TAVERN = preload("res://prefabs/gameplay/buildings/tavern.tscn");
const TOWNHALL = preload("res://prefabs/gameplay/buildings/townhall.tscn");
const WATCHTOWER = preload("res://prefabs/gameplay/buildings/watchtower.tscn");
const SIEGE_TOWER = preload("res://prefabs/gameplay/buildings/siege_tower.tscn");

const build_map : Dictionary = {
	"archery" = ARCHERY,
	"archer_tower" = ARCHER_TOWER,
	"barracks" = BARRACS,
	"castle" = CASTLE,
	"farm" = FARM,
	"forge" = FORGE,
	"house" = HOUSE,
	"big_house" = HOUSE_BIG,
	"lumbremill" = LUMBERMILL,
	"mage_tower" = MAGE_TOWER,
	"market" = MARKET,
	"mill" = MILL,
	"mine" = MINE,
	"quarry" = QUARRY,
	"tavern" = TAVERN,
	"town_hall" = TOWNHALL,
	"watchtower" = WATCHTOWER,
	"siege_tower" = SIEGE_TOWER,
};
#endregion

@onready var city_quarters: Dictionary= {
	"fields": $"Fields",
	"peasants": $"Peasants",
	"shops": $"Shops",
	"castle": $"Castle",
	"mage_towers": $"MageTowers",
	"towers": $"Towers",
	"mines": $"Mines",
	"military": $"Military"
};
var bulding_registry: Dictionary;

signal building_created(building: Building);

func build(record: BuildingRecord) -> void:
	_build(build_map[record.id], city_quarters[record.district_id] as GridRow);

func has_district_space(record: BuildingRecord) -> bool:
	var quarter = city_quarters[record.district_id] as GridRow;
	return quarter.can_build();

func has_required_buildings_built(record: BuildingRecord) -> Array[String]:
	var result: Array[String] =  [];
	var building_amt: int = bulding_registry.get(record.id, 0);
	for required in record.required_buildings:
		if (bulding_registry.get(required, 0) - building_amt) <= 0:
			result.append(required);
	return result;

func has_enough_buildings(record: BuildingRecord) -> bool:
	var building_amt: int = bulding_registry.get(record.id, 0);
	return building_amt < record.max_ammount  || record.max_ammount == 0;

func can_build(record: BuildingRecord) -> bool:
	return has_district_space(record) and has_required_buildings_built(record).is_empty() and has_enough_buildings(record);

func _build(building: PackedScene, row: GridRow):
	var inst = row.add(building);
	inst.finished_building.connect(func(): _add_register(inst.building_record)) ;
	building_created.emit(inst);

func _add_register(record: BuildingRecord):
	if bulding_registry.has(record.id):
		bulding_registry[record.id] += 1;
	else:
		bulding_registry[record.id] = 1;
