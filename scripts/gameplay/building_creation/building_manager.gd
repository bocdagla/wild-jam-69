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
const SIEGE_TOWER = preload("res://prefabs/gameplay/buildings/siege_tower.tscn")
#endregion

var bulding_registry: Dictionary;

@export var last_grid: GridRow;
@export var mid_grid: GridRow;
@export var front_grid: GridRow;

signal building_created(building: Building);

#region Building functions

func build_archery():
	_build_mid(ARCHERY);

func build_archer_tower():
	_build_last(ARCHER_TOWER);

func build_barracs():
	_build_mid(BARRACS);

func build_castle():
	_build_last(CASTLE);

func build_farm():
	_build_front(FARM);

func build_forge():
	_build_mid(FORGE);

func build_house():
	_build_front(HOUSE);

func build_house_big():
	_build_mid(HOUSE_BIG);

func build_lumbermill():
	_build_front(LUMBERMILL);

func build_mage_tower():
	_build_last(MAGE_TOWER);

func build_market():
	_build_mid(MARKET);

func build_mill():
	_build_front(MILL);

func build_mine():
	_build_front(MINE);

func build_quarry():
	_build_front(QUARRY);

func build_tavern():
	_build_mid(TAVERN);

func build_townhall():
	_build_last(TOWNHALL);

func build_siege_tower():
	_build_last(SIEGE_TOWER);

func build_watchtower():
	_build_last(WATCHTOWER);

#endregion

func _build_last(building: PackedScene) -> void:
	_build(building, last_grid);

func _build_mid(building: PackedScene) -> void:
	_build(building, mid_grid);

func _build_front(building: PackedScene) -> void:
	_build(building, front_grid);

func _build(building: PackedScene, row: GridRow):
	var inst: Building;
	if randf() > 0.5:
		inst = row.add_building_left(building);
	else:
		inst = row.add_building_right(building);

	if bulding_registry.has(inst.building_record.name):
		bulding_registry[inst.building_record.name] += 1;
	else:
		bulding_registry[inst.building_record.name] = 1;

	building_created.emit(inst);
